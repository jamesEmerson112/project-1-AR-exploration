# SwiftUI Camera App with Real-time Image Processing

## Description
This project is a SwiftUI-based iOS application that accesses the iPhone camera and performs real-time image processing using Apple's Vision framework. It demonstrates how to capture a live camera feed, process the frames in real-time, and display the processed images within a SwiftUI interface.

## Features
- **Camera Access**: Utilizes AVFoundation to capture live video from the iPhone's camera.
- **Real-time Image Processing**: Implements basic image processing (face detection as a placeholder) with the Vision framework.
- **SwiftUI Interface**: Built using SwiftUI for a modern, declarative UI design.
- **Permission Handling**: Requests and manages camera permissions to ensure compliance with iOS requirements.

## Prerequisites
- Xcode 12.0 or later.
- iOS 14.0 or later.

## Installation
1. **Clone the Repository**
   Open your terminal and run the following command:
   ```bash
   git clone <repository_url>
   ```
2. **Open the Project**
   Navigate to the project directory and open it in Xcode:
   ```bash
   cd project-1-AR-exploration
   open .
   ```
3. **Build the Project**
   In Xcode, select your target device (a physical iPhone is recommended for camera testing) and build the project.

## Usage
1. **Run the App**
   Launch the app on your iPhone.
2. **Grant Permissions**
   When prompted, ensure you grant camera access to the app.
3. **View Live Feed & Processing**
   The app will display the live camera feed. It performs real-time image processing (e.g., face detection placeholder) and overlays the processed output on the feed.

## Real-time Image Processing
- The app leverages the Vision framework to detect faces in the camera feed.
- Currently, a placeholder image (a system "smiley" icon) is displayed upon detecting a face.
- Developers can extend this functionality to include more complex processing, such as drawing bounding boxes around detected faces or applying filters.

## Permissions Handling
- Camera permissions are managed through the `AVCaptureDevice` API.
- The `Info.plist` file contains a key (`NSCameraUsageDescription`) that explains why the app needs camera access.
- If access is denied, the app logs a message to the console.

## Contributing
Contributions to improve the app are welcome! Feel free to fork the repository, make enhancements, and submit pull requests.

## License
This project is provided "as is" without any warranty. Use, modify, and distribute as needed.

## Acknowledgments
- Thanks to Apple for providing AVFoundation and Vision frameworks.
- Special thanks to the SwiftUI community for their continuous support and resources.
