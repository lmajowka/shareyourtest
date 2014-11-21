class ExamCategory < ActiveRecord::Base

  has_many :exams
  has_permalink :name

  before_validation :check_permalink_uniqueness, on: :create

  scope :ordered_by_size, -> { joins(:exams).order('count(exams.id) DESC').group('exam_categories.id') }

  private

  def check_permalink_uniqueness
    if self.permalink and Exam.where(permalink: self.permalink.parameterize).count > 0
      random_string = (0...3).map { ('a'..'z').to_a[rand(26)] }.join
      self.permalink += "-#{random_string}"
    end
  end

end
