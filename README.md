# AR Exploration Project

This project is a Swift-based application demonstrating AR-related features. It is developed in Visual Studio Code and built using Xcode’s command-line tools, allowing you to deploy the app to a specific iOS device.

## Prerequisites

- **macOS with Xcode Installed**: Ensure you have the latest Xcode as well as Xcode Command Line Tools.
- **Swift Development in VS Code**: Install the [Swift extension for VS Code](https://marketplace.visualstudio.com/items?itemName=sswg.swift-lang) or your preferred Swift extension.
- **iOS Device**: You must have an iOS device connected to your Mac. Make sure the device is unlocked, trusted, and that you know its UDID.

## Configuring Your Environment in VS Code

1. **Open the Project**:
   Open the project folder in VS Code.

2. **(Optional) Setup VS Code Tasks**:
   Configure a task in `.vscode/tasks.json` to build the project. For example:
   ```json
   {
     "version": "2.0.0",
     "tasks": [
       {
         "label": "Build AR Exploration",
         "type": "shell",
         "command": "xcodebuild",
         "args": [
           "-scheme", "AR_Exploration",
           "-destination", "platform=iOS,id=<YOUR_DEVICE_UDID>",
           "build"
         ],
         "group": {
           "kind": "build",
           "isDefault": true
         }
       }
     ]
   }
   ```
   Replace `<YOUR_DEVICE_UDID>` with your device’s UDID and adjust the scheme name if necessary.

## Building and Running on a Specific iOS Device

1. **Find Your Device UDID**:
   - Connect your iOS device to your Mac.
   - Open Xcode and go to **Window > Devices and Simulators** to locate your device's UDID.

2. **Build the Project**:
   Open the integrated terminal in VS Code and run the following command (replace `<YOUR_DEVICE_UDID>` as needed):
   ```bash
   xcodebuild -scheme AR_Exploration -destination 'platform=iOS,id=<YOUR_DEVICE_UDID>' build
   ```
   This command compiles the project for the specified device.

3. **Deploy and Run**:
   After a successful build, the app will be installed on your connected iOS device. If you prefer, you can also create a VS Code launch configuration to deploy the app automatically.

## Troubleshooting

- **Scheme Issues**:
  Make sure that the scheme (`AR_Exploration` in the example) matches your project’s configuration in Xcode.

- **Device Connection Problems**:
  Verify that your device is properly connected, unlocked, and trusted. Check Xcode’s Devices and Simulators window if issues arise.

- **Clean Build**:
  If you encounter errors, try cleaning the build with:
  ```bash
  xcodebuild clean -scheme AR_Exploration
  ```
  Then, rebuild the project.

## Additional Notes

- This guide assumes that the project is set up as an Xcode project or that an appropriate scheme exists. Adjust the provided commands and configurations based on your project specifics.
- For further customization or troubleshooting, refer to the [Xcode Command Line Tools documentation](https://developer.apple.com/library/archive/technotes/tn2339/_index.html).

Happy coding!
