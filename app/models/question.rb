class Question < ActiveRecord::Base
  belongs_to :test

  validates :content, presence:   true
  validates :answer, presence:   true, numericality: true
  validates_presence_of :test

end
