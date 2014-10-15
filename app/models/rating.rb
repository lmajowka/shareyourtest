class Rating < ActiveRecord::Base
  belongs_to :exam
  belongs_to :user

  validates_uniqueness_of :user_id, :scope => :exam_id 
end
