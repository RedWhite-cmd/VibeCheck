VibeCheck

VibeCheck is an iOS application built with SwiftUI and HealthKit designed to help users monitor their physiological stress levels in real-time. By leveraging heart rate data and biometric scanning, the app provides actionable insights into the user's current "vibe" or mental state.

✨ Features
Heart Rate Scanning: Utilizes HeartRateScanner to pull real-time biometric data.

HealthKit Integration: Seamlessly connects with Apple Health via a dedicated HealthManager to ensure data privacy and accuracy.

Stress Tracking: Algorithms designed to interpret heart rate variability and patterns into a simplified stress score.

Modern UI: A clean, intuitive interface built entirely with SwiftUI for a native iOS feel.

🛠 Tech Stack
Frameworks: SwiftUI, Core Health (HealthKit)

Language: Swift

Platform: iOS 15.0+

📂 Project Structure
VibeCheck: Contains the core application logic, including HealthManager.swift and HeartRateScanner.swift.

VibeCheckTests: Unit tests for biometric calculations and data handling.

VibeCheckUITests: Automated UI testing scripts.

🚀 Getting Started
Prerequisites
A Mac with Xcode installed.

A physical iPhone (HealthKit data is limited on the Simulator).

Apple Health permissions enabled on your device.

Installation
Clone the repository:

Bash
git clone https://github.com/RedWhite-cmd/VibeCheck.git
Open in Xcode:
Open VibeCheck.xcodeproj.

Configure Permissions:
Ensure the HealthKit capability is added under Signing & Capabilities.

Run:
Select your physical device and press Cmd + R.

👤 Contributors
Sudeep Reddy Thatiparthi - Founder & Lead Developer

To add this to your project:
Navigate to your VibeCheck repository.

Click the "Add a README" button appearing in your current view.

Paste the content above and commit the changes.

Would you like me to add a section specifically explaining how the HeartRateScanner logic works?
