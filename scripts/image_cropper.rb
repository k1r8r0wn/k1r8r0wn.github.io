# frozen_string_literal: true

require 'mini_magick'
require 'base64'
require 'fileutils'

# ImageCropper class is responsible for cropping images and saving
# their cropped sections as base64 encoded files.
class ImageCropper
  OUTPUT_FOLDER = '_includes/headers'
  BASE_IMAGES_FOLDER = 'maps'
  TARGET_IMAGE_WIDTH = 1100
  TARGET_IMAGE_HEIGHT = 500

  attr_reader :language

  # Initializes a new ImageCropper instance.
  #
  # @param language [String] the language code ('ru' or 'en')
  def initialize(language)
    @language = language
  end

  # Processes the image cropping and base64 encoding.
  def process
    extracted_area = extract_area
    base64_image = encode_to_base64(extracted_area)
    create_and_save_file(base64_image)
  end

  private

  # Returns the base path for the source image.
  #
  # @return [String] the base path
  def base_path
    "#{BASE_IMAGES_FOLDER}/#{language}.jpg"
  end

  # Extracts the specified area from the image.
  #
  # @return [MiniMagick::Image] the extracted image area
  def extract_area
    # Load the image
    image = MiniMagick::Image.open(base_path)

    # Calculate maximum available coordinates for random selection
    max_x = image.width - TARGET_IMAGE_WIDTH
    max_y = image.height - TARGET_IMAGE_HEIGHT

    # Randomly choose area coordinates
    x = rand(max_x)
    y = rand(max_y)

    # Extract the area
    image.crop("#{TARGET_IMAGE_WIDTH}x#{TARGET_IMAGE_HEIGHT}+#{x}+#{y}")
  end

  # Encodes an image to base64.
  #
  # @param area_image [MiniMagick::Image] the image to encode
  # @return [String] the base64 encoded image
  def encode_to_base64(area_image)
    Base64.encode64(area_image.to_blob)
  end

  # Creates and saves a file with the provided base64 image data.
  #
  # @param base64_image [String] the base64 encoded image data
  def create_and_save_file(base64_image)
    # Create & save the base64 file
    today = Time.now.strftime('%Y-%m-%d')
    output_filename = "#{OUTPUT_FOLDER}/#{today}"

    File.open(output_filename, 'w') do |file|
      file.write(base64_image)
    end

    puts "Image successfully saved as #{output_filename}"
  end
end

language = ARGV[0]
if language && %w[ru en].include?(language)
  ImageCropper.new(language).process
else
  puts 'Please provide a valid argument of base image lang: ru or en.'
end
