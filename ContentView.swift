import SwiftUI
import AVFoundation
import Vision

struct ContentView: View {
    @StateObject private var camera = CameraModel()

    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea(.all, edges: .all)

            if let processedImage = camera.processedImage {
                Image(uiImage: processedImage)
                    .resizable()
                    .scaledToFit()
                    .opacity(0.7)
            }
        }
        .onAppear {
            camera.checkPermissions()
            camera.startSession()
        }
        .onDisappear {
            camera.stopSession()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
