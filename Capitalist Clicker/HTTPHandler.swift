//
//  HTTPHandler.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation
import NIO
import NIOHTTP1

class HTTPHandler: ChannelInboundHandler {
    typealias InboundIn = HTTPServerRequestPart
    typealias OutboundOut = HTTPServerResponsePart
    
    var delegate: HTTPHandlerDelegate?
    
    deinit {
        print("HTTPHandler deinitialized")
    }
    
    func channelRead(context: ChannelHandlerContext, data: NIOAny) {
        let reqPart = self.unwrapInboundIn(data)
        
        switch reqPart {
        case .body(let byteBuffer):
            var buffer = byteBuffer
            var bodyData = Data()
            
            if let bytes = buffer.readBytes(length: buffer.readableBytes) {
                bodyData.append(contentsOf: bytes)
            }
            
            let decoder = JSONDecoder()
            do {
                let payload = try decoder.decode(SoonEntry.self, from: bodyData)
                
                if let response = delegate?.didReceiveRequest(payload) {
                    respond(context: context, data: response.toData())
                } else {
                    let errorResponse = SoonError(error: "group not found", bigError: "no response from delegate?? this is wild")
                    respond(context: context, status: .badRequest, data: errorResponse.toData())
                }
                
            } catch {
                print("Decoding error: \(error)")
                respond(context: context, status: .badRequest, data: SoonError(error: "uhh probably the wrong json format", bigError: "\(error)").toData())
            }
        default: break
        }
    }
    
    private func respond(context: ChannelHandlerContext, status: HTTPResponseStatus = .ok, data: Data) {
        var headers = HTTPHeaders()
        headers.add(name: "Content-Type", value: "application/json")
        
        let responseHead = HTTPResponseHead(version: .init(major: 1, minor: 1),
                                            status: status,
                                            headers: headers)
        context.write(self.wrapOutboundOut(.head(responseHead)), promise: nil)
        
        var buffer = context.channel.allocator.buffer(capacity: data.count)
        buffer.writeBytes(data)
        context.write(self.wrapOutboundOut(.body(.byteBuffer(buffer))), promise: nil)
        
        context.writeAndFlush(self.wrapOutboundOut(.end(nil)), promise: nil)
        context.close()
    }
}

protocol HTTPHandlerDelegate {
    func didReceiveRequest(_ request: SoonEntry) -> SoonResponse?
}
