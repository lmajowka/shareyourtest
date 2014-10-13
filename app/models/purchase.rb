class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam
  validates_uniqueness_of :exam, scope: :user

  after_initialize :assign_defaults

  def assign_defaults
    self.status ||= 'ready'
  end

end
