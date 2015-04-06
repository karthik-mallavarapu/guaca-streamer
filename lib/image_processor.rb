module ImageProcessor

  def update_buffer(data, x_offset, y_offset)
    img = Magick::Image.read_inline(data).first
    desktop.composite!(img, x_offset, y_offset, Magick::OverCompositeOp)
    f = File.open(File.join(File.dirname(__FILE__),"../images/#{SecureRandom.hex}.png"), 'w')
    desktop.write(f)
    f.close
  end

end
