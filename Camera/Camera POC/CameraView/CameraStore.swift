//
//  CameraStore.swift
//  Camera POC
//
//  Created by ShuZik on 28.10.2024.
//

import AVFoundation
import Combine
import UIKit

final class CameraStore: ObservableObject {
    
    @Published var state: CameraState
    
    private let session = AVCaptureSession()
    private let output = AVCapturePhotoOutput()
    
    init() {
        self.state = CameraState()
    }
    
    func handleAction(_ action: CameraAction) {
        switch action {
        case .setupCamera:
            setupCamera()
        case .takePhoto:
            takePhoto()
        case .flipCamera:
            flipCamera()
        case .updatePreview(let preview):
            updatePreview(preview)
        case .showSaveAlert(let show):
            updateSaveAlert(show)
        case .setSaveError(let error):
            updateSaveError(error)
        case .updateWatchConnection(let isConnected):
            updateWatchConnection(isConnected)
        }
    }
}

// MARK: - Private Camera Methods
private extension CameraStore {
    
    func setupCamera() {
        guard let device = AVCaptureDevice.default(for: .video) else { return }
        
        do {
            let input = try AVCaptureDeviceInput(device: device)
            if session.canAddInput(input) {
                session.addInput(input)
            }
            
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            
            let preview = AVCaptureVideoPreviewLayer(session: session)
            preview.videoGravity = .resizeAspectFill
            handleAction(.updatePreview(preview))
            
            DispatchQueue.global(qos: .background).async {
                self.session.startRunning()
            }
        } catch {
            handleAction(.setSaveError(error.localizedDescription))
        }
    }
    
    func takePhoto() {
        print("Taking photo...")
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: CameraPhotoDelegate(store: self))
    }
    
    func flipCamera() {
        guard let currentInput = session.inputs.first as? AVCaptureDeviceInput else { return }
        
        let newPosition: AVCaptureDevice.Position = currentInput.device.position == .back ? .front : .back
        guard let newDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: newPosition) else { return }
        
        do {
            let newInput = try AVCaptureDeviceInput(device: newDevice)
            
            session.beginConfiguration()
            session.removeInput(currentInput)
            if session.canAddInput(newInput) {
                session.addInput(newInput)
            }
            session.commitConfiguration()
        } catch {
            handleAction(.setSaveError(error.localizedDescription))
        }
    }
    
    func updatePreview(_ preview: AVCaptureVideoPreviewLayer?) {
        state.preview = preview
    }
    
    func updateSaveAlert(_ show: Bool) {
        state.showSaveAlert = show
    }
    
    func updateSaveError(_ error: String?) {
        state.saveError = error
    }
    
    func updateWatchConnection(_ isConnected: Bool) {
        state.isWatchConnected = isConnected
    }
}

// MARK: - Camera Photo Delegate
private final class CameraPhotoDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    private let store: CameraStore
    
    init(store: CameraStore) {
        self.store = store
        super.init()
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            DispatchQueue.main.async {
                self.store.handleAction(.setSaveError(error.localizedDescription))
                self.store.handleAction(.showSaveAlert(true))
            }
            return
        }
        
        guard let imageData = photo.fileDataRepresentation(),
              let image = UIImage(data: imageData) else {
            self.store.handleAction(.setSaveError("Could not process image data"))
            return
        }
        
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        DispatchQueue.main.async {
            if let error = error {
                self.store.handleAction(.setSaveError(error.localizedDescription))
            } else {
                self.store.handleAction(.setSaveError(nil))
            }
            self.store.handleAction(.showSaveAlert(true))
        }
    }
}
