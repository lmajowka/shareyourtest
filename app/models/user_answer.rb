class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchase
  belongs_to :question
  belongs_to :answer

  scope :answers_for, -> (purchase) {includes(:question).where(purchase_id: purchase.id).order('questions.position ASC')	}
end
