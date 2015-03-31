module Parser
  
  # Split instructions by ; and handle each instruction based on the opcode. Check for carry over instruction.
  def parse_instructions(data)
    puts data
    instructions = data.split(";")
    instructions.each do |inst|
      opcode, *args = inst.split(",")
      len, opcode_val = opcode.split(".")
      send("#{opcode_val}_instr".to_sym, args)
    end
  end

  def error_instr(args)
    puts "Error instruction received: #{args}"
  end

  def args_instr(args)
    send_to_server(client_size_instr+client_audio_instr+client_video_instr+client_connect_instr(args))
  end 

  def ready_instr(args)
    puts "Ready instruction received: #{args}"
  end

  def sync_instr(args)
    t = Time.now.to_i
    send_to_server("4.sync,#{t.size}.t;")
  end

  def png_instr(args)
    #puts args 
  end
  
  def method_missing(sym, *args, &block)
    puts "Instr not yet implemented. Printing it out"
    puts sym
  end

  def respond_to?(sym, include_private=false)
    true
  end

end
