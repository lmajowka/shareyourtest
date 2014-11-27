class Ranking < ActiveRecord::Base
  validates_presence_of [:user, :exam]

  FOR_KEY = "reviews/%s/for"

  scope :for, ->(exam) {
    return @cached_result if @cached_result = Rails.cache.read(FOR_KEY % exam.id)
    scope = where(exam_id: exam.id).order(performance: :desc)
    Rails.cache.write(FOR_KEY % exam.id, scope, expires_in: 1.hour) && scope
  }
  belongs_to :user
  belongs_to :exam
end
