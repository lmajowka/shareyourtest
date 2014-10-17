class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchase
  belongs_to :question
  belongs_to :answer

  before_save :update_status

  scope :answers_for, -> (purchase) {includes(:question).where(purchase_id: purchase.id).order('questions.position ASC')}

  private

  def update_status
    if self.answer.position == self.question.answer
      self.status = 'right'
    else
      self.status = 'wrong'
    end     	
  end

end
