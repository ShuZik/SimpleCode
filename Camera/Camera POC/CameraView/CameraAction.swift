//
//  CameraAction.swift
//  Camera POC
//
//  Created by ShuZik on 28.10.2024.
//

import AVFoundation

enum CameraAction {
    case setupCamera
    case takePhoto
    case flipCamera
    case updatePreview(AVCaptureVideoPreviewLayer?)
    case showSaveAlert(Bool)
    case setSaveError(String?)
    case updateWatchConnection(Bool)
}
