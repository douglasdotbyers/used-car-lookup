require 'rails_helper'

describe UsedCar do

  before { @used_car = UsedCar.new }

  subject { @used_car }

  it { should respond_to(:registration) }
  it { should respond_to(:stock_reference) }

  # Validation of attribute presence.

  describe "when registration and stock_reference are not present" do
    it "should not be valid" do
      @used_car.registration = " "
      @used_car.stock_reference = " "
      should_not be_valid
    end
  end

  describe "when registration is not present" do
    it "should not be valid" do
      @used_car.registration = " "
      @used_car.stock_reference = "ARNXY-U-123"
      should_not be_valid
    end
  end

  describe "when stock_reference is not present" do
    it "should not be valid" do
      @used_car.registration = "AB12CDE"
      @used_car.stock_reference = " "
      should_not be_valid
    end
  end

  describe "when registration and stock_reference are present" do
    it "should be valid" do
      @used_car.registration = "AB12CDE"
      @used_car.stock_reference = "ARNXY-U-123"
      should be_valid
    end
  end

  # Validation of attribute length.

  describe "when registration is less than minimum valid length" do
    it "should not be valid" do
      @used_car.registration = "A" * (UsedCar::MIN_REGISTRATION_LENGTH - 1)
      @used_car.stock_reference = "ARNXY-U-123"
      should_not be_valid
    end
  end

  describe "when registration is equal to minimum valid length" do
    it "should be valid" do
      @used_car.registration = "A" * (UsedCar::MIN_REGISTRATION_LENGTH)
      @used_car.stock_reference = "ARNXY-U-123"
      should be_valid
    end
  end

  describe "when registration is more than minimum valid length" do
    it "should be valid" do
      @used_car.registration = "A" * (UsedCar::MIN_REGISTRATION_LENGTH + 1)
      @used_car.stock_reference = "ARNXY-U-123"
      should be_valid
    end
  end

  describe "when registration is less than maximum valid length" do
    it "should be valid" do
      @used_car.registration = "A" * (UsedCar::MAX_REGISTRATION_LENGTH - 1)
      @used_car.stock_reference = "ARNXY-U-123"
      should be_valid
    end
  end

  describe "when registration is equal to maximum valid length" do
    it "should be valid" do
      @used_car.registration = "A" * (UsedCar::MAX_REGISTRATION_LENGTH)
      @used_car.stock_reference = "ARNXY-U-123"
      should be_valid
    end
  end

  describe "when registration is more than maximum valid length" do
    it "should not be valid" do
      @used_car.registration = "A" * (UsedCar::MAX_REGISTRATION_LENGTH + 1)
      @used_car.stock_reference = "ARNXY-U-123"
      should_not be_valid
    end
  end

  describe "when stock_reference is less than minimum valid length" do
    it "should not be valid" do
      @used_car.registration = "AB12CDE"
      @used_car.stock_reference = "A" * (UsedCar::MIN_STOCK_REFERENCE_LENGTH - 1)
      should_not be_valid
    end
  end

  describe "when stock_reference is equal to minimum valid length" do
    it "should be valid" do
      @used_car.registration = "AB12CDE"
      @used_car.stock_reference = "A" * (UsedCar::MIN_STOCK_REFERENCE_LENGTH)
      should be_valid
    end
  end

  describe "when stock_reference is more than minimum valid length" do
    it "should be valid" do
      @used_car.registration = "AB12CDE"
      @used_car.stock_reference = "A" * (UsedCar::MIN_STOCK_REFERENCE_LENGTH + 1)
      should be_valid
    end
  end

  describe "when stock_reference is less than maximum valid length" do
    it "should be valid" do
      @used_car.registration = "AB12CDE"
      @used_car.stock_reference = "A" * (UsedCar::MAX_STOCK_REFERENCE_LENGTH - 1)
      should be_valid
    end
  end

  describe "when stock_reference is equal to maximum valid length" do
    it "should be valid" do
      @used_car.registration = "AB12CDE"
      @used_car.stock_reference = "A" * (UsedCar::MAX_STOCK_REFERENCE_LENGTH)
      should be_valid
    end
  end

  describe "when stock_reference is more than maximum valid length" do
    it "should not be valid" do
      @used_car.registration = "AB12CDE"
      @used_car.stock_reference = "A" * (UsedCar::MAX_STOCK_REFERENCE_LENGTH + 1)
      should_not be_valid
    end
  end

  # Validation of attribute format.

  describe "when registration is not of valid format" do
    it "should not be valid" do
      @used_car.registration = "A!!"
      @used_car.stock_reference = "ARNXY-U-123"
      should_not be_valid
    end
  end

  describe "when stock_reference is not of valid format" do
    it "should not be valid" do
      @used_car.registration = "AB12CDE"
      @used_car.stock_reference = "A!!"
      should_not be_valid
    end
  end

  # Tests for initialize.

  describe "when initialized with no values for registration and stock_reference" do
    it "should have no values for registration and stock_reference" do
      initialized_used_car = UsedCar.new
      expect(initialized_used_car.registration).to be_nil
      expect(initialized_used_car.stock_reference).to be_nil
    end
  end

  describe "when initialized with registration only" do
    it "should have registration only" do
      initialized_used_car = UsedCar.new(registration: "AB12CDE")
      expect(initialized_used_car.registration).to eq("AB12CDE")
      expect(initialized_used_car.stock_reference).to be_nil
    end
  end

  describe "when initialized with stock_reference only" do
    it "should have stock_reference only" do
      initialized_used_car = UsedCar.new(stock_reference: "ARNXY-U-123")
      expect(initialized_used_car.registration).to be_nil
      expect(initialized_used_car.stock_reference).to eq("ARNXY-U-123")
    end
  end

  describe "when initialized with registration and stock_reference" do
    it "should have registration and stock_reference" do
      initialized_used_car = UsedCar.new(registration: "AB12CDE" , stock_reference: "ARNXY-U-123")
      expect(initialized_used_car.registration).to eq("AB12CDE")
      expect(initialized_used_car.stock_reference).to eq("ARNXY-U-123")
    end
  end

  # Tests for image_urls.

  describe "when registration is of length 5" do
    it "should have correct image urls" do
      expected_image_urls = [UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "350" , :camera => "f" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "350" , :camera => "r" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "350" , :camera => "i" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "350" , :camera => "4" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "350" , :camera => "5" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "350" , :camera => "6" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "800" , :camera => "f" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "800" , :camera => "r" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "800" , :camera => "i" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "800" , :camera => "4" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "800" , :camera => "5" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ACR2N1XBYA1" , :size => "800" , :camera => "6" }]

      @used_car.registration = " AB 12 C "
      @used_car.stock_reference = " ARNXY-U-12345 "
      should be_valid
      expect(@used_car.image_urls).to eq(expected_image_urls)
    end
  end

  describe "when registration is of length 6" do
    it "should have correct image urls" do
      expected_image_urls = [UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "350" , :camera => "f" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "350" , :camera => "r" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "350" , :camera => "i" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "350" , :camera => "4" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "350" , :camera => "5" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "350" , :camera => "6" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "800" , :camera => "f" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "800" , :camera => "r" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "800" , :camera => "i" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "800" , :camera => "4" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "800" , :camera => "5" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "ADRCN2X1YB-A2" , :size => "800" , :camera => "6" }]

      @used_car.registration = " AB 12 CD "
      @used_car.stock_reference = " ARNXY-U-23456 "
      should be_valid
      expect(@used_car.image_urls).to eq(expected_image_urls)
    end
  end

  describe "when registration is of length 7" do
    it "should have correct image urls" do
      expected_image_urls = [UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "350" , :camera => "f" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "350" , :camera => "r" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "350" , :camera => "i" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "350" , :camera => "4" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "350" , :camera => "5" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "350" , :camera => "6" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "800" , :camera => "f" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "800" , :camera => "r" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "800" , :camera => "i" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "800" , :camera => "4" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "800" , :camera => "5" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AERDNCX2Y1-BUA3" , :size => "800" , :camera => "6" }]

      @used_car.registration = " AB12 CDE "
      @used_car.stock_reference = " ARNXY-U-34567 "
      should be_valid
      expect(@used_car.image_urls).to eq(expected_image_urls)
    end
  end

  describe "when registration is of length 8" do
    it "should have correct image urls" do
      expected_image_urls = [UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "350" , :camera => "f" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "350" , :camera => "r" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "350" , :camera => "i" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "350" , :camera => "4" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "350" , :camera => "5" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "350" , :camera => "6" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "800" , :camera => "f" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "800" , :camera => "r" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "800" , :camera => "i" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "800" , :camera => "4" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "800" , :camera => "5" },
                             UsedCar::BASE_IMAGE_URL % { :obfuscated_stock_reference => "AFRENDXCY2-1UB-A4" , :size => "800" , :camera => "6" }]

      @used_car.registration = " AB12CDEF "
      @used_car.stock_reference = " ARNXY-U-45678 "
      should be_valid
      expect(@used_car.image_urls).to eq(expected_image_urls)
    end
  end

  # Tests for obfuscated_stock_reference.

  describe "when registration is of length 5" do

    it "should have correct obfuscated_stock_reference" do
      @used_car.registration = " AB 12 C "
      @used_car.stock_reference = " ARNXY-U-12345 "
      should be_valid
      expect(@used_car.send(:obfuscated_stock_reference)).to eq("ACR2N1XBYA1")
    end

    it "should, regardless of case, have correct obfuscated_stock_reference" do
      @used_car.registration = " ab 12 C "
      @used_car.stock_reference = " aRnXy-U-12345 "
      should be_valid
      expect(@used_car.send(:obfuscated_stock_reference)).to eq("ACR2N1XBYA1")
    end

  end

  describe "when registration is of length 6" do

    it "should have correct obfuscated_stock_reference" do
      @used_car.registration = " AB 12 CD "
      @used_car.stock_reference = " ARNXY-U-23456 "
      should be_valid
      expect(@used_car.send(:obfuscated_stock_reference)).to eq("ADRCN2X1YB-A2")
    end

    it "should, regardless of case, have correct obfuscated_stock_reference" do
      @used_car.registration = " ab 12 CD "
      @used_car.stock_reference = " aRnXy-U-23456 "
      should be_valid
      expect(@used_car.send(:obfuscated_stock_reference)).to eq("ADRCN2X1YB-A2")
    end

  end

  describe "when registration is of length 7" do

    it "should have correct obfuscated_stock_reference" do
      @used_car.registration = " AB12 CDE "
      @used_car.stock_reference = " ARNXY-U-34567 "
      should be_valid
      expect(@used_car.send(:obfuscated_stock_reference)).to eq("AERDNCX2Y1-BUA3")
    end

    it "should, regardless of case, have correct obfuscated_stock_reference" do
      @used_car.registration = " ab12 CDE "
      @used_car.stock_reference = " aRnXy-U-34567 "
      should be_valid
      expect(@used_car.send(:obfuscated_stock_reference)).to eq("AERDNCX2Y1-BUA3")
    end

  end

  describe "when registration is of length 8" do

    it "should have correct obfuscated_stock_reference" do
      @used_car.registration = " AB12CDEF "
      @used_car.stock_reference = " ARNXY-U-45678 "
      should be_valid
      expect(@used_car.send(:obfuscated_stock_reference)).to eq("AFRENDXCY2-1UB-A4")
    end

    it "should, regardless of case, have correct obfuscated_stock_reference" do
      @used_car.registration = " ab12CDEF "
      @used_car.stock_reference = " aRnXy-U-45678 "
      should be_valid
      expect(@used_car.send(:obfuscated_stock_reference)).to eq("AFRENDXCY2-1UB-A4")
    end

  end

end
