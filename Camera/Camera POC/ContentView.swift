//
//  ContentView.swift
//  Camera POC
//
//  Created by ShuZik on 23.10.2024.
//

import SwiftUI
import WatchConnectivity
import AVFoundation
import Photos

class CameraManager: ObservableObject {
    static let shared = CameraManager()
    let session = AVCaptureSession()
    let output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer?
    @Published var showSaveAlert = false
    @Published var saveError: String?
    
    init() {
        checkPermissions()
    }
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async {
                        self?.setupCamera()
                    }
                }
            }
        case .restricted, .denied:
            return
        case .authorized:
            setupCamera()
        @unknown default:
            return
        }
    }
    
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
            self.preview = preview
            
            DispatchQueue.global(qos: .background).async {
                self.session.startRunning()
            }
        } catch {
            print("Failed to setup camera: \(error.localizedDescription)")
        }
    }
    
    func takePhoto() {
        print("Taking photo...")
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: PhotoCaptureDelegate(manager: self))
    }
    
    func flipCamera() {
        guard let currentInput = session.inputs.first as? AVCaptureDeviceInput else { return }
        
        // Получаем новую позицию камеры
        let newPosition: AVCaptureDevice.Position = currentInput.device.position == .back ? .front : .back
        
        // Получаем устройство для новой позиции
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
            print("Error flipping camera: \(error.localizedDescription)")
        }
    }
}

class PhotoCaptureDelegate: NSObject, AVCapturePhotoCaptureDelegate {
    let manager: CameraManager
    
    init(manager: CameraManager) {
        self.manager = manager
        super.init()
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.manager.saveError = error.localizedDescription
                self.manager.showSaveAlert = true
            }
            return
        }
        
        guard let imageData = photo.fileDataRepresentation() else {
            print("Error: Could not get image data")
            return
        }
        
        guard let image = UIImage(data: imageData) else {
            print("Error: Could not create UIImage")
            return
        }
        
        // Сохраняем фото в галерею
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
        print("Started saving photo...")
    }
    
    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        DispatchQueue.main.async {
            if let error = error {
                print("Error saving photo: \(error.localizedDescription)")
                self.manager.saveError = error.localizedDescription
            } else {
                print("Photo saved successfully!")
                self.manager.saveError = nil
            }
            self.manager.showSaveAlert = true
        }
    }
}

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

class iOSConnectivityManager: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = iOSConnectivityManager()
    @Published var showAlert = false
    @Published var isWatchConnected = false
    @Published var lastReceivedMessage = "No messages yet"
    
    override init() {
        super.init()
        setupSession()
    }
    
    func setupSession() {
        if WCSession.isSupported() {
            print("iPhone: WCSession is supported")
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            print("iPhone: Session activated, state: \(activationState.rawValue)")
            self.isWatchConnected = session.isReachable
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("iPhone: Session became inactive")
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        print("iPhone: Session deactivated")
        WCSession.default.activate()
    }
    
    func sessionReachabilityDidChange(_ session: WCSession) {
        DispatchQueue.main.async {
            print("iPhone: Reachability changed: \(session.isReachable)")
            self.isWatchConnected = session.isReachable
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
            DispatchQueue.main.async {
                if message["watchButtonPressed"] as? Bool == true {
                    CameraManager.shared.takePhoto()
                }
                if message["flipCamera"] as? Bool == true {
                    CameraManager.shared.flipCamera()
                }
                replyHandler(["status": "Command received"])
            }
        }
        
        func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
            DispatchQueue.main.async {
                if message["watchButtonPressed"] as? Bool == true {
                    CameraManager.shared.takePhoto()
                }
                if message["flipCamera"] as? Bool == true {
                    CameraManager.shared.flipCamera()
                }
            }
        }
    }

struct WatchStatusIcon: View {
    let isConnected: Bool
    
    var body: some View {
        Image(systemName: "applewatch")
            .foregroundColor(isConnected ? .green : .red)
            .font(.system(size: 20))
    }
}

struct ContentView: View {
    @StateObject private var connectivity = iOSConnectivityManager.shared
    @StateObject private var cameraManager = CameraManager.shared
    
    var body: some View {
        NavigationView {
            ZStack {
                if let preview = cameraManager.preview {
                    CameraPreview(preview: preview)
                        .ignoresSafeArea()
                }
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        cameraManager.takePhoto()
                    }) {
                        Image(systemName: "camera.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .background(Color.black.opacity(0.5))
                            .clipShape(Circle())
                            .padding(.bottom, 30)
                    }
                }
            }
            .navigationTitle("Camera PoC")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    WatchStatusIcon(isConnected: connectivity.isWatchConnected)
                }
            }
            .alert(isPresented: $cameraManager.showSaveAlert) {
                if let error = cameraManager.saveError {
                    return Alert(
                        title: Text("Error"),
                        message: Text(error),
                        dismissButton: .default(Text("OK"))
                    )
                } else {
                    return Alert(
                        title: Text("Success"),
                        message: Text("Photo saved to gallery"),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
