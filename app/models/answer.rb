class Answer < ActiveRecord::Base

  belongs_to :question

  validates :content, presence: true
  validates_presence_of :question

  acts_as_list scope: :question

end
