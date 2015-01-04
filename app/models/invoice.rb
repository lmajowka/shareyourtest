class Invoice < ActiveRecord::Base
  belongs_to :user
  has_one :exam
end
