require 'spec_helper'

describe "User Pages" do
  subject { page }

  describe "signup pages" do
    before {visit signup_path}

    it {should have_selector('h1', text: 'Sign up')}
    it {should have_selector('title', text: getFullTitle('Sign up')) }
  end

end
