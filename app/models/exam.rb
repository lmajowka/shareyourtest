class Exam < ActiveRecord::Base

  belongs_to :user
  has_many :questions, -> { order("position ASC") }

  validates :title, presence: true, length: { minimum: 6 }
  validates :description, presence: true,length: { minimum: 6 }
  validates_presence_of :user

end
