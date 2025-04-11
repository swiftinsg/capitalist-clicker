//
//  PreviewView.swift
//  Capitalist Clicker
//
//  Created by Jia Chen Yee on 4/11/25.
//

import SwiftUI

struct PreviewView: View {
    
    @Environment(Server.self) private var server
    
    var body: some View {
        @Bindable var server = server
        
        if server.groups.count == 9 {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    GroupPreviewView(group: $server.groups[0])
                    Divider()
                    GroupPreviewView(group: $server.groups[1])
                    Divider()
                    GroupPreviewView(group: $server.groups[2])
                }
                Divider()
                HStack(spacing: 0) {
                    GroupPreviewView(group: $server.groups[3])
                    Divider()
                    GroupPreviewView(group: $server.groups[4])
                    Divider()
                    GroupPreviewView(group: $server.groups[5])
                }
                Divider()
                HStack(spacing: 0) {
                    GroupPreviewView(group: $server.groups[6])
                    Divider()
                    GroupPreviewView(group: $server.groups[7])
                    Divider()
                    GroupPreviewView(group: $server.groups[8])
                }
            }
            .frame(width: 1920, height: 1080)
        }
    }
}

#Preview {
    PreviewView()
}
