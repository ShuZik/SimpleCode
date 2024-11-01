//
//  PhotoDelegate.swift
//  Camera POC
//
//  Created by ShuZik on 24.10.2024.
//

//import AVFoundation
//import UIKit
//
//final class PhotoDelegate: NSObject, AVCapturePhotoCaptureDelegate {
//    
//    private let dispatcher: CameraDispatcher
//    
//    init(dispatcher: CameraDispatcher) {
//        self.dispatcher = dispatcher
//    }
//    
//    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
//        if let error = error {
//            DispatchQueue.main.async {
//                self.dispatcher.dispatch(.setSaveError(error.localizedDescription))
//                self.dispatcher.dispatch(.showSaveAlert(true))
//            }
//            return
//        }
//        
//        guard let imageData = photo.fileDataRepresentation(),
//              let image = UIImage(data: imageData) else {
//            self.dispatcher.dispatch(.setSaveError("Could not process image data"))
//            return
//        }
//        
//        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveCompleted), nil)
//    }
//    
//    @objc func saveCompleted(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
//        DispatchQueue.main.async {
//            if let error = error {
//                self.dispatcher.dispatch(.setSaveError(error.localizedDescription))
//            } else {
//                self.dispatcher.dispatch(.setSaveError(nil))
//            }
//            self.dispatcher.dispatch(.showSaveAlert(true))
//        }
//    }
//}
