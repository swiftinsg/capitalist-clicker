//
//  FishesOverlayView.swift
//  Capitalist Clicker iOS
//
//  Created by Jia Chen Yee on 4/12/25.
//

import SwiftUI

struct FishesOverlayView: View {
    
    @Binding var clicks: Int
    
    @State private var fishes: [FishInfo] = []
    
    var body: some View {
        GeometryReader { geometry in
            ForEach(fishes) { fish in
                FishView(fishes: $fishes, info: fish) {
                    clicks += .random(in: 1000...5000)
                }
                .position(x: geometry.size.width / 2, y: fish.yPosition * geometry.size.height)
            }
        }
        .task {
            while true {
                spawnFish()
                try? await Task.sleep(for: .seconds(1))
            }
        }
    }
    
    func spawnFish() {
        fishes.append(FishInfo(yPosition: .random(in: 0...1), startAtLeading: .random(), crossingTime: .random(in: 5...15), color: [.red, .green, .blue, .yellow, .teal, .black, .white, .purple, .pink, .brown, .cyan, .indigo, .mint].randomElement()!))
    }
}

struct FishInfo: Identifiable {
    var id = UUID()
    
    var yPosition: Double
    var startAtLeading: Bool
    var crossingTime: Double
    
    var color: Color
}
