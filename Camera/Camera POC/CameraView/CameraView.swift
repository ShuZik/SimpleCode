//
//  CameraView.swift
//  Camera POC
//
//  Created by ShuZik on 23.10.2024.
//

import SwiftUI

struct CameraView: View {

    private var dispatcher: CameraDispatcher
    @StateObject private var store: CameraStore
    
    init(dispatcher: CameraDispatcher = CameraDispatcher()) {
        self.dispatcher = dispatcher
        self.dispatcher.register(store: CameraStore())
        
        _store = StateObject(wrappedValue: dispatcher.store!)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                if let preview = store.state.preview {
                    CameraPreview(preview: preview)
                        .ignoresSafeArea()
                }
                
                VStack {
                    Spacer()
                    
                    Button(action: {
                        dispatcher.dispatch(.takePhoto)
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
                    WatchStatus(isConnected: store.state.isWatchConnected)
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dispatcher.dispatch(.flipCamera)
                    }) {
                        Image(systemName: "camera.rotate")
                            .font(.system(size: 20))
                    }
                }
            }
            .alert(isPresented: .constant(store.state.showSaveAlert)) {
                if let error = store.state.saveError {
                    return Alert(
                        title: Text("Error"),
                        message: Text(error),
                        dismissButton: .default(Text("OK")) {
                            dispatcher.dispatch(.showSaveAlert(false))
                        }
                    )
                } else {
                    return Alert(
                        title: Text("Success"),
                        message: Text("Photo saved to gallery"),
                        dismissButton: .default(Text("OK")) {
                            dispatcher.dispatch(.showSaveAlert(false))
                        }
                    )
                }
            }
            .onAppear {
                dispatcher.dispatch(.setupCamera)
            }
        }
    }
}

#Preview {
    CameraView(dispatcher: CameraDispatcher())
}
