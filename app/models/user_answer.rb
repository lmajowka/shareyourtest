class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :purchase
  belongs_to :question
  belongs_to :answer

  scope :answers_for, -> (purchase) {where(purchase_id: purchase.id)}
end
