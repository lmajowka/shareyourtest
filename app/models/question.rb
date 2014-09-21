class Question < ActiveRecord::Base

  belongs_to :exam

  validates :content, presence:   true
  validates :answer, presence:   true, numericality: true
  validates_presence_of :exam

end
