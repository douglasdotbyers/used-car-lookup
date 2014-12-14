class UsedCar

  include ActiveModel::Model

  attr_accessor :registration
  attr_accessor :stock_reference

  BASE_IMAGE_URL = "http://vcache.arnoldclark.com/imageserver/%{obfuscated_stock_reference}/%{size}/%{camera}"

  MIN_REGISTRATION_LENGTH = 5
  MIN_STOCK_REFERENCE_LENGTH = 10
  MAX_REGISTRATION_LENGTH = 10
  MAX_STOCK_REFERENCE_LENGTH = 20
  VALID_REGISTRATION_REGEX  = /\A[A-Za-z0-9\s\-]*\z/
  VALID_STOCK_REFERENCE_REGEX  = /\A[A-Za-z0-9\s\-]*\z/

  validates :registration,
    presence: true,
    length: { minimum: MIN_REGISTRATION_LENGTH , maximum: MAX_REGISTRATION_LENGTH },
    format: { with: VALID_REGISTRATION_REGEX }
  validates :stock_reference,
    presence: true,
    length: { minimum: MIN_STOCK_REFERENCE_LENGTH , maximum: MAX_STOCK_REFERENCE_LENGTH },
    format: { with: VALID_STOCK_REFERENCE_REGEX }

  def initialize(attributes = {})
    @registration = attributes[:registration]
    @stock_reference = attributes[:stock_reference]
  end

  def image_urls

    urls = []

    osr = obfuscated_stock_reference

    SIZE_VALUES.each do |size|
      CAMERA_VALUES.each do |camera|
        urls << BASE_IMAGE_URL % { :obfuscated_stock_reference => osr , :size => size , :camera => camera }
      end
    end

    return urls

  end

private

  SIZE_VALUES = ["350",
                 "800"]

  CAMERA_VALUES = ["f",
                   "r",
                   "i",
                   "4",
                   "5",
                   "6"]

  def obfuscated_stock_reference

    # remove all whitespace from @registration.
    stripped_registration = @registration.gsub(/\s+/ , "")

    # remove all whitespace from @stock_reference.
    stripped_stock_reference = @stock_reference.gsub(/\s+/ , "")

    # take .reverse of stripped_registration, and convert to char array.
    char_array_registration = stripped_registration.reverse.split("")

    # take [0 ... stripped_registration.length] of stripped_stock_reference, and convert to char array.
    char_array_stock_reference = stripped_stock_reference[0 ... stripped_registration.length].split("")

    # interleave char arrays, flatten resulting 2D array to 1D array, combine elements to form string, append char from stripped_stock_reference, and convert to uppercase.
    char_array_stock_reference.zip(char_array_registration).flatten.join.concat(stripped_stock_reference[8]).upcase

  end

end
