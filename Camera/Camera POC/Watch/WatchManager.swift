//
//  WatchManager.swift
//  Camera POC
//
//  Created by ShuZik on 28.10.2024.
//

import WatchConnectivity

class WatchManager: NSObject, WCSessionDelegate {
    static let shared = WatchManager()
//    private let dispatcher: CameraDispatcher
    
    private override init() {
        super.init()
        setupSession()
    }
    
    private func setupSession() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
//        DispatchQueue.main.async {
//            self.dispatcher.dispatch(.updateWatchConnection(session.isReachable))
//        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("Session became inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
//        DispatchQueue.main.async {
//            self.dispatcher.dispatch(.updateWatchConnection(session.isReachable))
//        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
//        DispatchQueue.main.async {
//            if message["watchButtonPressed"] as? Bool == true {
//                self.dispatcher.dispatch(.takePhoto)
//            }
//            if message["flipCamera"] as? Bool == true {
//                self.dispatcher.dispatch(.flipCamera)
//            }
//            replyHandler(["status": "Command received"])
//        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
//        DispatchQueue.main.async {
//            if message["watchButtonPressed"] as? Bool == true {
//                self.dispatcher.dispatch(.takePhoto)
//            }
//            if message["flipCamera"] as? Bool == true {
//                self.dispatcher.dispatch(.flipCamera)
//            }
//        }
    }
}
