class Rating < ActiveRecord::Base
  belongs_to :exam
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :exam_id
  after_create :update_exam_number_of_ratings

  def update_exam_number_of_ratings
    exam.update(number_of_ratings: exam.ratings.size)
  end

end
