module Parser
  
  # Split instructions by ; and handle each instruction based on the opcode. Check for carry over instruction.
  def parse_instructions(data)
    instructions = process_partial_instr(data)
    instructions.each do |inst|
      handle_instruction(inst)
    end
  end
  
  def process_partial_instr(data)
    instructions = data.split(";")
    unless partial_instr.empty?
      carryover_instr = partial_instr + instructions.shift
      instructions[0] = partial_instr + instructions[0]
      partial_instr = ''
    end
    unless data.end_with? ";"
      partial_instr = instructions.pop
    end
    instructions
  end

  def handle_instruction(inst)
    opcode, *args = inst.split(",")
    len, opcode_val = opcode.split(".")
    send("#{opcode_val}_instr".to_sym, args)
  end

end
