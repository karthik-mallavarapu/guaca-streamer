module ImageProcessor

  def update_buffer(data, x_offset, y_offset)
    img = Magick::Image.read_inline(data).first
    desktop.composite!(img, x_offset, y_offset, Magick::OverCompositeOp)
    f = File.open(File.join(File.dirname(__FILE__),"../images/#{Time.now.to_i}.png"), 'w')
    desktop.write(f)
    f.close
  end

  def composite_op(mask, layer, x_offset, y_offset)
    #TODO
  end

end
