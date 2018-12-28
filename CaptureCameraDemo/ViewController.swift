//
//  ViewController.swift
//  CaptureCameraDemo
//
//  Created by admin on 12/27/18.
//  Copyright © 2018 admin. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCapturePhotoCaptureDelegate {

    var captureSession = AVCaptureSession()
    var backCamera: AVCaptureDevice?
    var frontCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    let photoSettings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.hevc])

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSessioin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                backCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                frontCamera = device
            }
        }
        currentCamera = backCamera
    }
    func setupInputOutput() {
        guard let camera = currentCamera else {
            return
        }
        do{
            let captureDecideInput = try AVCaptureDeviceInput(device: camera)
            captureSession.addInput(captureDecideInput)
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        } catch {
            print(error)
        }
    }
    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        cameraPreviewLayer?.frame = self.view.frame
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    func startRunningCaptureSessioin() {
        captureSession.startRunning()
    }
   

    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.captureSession.beginConfiguration()
//        // ... add camera input and photo output ...
//
//        guard
//            let audioDevice = AVCaptureDevice.default(for: .audio),
//            let audioDeviceInput = try? AVCaptureDeviceInput(device: audioDevice),
//            self.captureSession.canAddInput(audioDeviceInput)
//            else { return }
//        self.captureSession.addInput(audioDeviceInput)
//
//        self.captureSession.commitConfiguration()
//        // ... configure photo output and start running ...
//
//
//        photoOutput?.isHighResolutionCaptureEnabled = true
//        photoOutput?.isLivePhotoCaptureEnabled = (photoOutput?.isLivePhotoCaptureSupported)!
//
//        guard self.captureSession.canAddOutput(photoOutput!) else { return }
//        self.captureSession.sessionPreset = .photo
//        self.captureSession.addOutput(photoOutput!)
////        self.previewView.session = captureSession
//        captureSession.startRunning()
//
//
//        photoSettings.livePhotoMovieFileURL = self.makeUniqueTempFileURL(typeExtension: "mov")
        
        // Shoot the Live Photo, using a custom class to handle capture delegate callbacks.
        
//        self.photoOutput.capturePhoto(with: photoSettings, delegate: captureProcessor)

//    }
    
   
}

