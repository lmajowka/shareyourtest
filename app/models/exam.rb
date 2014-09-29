class Exam < ActiveRecord::Base

  belongs_to :user
  has_many :questions, -> { order("position ASC") }
  scope :published, -> {where(status: "published")}
  has_attached_file :picture, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
  } , default_url: 'nopicture.jpg'

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/

  validates :title, presence: true, length: { minimum: 6 }
  validates :description, presence: true,length: { minimum: 6 }
  validates_presence_of :user
  validates_inclusion_of :status, :in => %w( draft published )

end
