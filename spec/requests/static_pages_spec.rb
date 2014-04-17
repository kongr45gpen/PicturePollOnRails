require 'spec_helper'

describe "StaticPages" do

    describe "About page" do

        it "should have the content 'PicturePollOnRails App'" do
            visit '/static_pages/about'
            expect(page).to have_content('PicturePollOnRails App')
        end

        it "should have the title 'About'" do
            visit '/static_pages/about'
            expect(page).to have_title('About')
        end
    end
end
