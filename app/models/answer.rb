class Answer < ActiveRecord::Base

  belongs_to :question

  validates :content, presence: true
  validates_presence_of :question

end
