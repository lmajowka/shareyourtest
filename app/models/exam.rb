class Exam < ActiveRecord::Base

  STATUSES = ['draft', 'published']
  AVERAGE_PERFORMANCE_KEY = "tests/%s/average_performance"
  AVERAGE_RATING_KEY = "tests/%s/average_rating"
  PUBLISHED_KEY = "tests/published"

  scope :published, -> { where(status: "published") }

  belongs_to :owner, class_name: "User", foreign_key: :user_id
  belongs_to :exam_category
  has_many :purchases
  has_many :users, through: :purchases
  has_many :questions, -> { order("position ASC") }
  has_many :comments, through: :questions
  has_many :ratings
  has_many :reviews
  has_many :invoices
  has_permalink :title, true
  has_attached_file :picture, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  } , default_url: 'nopicture.jpg'
  searchkick
  
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates :title, presence: true,
            length: { minimum: 3 }
  validates :description, presence: true,length: { minimum: 6 }
  validates_presence_of :owner
  validates_inclusion_of :status, in: STATUSES
  validates_numericality_of :price

  after_initialize :assign_defaults

  scope :number_of_comments_for, ->(id){
    includes(:questions).includes(:comments).where(id:id).count('comments.id')
  }

  def average_rating
    return @cached_result if @cached_result = Rails.cache.read(AVERAGE_RATING_KEY % permalink)
    ar = ratings.size == 0 ? 0 : ratings.sum(:score) / ratings.size
    Rails.cache.write(AVERAGE_RATING_KEY % permalink, ar, expires_in: 1.day) && ar
  end

  def pluralize_number_of_ratings
    "#{number_of_ratings} #{'rating'.pluralize(number_of_ratings)}"
  end

  def populate
    users_ids = 10.times.map{ 183 + Random.rand(50) }
    users_ids.each do |uid|
      Ranking.create(user_id: uid, exam_id: id, performance: (0.6 + Random.rand(0.4)))
      Rails.cache.delete(Ranking::FOR_KEY % id)
    end
  end

  def average_performance
    return @cached_result if @cached_result = Rails.cache.read(AVERAGE_PERFORMANCE_KEY % permalink)
    ap = purchases.where('performance is not null').group(:performance).count
    Rails.cache.write(AVERAGE_PERFORMANCE_KEY % permalink, ap, expires_in: 1.day) && ap
  end

  def self.all_published
    return @cached_result if @cached_result = Rails.cache.read(PUBLISHED_KEY)
    p = includes(:exam_category).published.limit(9)
    Rails.cache.write(PUBLISHED_KEY, p, expires_in: 1.hour) && p
  end

  def paypal_url(host,return_path,current_user)

    invoice = Invoice.create(amount: price, item_number: id, user_id: current_user.id)

    values = {
      business: "donations@shareyourtest.com",
      cmd: "_xclick",
      upload: 1,
      return: "#{host}#{return_path}",
      invoice: "xy #{invoice.id}",
      amount: price,
      item_name: title,
      item_number: id,
      quantity: '1',
      notify_url: "#{host}/hook"
    }
    paypal_host = Rails.env.production? ? "https://www.paypal.com" : "https://www.sandbox.paypal.com"
    "#{paypal_host}/cgi-bin/webscr?" + values.to_query
  end

  private

  def assign_defaults
    self.status ||= 'draft'
    self.price ||= 0
  end  

end
