class User < ActiveRecord::Base

  has_many :created_exams, class_name: "Exam"
  has_many :purchases
  has_many :exams, through: :purchases
  has_many :ratings

  before_create :create_remember_token
  before_save { self.email = email.downcase }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true,
            format:     { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }
  validates :name, presence: true, length: { minimum: 6 }

  has_secure_password validations: false

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def purchase_exam(exam)
    Purchase.create!(exam_id: exam.id, user_id: id, price: exam.price)
  end

  def get_ready_purchase(exam)
    Purchase.find_by(exam_id: exam.id, user_id: id, status: "ready") 
  end  

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end
