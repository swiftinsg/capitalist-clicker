//
//  Client.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/11/25.
//

import Foundation
import Observation
import SwiftUI

@Observable
class Client {
    var clicks = 0
    var itemsPurchased: [Purchase] = []
    var flags: [Flag] = []
    
    var clicksMultiplier = 1
    
    var purchases: [Purchase] {
        if showAllPurchasables {
            return Purchase.all
        } else {
            return availablePurchases
        }
    }
    
    var availablePurchases: [Purchase] = []
    
    var showAllPurchasables = false
    
    var address: String?
    var group: Group = .dingoBingo
    
    var textColor: Color = .blue
    var backgroundColor: Color = .white
    
    var started = false
    
    var lastHeartbeat = Date.distantPast
    
    var showRabbit1 = false
    var showRabbit2 = false

    var hasBoughtMining: Bool {
        return flags.contains(.mining)
    }

    var isFireSale = false

    var soonPerClick = 0.01
    
    func sendHeartbeat() async {
        guard let address = address,
              let url = URL(string: "http://" + address) else {
            print("invalid address")
            return
        }

        rollRabbitDice()
        startSeanTimer()
        
        guard clicks > 0 || !itemsPurchased.isEmpty || lastHeartbeat.timeIntervalSinceNow < -3 else {
            return
        }
        
        lastHeartbeat = .now
        
        let soonEarnedForRequest = clicks
        let itemsPurchasedForRequest = itemsPurchased
        
        clicks = 0
        itemsPurchased = []
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(SoonEntry(group: group, clicks: soonEarnedForRequest, purchases: itemsPurchasedForRequest))
            
            request.httpBody = data
            
            let (responseData, _) = try await URLSession.shared.data(for: request)
            
            let decoder = JSONDecoder()
            
            if let response = try? decoder.decode(SoonResponse.self, from: responseData) {
                availablePurchases = response.availablePurchases.map({ purchase in
                    var purchase = purchase
                    
                    if isFireSale {
                        purchase.amount *= 0.5
                    }
                    
                    return purchase
                })
                textColor = GroupData.color(for: response.amount)[1]
                backgroundColor = GroupData.color(for: response.amount)[0]
                soonPerClick = response.soonPerClick
                flags = response.flags
            } else {
                if let errorResponse = try? decoder.decode(SoonError.self, from: responseData) {
                    print("Error: \(errorResponse.error)")
                    print("Big Error: \(errorResponse.bigError)")
                    
                    print(String(data: data, encoding: .utf8)!)
                } else {
                    print("Unknown error")
                }
                clicks += soonEarnedForRequest
                itemsPurchased = itemsPurchasedForRequest
            }
        } catch {
            print("Error encoding: \(error)")
            clicks += soonEarnedForRequest
            itemsPurchased = itemsPurchasedForRequest
        }
    }
    
    func rollRabbitDice() {
        guard flags.contains(.rabbits) && !showRabbit1 && !showRabbit2 else { return }
        
        if Int.random(in: 1...1000) <= 5 {
            withAnimation {
                if .random() {
                    showRabbit1 = true
                } else {
                    showRabbit2 = true
                }
            }
        }
    }
    
    var isFireSaleTimerRunning = false
    
    func startSeanTimer() {
        guard !isFireSaleTimerRunning, flags.contains(.fireSale) && !isFireSale else { return }
        
        Timer.scheduledTimer(withTimeInterval: 60 * 5, repeats: true) { _ in
            self.isFireSale = true
            Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
                self.isFireSale = false
            }
        }
    }
    
    func start() {
        started = true
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            Task {
                await self.sendHeartbeat()
            }
        }
    }
}
