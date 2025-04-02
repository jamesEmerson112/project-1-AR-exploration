import Foundation
import AVFoundation
import Vision
import SwiftUI

class CameraModel: NSObject, ObservableObject {
    @Published var processedImage: UIImage?

    private let session = AVCaptureSession()
    private let videoOutput = AVCaptureVideoDataOutput()
    private let context = CIContext()

    override init() {
        super.init()
        setupSession()
    }

    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            // Already authorized
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if !granted {
                    // Handle not granted
                    DispatchQueue.main.async {
                        // You can update the UI to show an alert or similar
                        print("Camera access denied.")
                    }
                }
            }
        default:
            // Handle denied or restricted
            DispatchQueue.main.async {
                // You can update the UI to show an alert or similar
                print("Camera access denied or restricted.")
            }
            break
        }
    }

    private func setupSession() {
        session.beginConfiguration()

        // Setup camera input
        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("Cannot find front camera")
            session.commitConfiguration()
            return
        }

        do {
            let videoDeviceInput = try AVCaptureDeviceInput(device: videoDevice)
            if session.canAddInput(videoDeviceInput) {
                session.addInput(videoDeviceInput)
            } else {
                print("Cannot add video device input to session")
                session.commitConfiguration()
                return
            }
        } catch {
            print("Error creating video device input: \(error)")
            session.commitConfiguration()
            return
        }

        // Setup video output
        if session.canAddOutput(videoOutput) {
            session.addOutput(videoOutput)
            videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            videoOutput.alwaysDiscardsLateVideoFrames = true
            videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_32BGRA)]
        } else {
            print("Cannot add video data output to session")
            session.commitConfiguration()
            return
        }

        session.commitConfiguration()
    }

    func startSession() {
        if !session.isRunning {
            DispatchQueue.global(qos: .userInitiated).async {
                self.session.startRunning()
            }
        }
    }

    func stopSession() {
        if session.isRunning {
            DispatchQueue.global(qos: .background).async {
                self.session.stopRunning()
            }
        }
    }
}

extension CameraModel: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

        // Perform image processing here
        // Example: Detect faces using Vision
        let requestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:])
        let faceDetectionRequest = VNDetectFaceRectanglesRequest { [weak self] request, error in
            if let results = request.results as? [VNFaceObservation], let self = self {
                DispatchQueue.main.async {
                    // For demonstration, we'll just display a placeholder image
                    // Replace this with actual image processing as needed
                    self.processedImage = UIImage(systemName: "smiley")

                    // Example: Highlight detected faces
                    // You can implement drawing bounding boxes or other processing here
                    /*
                    UIGraphicsBeginImageContext(CGSize(width: 100, height: 100))
                    let uiImage = UIImage(ciImage: CIImage(cvPixelBuffer: pixelBuffer))
                    uiImage.draw(at: .zero)
                    let context = UIGraphicsGetCurrentContext()
                    context?.setStrokeColor(UIColor.red.cgColor)
                    context?.setLineWidth(2.0)
                    for face in results {
                        let boundingBox = face.boundingBox
                        let size = uiImage.size
                        let rect = CGRect(x: boundingBox.origin.x * size.width,
                                          y: (1 - boundingBox.origin.y - boundingBox.size.height) * size.height,
                                          width: boundingBox.size.width * size.width,
                                          height: boundingBox.size.height * size.height)
                        context?.stroke(rect)
                    }
                    let annotatedImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                    self.processedImage = annotatedImage
                    */
                }
            }
        }

        do {
            try requestHandler.perform([faceDetectionRequest])
        } catch {
            print("Failed to perform Vision request: \(error)")
        }
    }
}
