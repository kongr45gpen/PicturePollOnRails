require 'spec_helper'

describe "StaticPages" do

    subject { page }

    describe "About page" do
      before { visit about_path }

	it { should have_content('PicturePollOnRails App') }
	it { should have_title('| About') }
	it "should have the base title" do
            expect(page).to have_title('Picture Poll')
        end

    end
end
