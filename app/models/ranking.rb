class Ranking < ActiveRecord::Base
  scope :for, ->(exam) {where(exam_id: exam.id).order(performance: :desc)}
  belongs_to :user	
end
