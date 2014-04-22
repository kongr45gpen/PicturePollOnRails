require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with no information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_link('Login', href: signin_path) }
      it { should have_error_message }

      describe "after visiting another page" do
	before { click_link "Pictures" }
	it { should_not have_error_message }
      end
    end

    describe "with invalid username" do
      before do
        fill_in "Username",         with: 'noOne'
        fill_in "Password",         with: '64322645'
        click_button "Sign in"
      end

      it { should have_title('Sign in') }
      it { should have_link('Login', href: signin_path) }
      it { should have_error_message("Invalid username") }
    end

    describe "with incorrect password" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Username",         with: user.username
        fill_in "Password",         with: "nope"
        click_button "Sign in"
      end

      it { should have_title('Sign in') }
      it { should have_link('Login', href: signin_path) }
      it { should have_error_message("Incorrect password") }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_title(user.username) }
      it { should have_link('Profile',	      href: user_path(user)) }
      it { should have_link('Settings',       href: profile_edit_path) }
      it { should have_link('Logout',	      href: signout_path) }
      it { should_not have_link('Login',      href: signin_path) }

      describe "followed by signout" do
	before { click_link "Logout" }
	it { should have_link('Login') }
      end
    end

  end
end
