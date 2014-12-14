require 'rails_helper'

describe "Used Cars" do

  subject { page }

  describe "Index page" do

    before { visit index_path }

    it { should have_title(full_title("Used Car Lookup")) }
    it { should have_content("Used Car Lookup") }
    it { should have_field("Registration") }
    it { should have_field("Stock Reference") }
    it { should have_selector("input[type='submit'][value='Search']") }
    it { should have_link("Arnold Clark", href: "http://www.arnoldclark.com/") }

    describe "when user input is blank" do
      it "should display appropriate messages" do
        fill_in "Registration", with: ""
        fill_in "Stock Reference", with: ""
        click_button "Search"

        expect(current_path).to start_with('/search')

        should have_selector("div[class='alert alert-danger']", text: "errors")
        should have_content("Registration can't be blank")
        should have_content("Stock Reference can't be blank")
        expect(find_field("Registration").value).to eq("")
        expect(find_field("Stock Reference").value).to eq("")
      end
    end

    describe "when user input is invalid" do
      it "should display appropriate messages" do
        fill_in "Registration", with: "ABC"
        fill_in "Stock Reference", with: "DEF"
        click_button "Search"

        expect(current_path).to start_with('/search')

        should have_selector("div[class='alert alert-danger']", text: "errors")
        should have_content("Registration is too short")
        should have_content("Stock Reference is too short")
        expect(find_field("Registration").value).to eq("ABC")
        expect(find_field("Stock Reference").value).to eq("DEF")
      end
    end

    describe "when user input is valid" do
      it "should display images" do
        fill_in "Registration", with: "AB12CDEF"
        fill_in "Stock Reference", with: "ARNXY-U-45678"
        click_button "Search"

        expect(current_path).to start_with('/search')

        should have_selector("div[class='alert alert-success']", text: "Success")
        expect(find_field("Registration").value).to eq("AB12CDEF")
        expect(find_field("Stock Reference").value).to eq("ARNXY-U-45678")

        UsedCar.new(registration: "AB12CDEF" , stock_reference: "ARNXY-U-45678").image_urls.each do |image_url|
          should have_selector("img[src='#{image_url}']")
        end
      end
    end

  end

  describe "Search page" do

    before { visit '/search?used_car[registration]=&used_car[stock_reference]=' }

    it { should have_title(full_title("Used Car Lookup")) }
    it { should have_content("Used Car Lookup") }
    it { should have_field("Registration") }
    it { should have_field("Stock Reference") }
    it { should have_selector("input[type='submit'][value='Search']") }
    it { should have_link("Arnold Clark", href: "http://www.arnoldclark.com/") }

    describe "when params are blank" do
      it "should display appropriate messages" do
        visit '/search?used_car[registration]=&used_car[stock_reference]='

        should have_selector("div[class='alert alert-danger']", text: "errors")
        should have_content("Registration can't be blank")
        should have_content("Stock Reference can't be blank")
        expect(find_field("Registration").value).to eq("")
        expect(find_field("Stock Reference").value).to eq("")
      end
    end

    describe "when params are invalid" do
      it "should display appropriate messages" do
        visit '/search?used_car[registration]=ABC&used_car[stock_reference]=DEF'

        should have_selector("div[class='alert alert-danger']", text: "errors")
        should have_content("Registration is too short")
        should have_content("Stock Reference is too short")
        expect(find_field("Registration").value).to eq("ABC")
        expect(find_field("Stock Reference").value).to eq("DEF")
      end
    end

    describe "when params are valid" do
      it "should display images" do
        visit '/search?used_car[registration]=AB12CDEF&used_car[stock_reference]=ARNXY-U-45678'

        should have_selector("div[class='alert alert-success']", text: "Success")
        expect(find_field("Registration").value).to eq("AB12CDEF")
        expect(find_field("Stock Reference").value).to eq("ARNXY-U-45678")

        UsedCar.new(registration: "AB12CDEF" , stock_reference: "ARNXY-U-45678").image_urls.each do |image_url|
          should have_selector("img[src='#{image_url}']")
        end
      end
    end

  end

end
