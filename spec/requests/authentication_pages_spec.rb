require 'rails_helper'

RSpec.describe "Authentication", :type => :request do

    subject { page }

    describe "signin page" do
      before { visit signin_path }

      describe "with invalid information" do
        before { click_button "Sign in" }

        it { should have_selector('div.alert.alert-error') }
      end

      it { should have_content('Sign in') }
      it { should have_title('Sign in') }
    end

  end
