 require 'rails_helper'

RSpec.describe User, :type => :model do
    before { @user = User.new(email: "user@example.com", password:"123456", password_confirmation:"123456") }

    subject { @user }

    it { should respond_to(:email) }
    it { should be_valid }

    describe "when email address is already taken" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.save
      end

      it { should_not be_valid }
    end

end
