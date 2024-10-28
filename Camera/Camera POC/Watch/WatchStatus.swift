//
//  WatchStatus.swift
//  Camera POC
//
//  Created by ShuZik on 28.10.2024.
//

import SwiftUI

struct WatchStatus: View {
    let isConnected: Bool
    
    var body: some View {
        Image(systemName: "applewatch")
            .foregroundColor(isConnected ? .green : .red)
            .font(.system(size: 20))
    }
}
