require 'rails_helper'

RSpec.describe User, :type => :model do
    before { @user = User.new(name:"michael iceberg",email: "user@example.com", password:"123456", password_confirmation:"123456") }

    subject { @user }

    it { should respond_to(:email) }
    it { should respond_to(:remember_token) }
    it { should respond_to(:authenticate) }

    it { should be_valid }

    describe "remember token" do
      before { @user.save }
      its(:remember_token) { should_not be_blank }
    end

    describe "when email address is already taken" do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.save
      end

      it { should_not be_valid }
    end

    describe '#purchase' do

      before do
       @user.save
       @exam = @user.created_exams.create!(title:"sample exam", description:"description") 
      end
      
      it 'should aquire an exam' do
        expect { @user.purchase_exam @exam }.to change{@user.purchases.count}.by(1)
      end

    end

end
