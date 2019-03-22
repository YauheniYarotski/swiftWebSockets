import Vapor
import WebSocket
//import HTTP

/// Called after your application has initialized.
public func boot(_ app: Application) throws {
    // Your code here
  let worker = MultiThreadedEventLoopGroup(numberOfThreads: 1)
  // Create a new WebSocket connected to echo.websocket.org
//  let ws = try HTTPClient.webSocket(scheme: .wss, hostname: "api.bitfinex.com/ws/2", on: worker).wait()
  let ws = try HTTPClient.webSocket(scheme: .wss, hostname: "api.bitfinex.com", path: "/ws/2", on: worker).wait()
  
//  let promise = worker.eventLoop.newPromise(String.self)
  
  // Set a new callback for receiving text formatted data.
  ws.onText { ws, text in
//    ws.m
    print("Server echo: \(text)")
  }
  
  ws.onBinary { (ws, data) in
    print("Data: \(data)")
  }
  
  // Send a message.
//  ws.send("Hello, world!!!!")
//  ws.d
//  let collection = ["event":"ping", "cid": 1234] as [String : Any]
  
  let tickerRequest: [String : Any] = ["event":"subscribe", "channel":"trades", "symbol":"tBTCUSD"]
  
  let theJSONData = try!  JSONSerialization.data(
    withJSONObject: tickerRequest,
    options: .prettyPrinted
    )
//    let theJSONText = String(data: theJSONData,
//                             encoding: String.Encoding.ascii)!
//    print("JSON string = \n\(theJSONText)")
  

//  ws.send(theJSONText)
  ws.send(theJSONData)
  
  // Wait for the Websocket to close.
  try ws.onClose.wait()
}


//extension WebSocket {
//  func send(_ json: JSON) throws {
//    let js = json.serialize(.PrettyPrint)
//    try send(js)
//  }
//}


//let user: User ...
//// Encode JSON using custom date encoding strategy
//try req.content.encode(json: user, using: .custom(dates: .millisecondsSince1970))


//struct User: Encodable {
//  <#fields#>
//}
