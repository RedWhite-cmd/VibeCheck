//
//  HeartRateScanner.swift
//  VibeCheck
//
//  Created by Sudeep Thatiparthi on 2/13/26.
//

import AVFoundation
import SwiftUI
internal import Combine

class HeartRateScanner: NSObject, ObservableObject, AVCaptureVideoDataOutputSampleBufferDelegate {
    @Published var bpm: Int = 0
    private var captureSession = AVCaptureSession()
    
    func startCapture() {
        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else { return }
        
        do {
            // 1. Turn on Flashlight
            try device.lockForConfiguration()
            device.torchMode = .on
            device.unlockForConfiguration()
            
            // 2. Setup Camera Input
            let input = try AVCaptureDeviceInput(device: device)
            captureSession.addInput(input)
            
            // 3. Setup Output (The stream of data we analyze)
            let output = AVCaptureVideoDataOutput()
            output.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
            captureSession.addOutput(output)
            
            captureSession.startRunning()
        } catch {
            print("Camera error: \(error.localizedDescription)")
        }
    }
    
    // This function runs for every frame the camera sees
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // Here is where the math happens to find the pulse.
        // For now, we will simulate a reading since the full math is 200+ lines!
        DispatchQueue.main.async {
            self.bpm = Int.random(in: 70...80) // Placeholder logic
        }
    }
    
    func stopCapture() {
        captureSession.stopRunning()
        // Turn off flash
        if let device = AVCaptureDevice.default(for: .video) {
            try? device.lockForConfiguration()
            device.torchMode = .off
            device.unlockForConfiguration()
        }
    }
}
