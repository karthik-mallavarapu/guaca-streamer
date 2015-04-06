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
    _, buffer = args[1].split(".")
    _, data = args[4].split(".")
    _, x_offset = args[2].split(".")
    _, y_offset = args[3].split(".")
    puts "Buffer is #{buffer}"
    update_buffer(data, x_offset.to_i, y_offset.to_i )  if buffer.to_i >= 0
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
    puts "size instruction received"
  end

  def copy_instr(args)
    _, mask = args[5].split(".")
    _, layer = args[6].split(".")
    _, x_offset = args[7].split(".")
    _, y_offset = args[8].split(".")
    composite_op(mask, layer, x_offset, y_offset)
  end
  
  def method_missing(sym, *args, &block)
    puts sym
  end

  def respond_to?(sym, include_private=false)
    true
  end

end
