require 'socket'
require 'thread'
require 'yaml'
require 'eventmachine'
require_relative 'parser'

class Client < EventMachine::Connection

  include Parser
  # Read config.yml file to get guacd server config. 
  # Init image buffer.
  attr_reader :config, :socket, :carryover_instr

  def post_init
    @config = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'config.yml'))
    @carryover_instr = ''
    send_data select_instr
  end
   
  def receive_data(data)
    #parse_instructions(data)
    print data
  end

end

EventMachine.run {
  EventMachine::connect "192.168.56.98", "4822", Client
}
