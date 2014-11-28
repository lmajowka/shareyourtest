class Purchase < ActiveRecord::Base
  belongs_to :user
  belongs_to :exam

  after_initialize :assign_defaults
  before_update :calculate_performance

  scope :answered_for, ->(test_id) {where(status: "answered", exam_id:test_id).order(created_at: :desc)}


  protected

  def assign_defaults
    self.status ||= 'ready'
  end


  def calculate_performance
  	total_answers = Question.where(exam_id:exam_id).count.to_f
    right_user_answers = UserAnswer.where(purchase_id:id, status: 'right').count.to_f
    self.performance = 0 if total_answers == 0
    self.performance =  (right_user_answers/total_answers).round(2)
    update_ranking
    update_badge
  end

  def update_ranking
    ranking = Ranking.find_or_create_by(user_id: self.user_id, exam_id: self.exam_id)
    if ranking.performance.nil?
      ranking.update!(performance: self.performance)
    end
  end

  def update_badge
    badge = Badge.find_or_create_by(user_id: self.user_id, exam_id: self.exam_id)
    return if badge == "gold"
    return badge.update!(badge: "gold") if self.performance >= 0.9
    return if badge == "silver"
    return badge.update!(badge: "silver") if self.performance >= 0.8
    return if badge == "bronze"
    return badge.update!(badge: "bronze") if self.performance >= 0.7
  end

end
