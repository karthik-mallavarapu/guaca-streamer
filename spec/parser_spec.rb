require_relative 'spec_helper'

RSpec.describe 'Parser' do 

  class TestClient
    include Parser
    attr_accessor :partial_instr
    def initialize
      @partial_instr = ''
    end

    def respond_to?(sym, include_private=false)
      true
    end
  end

  let(:client) { TestClient.new }  

  describe '#process_partial_instr' do

    let(:input) {"3.nop;3.png,2.14,1.0,1.0,1.0,321.iVBORw0KGgo" }

    it "returns complete instructions" do
      output = ["3.nop"]
      expect(client.process_partial_instr(input)).to eq output
    end
    
    context "saves the carryover instruction when" do

      it "instruction does not end with a delimiter" do 
        output = "3.png,2.14,1.0,1.0,1.0,321.iVBORw0KGgo"
        client.process_partial_instr(input)    
        expect(client.partial_instr).to eql output
      end

      it "data has no delimiter" do
        data = "3.png,2.14,1.0,1.0,1.0,321.iVBORw0KGgo"
        client.process_partial_instr(data)
        expect(client.partial_instr).to eql data 
      end
      
    end

  end

  describe '#handle_instruction' do
    
    it "calls the method with opcode name" do
      instr = "4.size,1.0,4.1024,3.768"
      expect(client).to receive(:size_instr).with(["1.0", "4.1024", "3.768"])
      client.handle_instruction(instr)
    end

  end

end
