require 'rails_helper'

describe ApplicationHelper do

  describe "full_title" do

    it "should be correct for page title ''" do
      expect(full_title("")).to eq("Arnold Clark Used Car Lookup")
    end

    it "should be correct for page title 'Test 1'" do
      expect(full_title("Test 1")).to eq("Test 1 | Arnold Clark Used Car Lookup")
    end

    it "should be correct for page title 'Test 2'" do
      expect(full_title("Test 2")).to eq("Test 2 | Arnold Clark Used Car Lookup")
    end

    it "should be correct for page title 'Test 3'" do
      expect(full_title("Test 3")).to eq("Test 3 | Arnold Clark Used Car Lookup")
    end

  end

end
