class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  after_initialize :assign_defaults

  def assign_defaults
    self.status ||= 'ready'
  end

end
