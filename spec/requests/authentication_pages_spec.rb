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

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit profile_edit_path(user)
          valid_signin(user)
        end

        describe "after signing in" do

          it "should render the desired protected page" do
            expect(page).to have_title('Edit user')
          end
        end
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title('Sign in') }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end

        describe "visiting the profile page" do
          before { get profile_edit_path }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user,
                         username: "wronguser",
                         email:    "wrong@user.com") }
      before { sign_in user, no_capybara: true }

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end
end
