require 'spec_helper'

describe Micropost do
  let(:user){FactoryGirl.create :user}
  before do
    @micropost = user.microposts.build(content: 'lorem ipsum dolo')
  end

  subject{@micropost}

  it { should respond_to :content }
  it { should respond_to :user_id }
  it { should respond_to(:user) }
  its(:user) { should == user }

  it { should be_valid }

  describe "when user id is not valid" do
    before { @micropost.user_id =  nil }
    it { should_not be_valid }
  end

  describe "accesible attributes" do
    it "should not allow acces to user_id" do
      expect do
        Micropost.new(content: 'lorem ipsum dolo', user_id: user.id)
      end.should raise_error(ActiveModel::MassAssignmentSecurity::Error)
    end
  end

  describe "when user is not present" do
    before {@micropost.user_id = nil}
    it{ should_not be_valid}
  end

end
