//
//  CameraPreview.swift
//  Camera POC
//
//  Created by ShuZik on 28.10.2024.
//

import SwiftUI
import AVFoundation

struct CameraPreview: UIViewRepresentable {
    let preview: AVCaptureVideoPreviewLayer
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: UIScreen.main.bounds)
        preview.frame = view.frame
        view.layer.addSublayer(preview)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}
