import Foundation
import TransferPe
import NIO
import RakNetSwift

let arguments: [String] = Array(CommandLine.arguments.dropFirst())

var ip = "mcpe.to"
var port = 19132
var group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)

defer {
    do {
        try group.syncShutdownGracefully()
    } catch {
        print(error)
    }
}

if(arguments.count == 1){
    ip = arguments[0]
} else if arguments.count == 2{
    ip = arguments[0]
    port = Int(arguments[1])!
}


let server = TransferPe(ip, port, false, withHandler: {
    print("Server turned off!")
})

signal(SIGINT) { s in server.close() }

server.run(group)

while(server.isRunning) {
    //NOOP
}

