require 'socket'
require 'thread'
require 'yaml'
require 'rmagick'
require 'pry'
require_relative 'parser'
require_relative 'guac_handler'
require_relative 'image_processor'

class Client 

  include Parser
  include GuacHandler
  include ImageProcessor
  # Read config.yml file to get guacd server config. 
  # Init image buffer.
  attr_reader :config, :socket, :logger, :img_writer
  attr_accessor :partial_instr, :desktop, :img_list

  def initialize
    @config = YAML.load_file(File.join(File.dirname(__FILE__), '..', 'config.yml'))
    @partial_instr = ''
    @logger = File.open("guac.log", 'a')
    @socket = Socket.tcp(config["guac_host"], config["guac_port"].to_i)
    # Hardcoding resolution..fix it
    @desktop = Magick::Image.new(800, 600)
    @img_list = Magick::ImageList.new
    @desktop.format = "png"
  end

  def log_entry(data)
    logger.puts(data)
  end

  def server_connect
    client_handshake
    socket.while_reading do |data|
      parse_instructions(data)
      Signal.trap(:INT) do
        return
      end
    end
  end

  def disconnect
    send_to_server(client_disconnect_instr)
    socket.close
  end

  def client_handshake
    send_to_server(client_select_instr)
    data = socket.readpartial(1024)
    parse_instructions(data)
  end

  def client_disconnect_instr
    "10.disconnect;"
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
    inst = "7.connect,#{ip_addr.size}.#{ip_addr},#{port.to_s.size}.#{port},4.true,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.,0.;"
    inst
  end

  def client_size_instr
    "4.size,3.800,3.600,2.96;"
  end

  def client_audio_instr
    "5.audio;"
  end

  def client_video_instr
    "5.video;"
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
