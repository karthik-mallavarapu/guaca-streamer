module GuacHandler
  
  def error_instr(args)
    puts "Error instruction received: #{args}"
  end

  def args_instr(args)
    send_to_server(client_size_instr+client_audio_instr+client_video_instr+client_connect_instr(args))
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
    write_img_file(args[4].split(".").last) 
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
  
  def method_missing(sym, *args, &block)
    puts sym
  end

  def respond_to?(sym, include_private=false)
    true
  end

end
