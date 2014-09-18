require 'rails_helper'

RSpec.describe "Authentication", :type => :request do

    subject { page }

    describe "signin page" do
      before { visit signin_path }

      it { should have_content('Sign in') }
      it { should have_title('Sign in') }

      describe "with invalid information" do
        before { click_button "Sign in" }

        it { should have_selector('div.alert.alert-error') }
      end

      describe "with valid information" do
        let(:user) { FactoryGirl.create(:user) }
        before do
          fill_in "Email",    with: user.email.upcase
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        it { should have_link('Sign out',    href: signout_path) }
        it { should_not have_link('Sign in', href: signin_path) }
      end


    end

  end
