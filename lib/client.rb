require 'thread'
require 'socket'
require 'yaml'
require 'celluloid'
require_relative 'parser'

class Client 

  include Celluloid
  include Parser
  # Read config.yml file to get guacd server config. 
  # Init image buffer.
  attr_reader :config, :socket, :carryover_instr
  INSTR = {
    :args => "ARGS"
  }

  def initialize
    @config = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'config.yml'))
    @carryover_instr = ''
    @socket = Socket.tcp(config["guac_host"], config["guac_port"].to_i)
  end
  
  def client_handshake
    send_to_server(client_select_instr)
    data = socket.readpartial(4096)
    parse_instructions(data)
  end
  
  def send_to_server(data)
    socket.print(data)
    socket.flush
  end

  def client_select_instr
    "6.select,3.#{config["protocol"]};" 
  end

  def client_connect_instr(args)
    ip_addr = config["remote_host"]
    port = config["remote_port"]
    instr = "7.connect,#{ip_addr.size}.#{ip_addr},#{port.to_s.size}.#{port},4.true,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.;"
    instr
  end

  def client_size_instr
    "4.size,1.0,4.1024,3.768;"
  end

  def client_audio_instr
    "5.audio;"
  end

  def client_video_instr
    "5.video;"
  end

  def connect_to_server
    client_handshake
    socket.while_reading do |data|
      parse_instructions(data)
    end
    socket.close
  end
end
class IO
  def while_reading(data = nil)
    while buf = readpartial_rescued(1024)
      data << buf  if data
      yield buf  if block_given?
    end
    data
  end
 
  private
 
  def readpartial_rescued(size)
    readpartial(size)
    rescue EOFError
    nil
  end
end
