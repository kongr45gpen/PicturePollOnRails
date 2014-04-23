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

	it { should have_link('Logout') }
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

  describe "edit profile" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in(user)
      visit profile_edit_path
    end


    describe "page" do
      it { should have_content("Update your profile") }
      it { should have_title("Edit") }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_username)  { "newname" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Username",              with: new_username.upcase
        fill_in "Email",                 with: new_email.upcase
        fill_in "Password",              with: user.password
        fill_in "Password Confirmation", with: user.password
        click_button "Save changes"
      end

      it { should have_title(new_username) }
      it { should have_selector('.ui.success.message') }
      it { should have_link('Logout', href: signout_path) }
      specify { expect(user.reload.username).to  eq new_username }
      specify { expect(user.reload.email).to     eq new_email }
    end
  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_title('Users') }
    it { should have_content('Users') }

    describe "pagination" do

      before(:all) { 50.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.ui.pagination.menu') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('div.item', text: user.username)
        end
      end
    end
  end

end
