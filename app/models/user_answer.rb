class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchase
  belongs_to :question
  belongs_to :answer

  before_save :update_status

  scope :answers_for, ->(purchase) {includes(:question).where(purchase_id: purchase.id).order('questions.position ASC')}

  def self.ordered_answers_for(purchase)
    @user_answers = self.answers_for(purchase)
    return [] if @user_answers.empty?
    answers = []
    (1..@user_answers.last.question.position).each do |position|
      answers << @user_answers.find { |ua| ua.question.position == position }
    end
    answers
  end

  private

  def update_status
    if self.answer.position == self.question.answer
      self.status = 'right'
    else
      self.status = 'wrong'
    end     	
  end
end
