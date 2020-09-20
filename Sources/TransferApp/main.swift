import Foundation
import TransferPe

let arguments: [String] = Array(CommandLine.arguments.dropFirst())

var ip = "mcpe.to"
var port = 19132

if(arguments.count == 1){
    ip = arguments[0]
} else if arguments.count == 2{
    ip = arguments[0]
    port = Int(arguments[1])!
}

let server = TransferPe(ip, port)
let closeFuture = server.run()

signal(SIGINT) { s in server.close() }

do {
    try closeFuture!.wait()
} catch {
    print(error)
}

