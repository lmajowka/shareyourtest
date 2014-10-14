class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  after_initialize :assign_defaults

  scope :answered_for, -> (test_id) {where(status: "answered", exam_id:test_id).order(created_at: :desc)}

  def assign_defaults
    self.status ||= 'ready'
  end

end
