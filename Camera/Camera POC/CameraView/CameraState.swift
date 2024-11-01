//
//  CameraState.swift
//  Camera POC
//
//  Created by ShuZik on 28.10.2024.
//

import AVFoundation
import SwiftUI

final class CameraState {
    
    var preview: AVCaptureVideoPreviewLayer?
    var showSaveAlert = false
    var saveError: String?
    var isWatchConnected = false

}

extension CameraState: Equatable {
    static func == (lhs: CameraState, rhs: CameraState) -> Bool {
        lhs.preview == rhs.preview &&
        lhs.showSaveAlert == rhs.showSaveAlert &&
        lhs.saveError == rhs.saveError &&
        lhs.isWatchConnected == rhs.isWatchConnected
    }
}
