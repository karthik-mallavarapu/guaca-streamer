require 'gosu'
require 'rmagick'
require_relative 'client'

class GuacRunner < Gosu::Window
  def initialize
    super(800, 600, false)
    self.caption = "Gosu Tutorial Game"
    @client = Client.new
    client_thrd = Thread.new do
      @client.server_connect
    end
    client_thrd.priority = -1
    @background_image = Gosu::Image.new(self, @client.desktop, true)
  end

  def update
    @background_image.insert(@client.desktop, 0, 0) 
  end

  def draw
    @background_image.draw(0, 0, 0)
  end
end

window =GuacRunner.new
window.show
