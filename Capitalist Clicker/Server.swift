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
    
    var groups: [GroupData] = []
    
    private var group: EventLoopGroup?
    private var channel: Channel?
    
    var isRunning = false
    
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
            print("yay server started at on port 8080")
            isRunning = true
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
        
        groups[groupIndex].totalSoon += Double(request.clicks) * groups[groupIndex].soonPerClick
        
        let totalCost = request.purchases.map { $0.amount }.reduce(0, +)
        
        groups[groupIndex].totalSoon -= totalCost
        
        groups[groupIndex].purchases.append(contentsOf: request.purchases)
        
        let availablePurchases = Purchase.all.filter { purchase in
            !groups[groupIndex].purchases.contains(purchase) && purchase.amount <= groups[groupIndex].totalSoon
        }.prefix(5)
        
        let response = SoonResponse(group: groups[groupIndex].group,
                                    amount: groups[groupIndex].totalSoon,
                                    availablePurchases: Array(availablePurchases))
        
        return response
    }
}
