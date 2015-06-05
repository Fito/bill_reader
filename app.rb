require "bundler/setup"
Bundler.require

post '/translate' do
  tempfile = params['image'][:tempfile].read
  image = Magick::Image.from_blob(tempfile).first
  bw = image.black_threshold(29000, 29000, 29000)
  bw = bw.white_threshold(29000, 29000, 29000)

  ticket = RTesseract.new(bw)
  ticket.to_s
end
