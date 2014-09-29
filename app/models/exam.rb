class Exam < ActiveRecord::Base

  belongs_to :user
  has_many :questions, -> { order("position ASC") }
  scope :published, -> {where(status: "published")}

  validates :title, presence: true, length: { minimum: 6 }
  validates :description, presence: true,length: { minimum: 6 }
  validates_presence_of :user
  validates_inclusion_of :status, :in => %w( draft published )

end
