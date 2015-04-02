module Parser
  
  # Split instructions by ; and handle each instruction based on the opcode. Check for carry over instruction.
  def parse_instructions(data)
    instructions = process_partial_instr(data)
    instructions.each do |inst|
      handle_instruction(inst)
    end
  end
  
  def process_partial_instr(data)
    #log_entry(data)
    unless data.include? ";"
      self.partial_instr += data
      return []
    end
    instructions = data.split(";")
    unless data.end_with? ";"
      instructions[0] += self.partial_instr
      self.partial_instr = instructions.pop
    end
    return instructions
  end

  def handle_instruction(inst)
    opcode, *args = inst.split(",")
    len, opcode_val = opcode.split(".")
    puts "Received #{opcode_val}"
    send("#{opcode_val}_instr".to_sym, args)
  end

end
