

# include thrift-generated code
$:.push('./gen-rb')
 
require 'thrift/transport/tsocket'
require 'thrift/protocol/tbinaryprotocol'
require 'thrift/server/tserver'
 
require 'STDService'
require 'std_parser'
 
# provide an implementation of QService
class STDServiceHandler 
  def initialize
    @std_parser = STDParser.instance
  end
  
  def lookup(number)
    @std_parser.query(number)
  end
end
  
handler = STDServiceHandler.new()
processor = STDService::Processor.new(handler)
transport = TServerSocket.new(9090)
transportFactory = TBufferedTransportFactory.new()
server = TSimpleServer.new(processor, transport, transportFactory)
 
puts "Starting the STDService server..."
server.serve()
puts "Done"