module GuacHandler
  
  def error_instr(args)
    #puts "Error instruction received: #{args}"
  end

  def args_instr(args)
    #puts "#{args} args_instr"
    send_to_server(client_size_instr+client_audio_instr+client_video_instr+client_connect_instr(args))
  end 

  def ready_instr(args)
    #puts "Ready instruction received: #{args}"
  end

  def nest_instr(args)
    #puts "Nest instruction received: #{args}"
  end

  def sync_instr(args)
    t = Time.now.to_i
    send_to_server("4.sync,#{t.to_s.size}.#{t};")
  end

  def png_instr(args)
    #puts "Png instruction received"
  end

  def name_instr(args)
    #puts "Name instruction received"
  end

  def dispose_instr(args)
    #puts "Dispose instruction received: #{args.join}"
  end

  # Ignore nop instruction. Just to keep the connection alive.
  def nop_instr(args)
    #puts "Nop instruction received"
    send_to_server("3.nop;")
  end

  def size_instr(args)
    #puts "Layer: #{args[0]}"
    #puts "Width: #{args[1]}"
    #puts "Height: #{args[2]}"
  end
  
  def method_missing(sym, *args, &block)
    #puts sym
  end

  def respond_to?(sym, include_private=false)
    true
  end

end
