struct SignalSocket < Amber::WebSockets::ClientSocket
  channel "signal", SignalChannel

  def on_connect
    # do some authentication here
    # return true or false, if false the socket will be closed
    true
  end

  def self.send_signal(action : String, json_signal : String)
    self.broadcast("message", "signal", action, {"data" => json_signal} )
  rescue ex
    puts "Error broadcasting signal #{ex.message}"
  end

  def self.send_signal(action : String, hash_signal : Hash(String,String))
    self.broadcast("message", "signal", action, {"data" => hash_signal.to_s} )
  rescue ex
    puts "Error broadcasting signal #{ex.message}"
  end
end

module Sockets::Signal
  def self.send_signal(action : String, json_signal : String)
    SignalSocket.send_signal(action, json_signal)
  end

  def self.send_signal(action : String, hash_signal : Hash(String,String))
    SignalSocket.send_signal(action, hash_signal)
  end
end
