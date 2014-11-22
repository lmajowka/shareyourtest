class Question < ActiveRecord::Base

  belongs_to :exam
  has_many :answers
  has_many :comments, as: :commentable, dependent: :destroy
  acts_as_list scope: :exam

  validates :content, presence:   true
  validates :answer, presence:   true, numericality: true
  validates_presence_of :exam

  def remove
    remove_from_list
    remove_answers    
    delete
  end

  def remove_answers
    Answer.where(question_id:id).destroy_all
  end  

end
