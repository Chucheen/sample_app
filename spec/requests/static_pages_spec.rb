require 'spec_helper'

#require_relative '../spec_helper'

describe "Static pages" do
  subject { page }
  let(:base_title) {"Ruby on Rails Tutorial Sample App"}

  describe "Home page" do

    before { visit root_path }

    it { should have_selector('h1', :text => 'Sample App') }

    it { should have_selector( 'title', :text => getFullTitle('') ) }

    it { should_not have_selector('title', :text => "Home") }

  end

  describe "Help page" do
    before {visit help_path}

    it { should have_content('Help') }

    it { should have_selector('title', :text => getFullTitle('Help')) }

  end

  describe "About page" do
    before {visit about_path}

    it { should have_content('About Us') }

    it { should have_selector('title', :text => getFullTitle('About us')) }

  end

  describe "Contact" do
    before {visit contact_path}

    it { should have_content('Contact') }

    it { should have_selector('title', :text => getFullTitle('Contact')) }
  end
end

#require 'spec_helper'
#
#describe "StaticPages" do
#  describe "GET /static_pages" do
#    it "works! (now write some real specs)" do
#      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
#      get static_pages_index_path
#      response.status.should be(200)
#    end
#  end
#end
