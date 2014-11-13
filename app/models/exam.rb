class Exam < ActiveRecord::Base

  STATUSES = ['draft', 'published']

  scope :published, -> {where(status: "published")}

  belongs_to :owner, class_name: "User", foreign_key: :user_id
  belongs_to :exam_category
  has_many :purchases
  has_many :users, through: :purchases
  has_many :questions, -> { order("position ASC") }
  has_many :ratings
  has_many :reviews
  has_permalink
  has_attached_file :picture, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  } , default_url: 'nopicture.jpg'

  
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates :title, presence: true,
            length: { minimum: 3 }
  validates :description, presence: true,length: { minimum: 6 }
  validates_presence_of :owner
  validates_inclusion_of :status, in: STATUSES
  validates_numericality_of :price

  after_initialize :assign_defaults
  before_validation :check_permalink_uniqueness, on: :create

  def average_rating
    return 0 if ratings.size == 0
    ratings.sum(:score) / ratings.size
  end

  def number_of_ratings
    Rating.where(exam_id:id).size
  end

  def pluralize_number_of_ratings
    "#{number_of_ratings} #{'rating'.pluralize(number_of_ratings)}"
  end

  private

  def assign_defaults
    self.status ||= 'draft'
    self.price ||= 0
  end  

  def check_permalink_uniqueness
    if self.permalink and Exam.where(permalink: self.permalink.parameterize).count > 0
      random_string = (0...3).map { ('a'..'z').to_a[rand(26)] }.join
      self.permalink += "-#{random_string}"
    end
  end

end
