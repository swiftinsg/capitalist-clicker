//
//  Server.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation
import NIO
import NIOHTTP1
import Observation

@Observable
class Server: HTTPHandlerDelegate {
    
    var groups: [SoonEntry] = []
    
    private var group: EventLoopGroup?
    private var channel: Channel?
    
    let handler = HTTPHandler()
    
    init() {
        handler.delegate = self
    }
    
    func start() {
        
        group = MultiThreadedEventLoopGroup(numberOfThreads: System.coreCount)
        
        let bootstrap = ServerBootstrap(group: group!)
            .serverChannelOption(ChannelOptions.backlog, value: 256)
            .childChannelInitializer { channel in
                channel.pipeline.configureHTTPServerPipeline().flatMap {
                    channel.pipeline.addHandler(self.handler)
                }
            }
            .childChannelOption(ChannelOptions.socketOption(.so_reuseaddr), value: 1)
        
        do {
            channel = try bootstrap.bind(host: "0.0.0.0", port: 8080).wait()
            print("yay server started at \(channel!.localAddress!)")
        } catch {
            print("omg ts (this server) pmo: \(error)")
        }
    }
    
    func stop() {
        try? channel?.close().wait()
        try? group?.syncShutdownGracefully()
    }
    
    func didReceiveRequest(_ request: SoonEntry) -> SoonResponse? {
        guard let groupIndex = groups.firstIndex(where: { $0.group == request.group }) else { return nil }
        
        groups[groupIndex].amount += request.amount
        groups[groupIndex].purchases.append(contentsOf: request.purchases)
        
        #warning("TODO: find available purchases")
        let response = SoonResponse(group: groups[groupIndex].group,
                                    amount: groups[groupIndex].amount,
                                    availablePurchases: [])
        
        return response
    }
}
