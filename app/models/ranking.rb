class Ranking < ActiveRecord::Base
  validates_presence_of [:user, :exam]

  scope :for, ->(exam) {where(exam_id: exam.id).order(performance: :desc)}
  belongs_to :user
  belongs_to :exam
end
