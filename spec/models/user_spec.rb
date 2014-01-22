# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe User do
  before {@user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")}

  subject{@user}

  it{ should respond_to(:name)}
  it{ should respond_to(:email)}
  it{ should respond_to(:password_digest)}
  it{ should respond_to(:password)}
  it{ should respond_to(:password_confirmation)}
  it{ should respond_to(:authenticate)}
  it{ should respond_to(:remember_token) }
  it{ should respond_to(:admin) }
  it{ should respond_to(:authenticate) }
  it{ should respond_to(:microposts) }

  #pending "add some examples to (or delete) #{__FILE__}"
  it {should be_valid }
  it {should_not be_admin }

  describe "with admin attribute set to true" do
    before {
      @user.toggle!(:admin)

      it {should be_admin}
    }
  end

  describe "When name is not present" do
    before {@user.name = ""}
    it { should_not be_valid }
  end

  describe "When emails is not present" do
    before {@user.email = " "}
    it { should_not be_valid }
  end

  describe {'When name is too long'
    before {@user.name = 'a' * 51}
    it {should_not be_valid}
  }

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
      @user.email = invalid_address
      @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
      @user.email = valid_address
      @user.should be_valid
      end
    end
  end

  describe "when email is duplicated" do
    before do
      user_duplicated = @user.dup
      user_duplicated.email = @user.email.upcase
      user_duplicated.save
    end
    it {should_not be_valid}
  end

  describe "when password is not present" do
    before {@user.password = @user.password_confirmation = " " }
    it{ should_not be_valid}
  end

  describe "When passowrd don't match" do
    before {@user.password = "mismatch"}
    it {should_not be_valid}
  end

  describe "When password or confirmations are nil" do
    before {@user.password = @user.password_confirmation = nil}
    it {should_not be_valid}
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  describe "When password or confirmation is too short" do
    before {@user.password = @user.password_confirmation = "a"*5}
    it {should_not be_valid}
  end

  describe "remember token" do
    before do
      @user.save
    end

    its(:remember_token){should_not be_blank}
  end

  describe "micropost associations" do
    before {@user.save}

    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end

    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the same micropost in the same order" do
      @user.microposts.should == [newer_micropost, older_micropost]
    end

    it "should destroy associated micropost" do
      microposts = @user.microposts
      @user.destroy
      microposts.each do |micropost|
        Micropost.find_by_id(micropost.id).should be_nil
      end
    end
  end

end
