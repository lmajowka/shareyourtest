class Exam < ActiveRecord::Base

  STATUSES = ['draft', 'published']

  scope :published, -> {where(status: "published")}

  belongs_to :owner, class_name: "User", foreign_key: :user_id 
  has_many :purchases
  has_many :users, through: :purchases
  has_many :questions, -> { order("position ASC") }
  has_many :ratings
  has_permalink
  has_attached_file :picture, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  } , default_url: 'nopicture.jpg'

  
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true,length: { minimum: 6 }
  validates_presence_of :owner
  validates_inclusion_of :status, in: STATUSES
  validates_numericality_of :price

  after_initialize :assign_defaults

  def average_rating
    return 0 if ratings.size == 0
    ratings.sum(:score) / ratings.size
  end

  def number_of_ratings
    Rating.where(exam_id:id).size
  end

  private

  def assign_defaults
    self.status ||= 'draft'
    self.price ||= 0
  end  

end
