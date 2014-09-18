class Test < ActiveRecord::Base

  validates :title, presence: true, length: { minimum: 6 }
  validates :description, presence: true,length: { minimum: 6 }

end
