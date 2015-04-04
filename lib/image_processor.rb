module ImageProcessor

  def write_img_file(data)
    img = Magick::Image.read_inline(data).first
    img.format = "png"
    f = File.open(File.join(File.dirname(__FILE__),"../images/#{SecureRandom.hex}.png"), 'w')
    img.write(f)
    f.close
  end

end
