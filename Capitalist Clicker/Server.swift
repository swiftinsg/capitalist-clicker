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
            writeToFileThread()
            isRunning = true
        } catch {
            print("omg ts (this server) pmo: \(error)")
        }
    }
    
    func writeToFileThread() {
        Task.detached(priority: .background) {
            while true {
                self.writeToFile()
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }
    
    deinit {
        print("WHAT THE SIGMA")
    }
    
    func stop() {
        try? channel?.close().wait()
        try? group?.syncShutdownGracefully()
    }
    
    func didReceiveRequest(_ request: SoonEntry) -> SoonResponse? {
        guard let groupIndex = groups.firstIndex(where: { $0.group == request.group }) else { return nil }
        
        groups[groupIndex].totalSoon += Double(request.clicks) * groups[groupIndex].soonPerClick
        
        let totalCost = request.purchases.map { $0.amount }.reduce(0, +)
        
        let hcPurchased = request.purchases.filter {
            $0.imageName == "hc"
        }.count
        
        groups[groupIndex].soonPerClick *= pow(2, Double(hcPurchased))
        
        let newFlags = request.purchases.flatMap { $0.addedFlags }
        
        groups[groupIndex].flags.append(contentsOf: newFlags)
        
        groups[groupIndex].totalSoon -= totalCost
        
        groups[groupIndex].purchases.append(contentsOf: request.purchases)
        
        let availablePurchases = Purchase.all.filter { purchase in
            !groups[groupIndex].purchases.contains(purchase) && purchase.amount <= groups[groupIndex].totalSoon
        }.prefix(5)
        
        let response = SoonResponse(group: groups[groupIndex].group,
                                    amount: groups[groupIndex].totalSoon,
                                    availablePurchases: Array(availablePurchases),
                                    soonPerClick: groups[groupIndex].soonPerClick,
                                    flags: groups[groupIndex].flags)
        
        return response
    }
    
    func writeToFile() {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        
        let url = URL.downloadsDirectory.appendingPathComponent("soon.json")
        do {
            let data = try encoder.encode(groups)
            try data.write(to: url)
        } catch {
            print("Error writing to file: \(error)")
        }
    }
    
    func readFromFile() {
        let url = URL.downloadsDirectory.appendingPathComponent("soon.json")
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            groups = try decoder.decode([GroupData].self, from: data)
        } catch {
            print("Error reading from file: \(error)")
        }
    }
}
