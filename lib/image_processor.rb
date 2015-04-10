module ImageProcessor

  def update_buffer(data, x_offset, y_offset)
    img = Magick::Image.read_inline(data).first
    desktop.composite!(img, x_offset, y_offset, Magick::OverCompositeOp)
  end

  def composite_op(args)
    img = img_from_buffer(args[0], args[1], args[2], args[3], args[4])
    desktop.composite!(img, args[7], args[8], Magick::OverCompositeOp)
  end

  def img_from_buffer(layer, src_x, src_y, src_width, src_height)
    if layer == 0
      desktop_copy = desktop.dup
      desktop_copy.crop(src_x, src_y, src_width, src_height)
    else
      puts "Buffer does not exist yet"
    end
  end

end
