require 'spec_helper'

describe "User pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    let(:submit) { "Create my account" }

    describe "with invalid information" do
      it "should not create a user" do
	expect { click_button submit }.not_to change(User, :count)
      end

      describe "after submission" do
	before { click_button submit }

	it { should have_title('Sign up') }
	it { should have_content('error') }
      end
    end

    describe "with valid information" do
      before do
	fill_in "Username",		 with: "mynewuser"
	fill_in "Email",		 with: "newuser@example.com"
	fill_in "Password",		 with: "testpass1234"
	fill_in "Password Confirmation", with: "testpass1234"
      end

      it "should create a user" do
	expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
	before { click_button submit }
	let(:user) { User.find_by(email: 'newuser@example.com') }

	it { should have_title(user.username) }
	it { should have_selector('div.success.message', text: 'Welcome') }
      end
    end

    it { should have_content('Sign up') }
    it { should have_title(full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }

    it { should have_content(user.username) }
    it { should have_title(user.username) }
  end
end
