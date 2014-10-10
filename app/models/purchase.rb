class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  validates_uniqueness_of :exam, scope: :user
end
