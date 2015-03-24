module Guac
  
  module Parser
    
    def parse_instructions()

    end

    def select_instr
      "6.select,3.#{config.protocol};" 
    end

    def connect_instr
      ip_addr = config.remote_host
      port = config.remote_port
      "4.size,4.1024,3.768,2.96;5.audio,9.audio/ogg;5.video;7.connect,#{ip_addr.size}.#{ip_addr},#{port.size}.#{port},0.,0.,0.;"
    end

  end

end
