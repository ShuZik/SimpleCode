//
//  ContentView.swift
//  Camera Watch POC v2 Watch App
//
//  Created by ShuZik on 23.10.2024.
//

import SwiftUI
import WatchConnectivity

class WatchConnectivityManager: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchConnectivityManager()
    @Published var isPhoneConnected = false
    @Published var sessionState = "Initializing..."
    @Published var lastMessageStatus = ""
    
    override init() {
        super.init()
        setupSession()
    }
    
    func setupSession() {
        if WCSession.isSupported() {
            print("Watch: WCSession is supported")
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.isPhoneConnected = session.isReachable
            print("Watch: Session activated, reachable: \(session.isReachable)")
        }
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            self.isPhoneConnected = session.isReachable
            print("Watch: Reachability changed: \(session.isReachable)")
        }
    }
    
    func sendButtonPress() {
        guard WCSession.default.isReachable else {
            print("Watch: Cannot send - iPhone not reachable")
            self.lastMessageStatus = "Failed - Phone not reachable"
            return
        }
        
        print("Watch: Sending button press message")
        WCSession.default.sendMessage(
            ["watchButtonPressed": true],
            replyHandler: { reply in
                DispatchQueue.main.async {
                    print("Watch: Message sent successfully with reply: \(reply)")
                    self.lastMessageStatus = "Sent successfully"
                }
            },
            errorHandler: { error in
                DispatchQueue.main.async {
                    print("Watch: Send failed: \(error.localizedDescription)")
                    self.lastMessageStatus = "Failed - \(error.localizedDescription)"
                }
            }
        )
    }
    
    func flipCamera() {
        if WCSession.default.isReachable {
            WCSession.default.sendMessage(
                ["flipCamera": true],
                replyHandler: nil
            ) { error in
                print("Failed to send flip camera command: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView: View {
    @StateObject private var connectivity = WatchConnectivityManager.shared
    
    var body: some View {
        VStack(spacing: 10) {
            Button("Make Photo") {
                connectivity.sendButtonPress()
            }
            .buttonStyle(.bordered)
            
            Button("Flip Camera") {
                connectivity.flipCamera()
            }
            .buttonStyle(.bordered)
            
            HStack {
                Circle()
                    .fill(connectivity.isPhoneConnected ? Color.green : Color.red)
                    .frame(width: 8, height: 8)
                
                Text(connectivity.isPhoneConnected ? "Phone Connected" : "Phone Disconnected")
                    .font(.footnote)
                    .foregroundColor(connectivity.isPhoneConnected ? .green : .red)
            }
            
            if !connectivity.lastMessageStatus.isEmpty {
                Text(connectivity.lastMessageStatus)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
