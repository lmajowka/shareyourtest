class ExamCategory < ActiveRecord::Base

  has_many :exams
  has_many :embeddables
  has_permalink :name, true

  scope :ordered_by_size, -> { joins(:exams).order('count(exams.id) DESC').group('exam_categories.id') }
  scope :located_for,  ->(country) { where(country: country) }

  private

end
