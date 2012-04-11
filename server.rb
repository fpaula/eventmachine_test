require 'rubygems'
require 'eventmachine'
require 'socket'

module EchoServer
  def post_init
    puts "Connected"
  end
  
  def receive_data(data)
    #@buf ||= BufferedTokenizer.new
    #@buf.extract(data).each do |line|
    #  send_data line
    #end
    retorno = <<-eos
HTTP/1.1 200 OK
Content-Type: text/html; charset=iso-8859-1
Content-Length: 216

<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>Server do Fred</title>
</head><body>
<h1>Server do Fred</h1>
<p>Seja bem vindo ao server do Fred</p>
</body></html>
eos
    
    send_data(retorno)
    close_connection_after_writing
  end
  
  def data_completed
    puts 'Chamou o metodo data_completed'
  end
  
  def unbind
    puts "Connection closed"
  end
end

EventMachine.run do
  port = 8081
  host = '127.0.0.1'
  puts "Server started on #{host}:#{port}"
  EventMachine.start_server host, port, EchoServer
end