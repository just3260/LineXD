import LineBot
import Foundation
import Vapor


public func randomInt(range:Int) -> Int {
    #if os(Linux)
        return Glibc.random() % range
    #else
        return Int(arc4random_uniform(UInt32(range)))
    #endif
}



let drop = try Droplet()
let endpoint = "https://api.line.me/v2/bot/message/reply"
let accessToken = "OoFdWpqFaiTweCAZ78pVaxcGsNJrzBob0MFrQxHjbmFZmf3Hf1Mr0Z3Rt+CNdWBPHDAPkdCIlLOFfgfPcb22SPqx67yqhD+GBcwWhijCFmwUznCZxhe6Y8cM/HYp/JCyR/7pWcr17f+mab4gBM3ZtgdB04t89/1O/w1cDnyilFU="
let channelSecret = "496c110eb6db3d1af4918c41647b45ab"


drop.post("callback") { request in
    let bot = LineBot(accessToken: accessToken, channelSecret: channelSecret)
    
    guard let content = request.body.bytes?.makeString() else {
        print("content error")
        return Response(status: .badRequest)
    }

    guard let signature = request.headers["X-Line-Signature"] else {
        print("signature error")
        return Response(status: .badRequest)
    }

    guard bot.validateSignature(content: content, signature: signature) else {
        print("validateSignature error")
        return Response(status: .badRequest)
    }
    
    guard let events = bot.parseEventsFrom(requestBody: content) else {
        print("events error")
        return Response(status: .badRequest)
    }
    
    for event in events {
        switch event {
        case .message(let message):
            let replyToken = message.replyToken
            switch message.message {
            case .text(let content):
                bot.reply(token: replyToken, messages: [.text(text: content.text)])
                print(content.text)
            case _:
                break
            }
        case _:
            break
        }
    }
    
    return Response(status: .ok, body: "reply")
}

try drop.run()

