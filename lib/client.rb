require 'socket'
require 'thread'
require 'mutex'

module Guac

  class Client
    
    # Read config.yml file to get guacd server config. 
    # Init image buffer.
    attr_reader :config, :socket, :carryover_instr

    def initialize
      @config = YAML.load_file(File.join(File.dirname(__FILE__), '..', '..', 'config.yml'))
      @socket = Socket.tcp(config["guac_host"], config["guac_port"].to_i)
      @carryover_instr = ''

    end

    def connect
    
    end

  end

end
