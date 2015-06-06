require "bundler/setup"
Bundler.require

post '/translate' do
  tempfile = params['image'][:tempfile].read
  binarized_image = ImageBinarizer.perform(tempfile)
  RTesseract.new(binarized_image).to_s
end

class ImageBinarizer
  THRESHOLD = 29000

  def self.perform tempfile
    image = Magick::Image.from_blob(tempfile).first
    binarized = image.black_threshold(THRESHOLD)
    binarized.white_threshold(THRESHOLD)
  end
end
