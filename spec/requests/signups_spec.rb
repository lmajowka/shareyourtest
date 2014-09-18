require 'rails_helper'

RSpec.describe "Signups", :type => :request do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Join') }
    it { should have_title('Join Share your test right now!') }
  end

  describe "singup" do
    before { visit signup_path }

    let(:submit) { "Join now!" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
    end
  end

end
