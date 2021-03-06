require 'spec_helper'

describe User do
  before { @user = User.new(username: "exampleuser",
                            email: "sample@test.com",
                            password: "test1234",
                            password_confirmation: "test1234"
                           ) }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:remember_token) }
  it { should respond_to(:authenticate) }
  it { should be_valid }

  describe "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { @user.username = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when username is already taken" do
    before do
      user_with_same_username = @user.dup
      user_with_same_username.username = @user.username.upcase
      user_with_same_username.save
    end

    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "when password is not present" do
    before do
      @user = User.new(username: "exampleuserwithoutpass",
                       email: "valid@email.com",
                       password: " ",
                       password_confirmation: " "
                      )
    end

    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "otherpass" }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by(username: @user.username) }

    describe "with valid password" do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "username with mixed case" do
    let(:mixed_case_username) { "sAmPlETEstUsEr" }

    it "should be saved as all lower-case" do
      @user.username = mixed_case_username
      @user.save
      expect(@user.reload.username).to eq mixed_case_username.downcase
    end
  end

  describe "email with mixed case" do
    let(:mixed_case_email) { "sAmPlEeMaiLADDress@eXAMple.CoM" }

    it "should be saved as all lower-case" do
      @user.email = mixed_case_email
      @user.save
      expect(@user.reload.email).to eq mixed_case_email.downcase
    end
  end

  describe "invalid email" do

    describe "that looks like a username" do
      before { @user.email = "thisisnotamail" }
      it { should be_invalid }
    end

    describe "that has no dot" do
      before { @user.email = "thisis@notanemailcom" }
      it { should be_invalid }
    end

    describe "that has no @ sign" do
      before { @user.email = "thisisnotanemail.com" }
      it { should be_invalid }
    end

    describe "that has a double dot" do
      before { @user.email = "thisis@notemail..com" }
      it { should be_invalid }
    end
  end

  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end
