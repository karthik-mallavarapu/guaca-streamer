module GuacHandler
  
  def error_instr(args)
    puts "Error instruction received: #{args}"
  end

  def args_instr(args)
    send_to_server(client_size_instr + client_audio_instr + client_video_instr +  client_connect_instr(args))
  end 

  def ready_instr(args)
    puts "Ready instruction received: #{args}"
  end

  def nest_instr(args)
    puts "Nest instruction received: #{args}"
  end

  def sync_instr(args)
    _, server_timestamp = args.join.split(".")
    client_timestamp = server_timestamp.to_i - 100
    send_to_server("4.sync,#{client_timestamp.to_s.size}.#{client_timestamp};")
  end

  def png_instr(args)
    _, layer = args[1].split(".")
    _, data = args[4].split(".")
    _, x_offset = args[2].split(".")
    _, y_offset = args[3].split(".")
    #puts "layer is #{layer}"
    update_desktop!(data, x_offset.to_i, y_offset.to_i )  if layer.to_i >= 0
  end

  def name_instr(args)
    puts "Name instruction received"
  end

  def dispose_instr(args)
    puts "Dispose instruction received: #{args.join}"
  end

  # Ignore nop instruction. Just to keep the connection alive.
  def nop_instr(args)
    puts "Nop instruction received"
    send_to_server("3.nop;")
  end

  def size_instr(args)
    _, layer = args[0].split(".")
    if layer.to_i == 0
      _, width = args[1].split(".")
      _, height = args[2].split(".")
      puts "size instruction received #{args.join(',')}"
      #resize_op!(width.to_i, height[0..-2].to_i)
    end
  end

  def copy_instr(args)
    parsed_args = args.map { |i| i.split(".").last.to_i }
    composite_op!(parsed_args) 
  end
  
  def method_missing(sym, *args, &block)
    puts "Method missing #{sym.to_s}"
  end

  def respond_to?(sym, include_private=false)
    true
  end

end
