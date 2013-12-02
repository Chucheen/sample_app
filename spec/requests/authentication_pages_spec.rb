require 'spec_helper'

describe "Ahthentication" do
  subject { page }

  describe "signin page" do
    before { visit signin_path}

    it {should have_selector('title', text: 'Sign in')}

    describe "with invalid information" do
      before {click_button "Sign in"}
      it {should have_selector('h1', text: 'Sign in')}
      it {should have_selector('div.alert.alert-error', text: 'Incorrect login:')}

      describe "after visiting another page" do
        before { click_link "Home" }
        it { should_not have_selector('div.alert.alert-error') }
      end

    end

    describe "with valid information" do
      let(:user){FactoryGirl.create :user}
      before {
        fill_in "email", with: user.email
        fill_in "password", with: user.password
        click_button 'Sign in'
      }

      it {should have_selector 'h1', text: 'Sign in'}
      it {should have_link('Profile', href: user_path(user))}
      it {should have_link('Sign out', href:signout_path)}
      it {should have_link('Settings', href:edit_user_path(user))}
      it {should_not have_link('Sign in', href:signin_path)}

      describe 'followed by a sign out' do
        before {click_link 'Signout'}
        it {should have_link 'Sing in'}
      end
    end
  end
end