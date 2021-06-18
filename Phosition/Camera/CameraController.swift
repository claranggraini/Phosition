//
//  CameraController.swift
//  Phosition
//
//  Created by Clara Anggraini on 07/06/21.
//

import UIKit
import AVFoundation
import Vision

class CameraController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {

    var bufferSize: CGSize = .zero
    var rootLayer: CALayer! = nil
    var takePicture = false
    var grid = true
    var canShoot = false
    
    @IBOutlet weak private var gridView: UIView!
    @IBOutlet weak public var previewView: UIView!
    @IBOutlet weak var photoButton: UIButton!
    let session = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer! = nil
    let videoDataOutput = AVCaptureVideoDataOutput()
    
    private let videoDataOutputQueue = DispatchQueue(label: "VideoDataOutput", qos: .userInitiated, attributes: [], autoreleaseFrequency: .workItem)
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // to be implemented in the subclass
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoButton.backgroundColor = .white
        photoButton.tintColor = .white
        photoButton.layer.cornerRadius = 50
        setupAVCapture()
        drawGrid()
        
    }
    
//    override func drawRect(rect: CGRect) {
//        let aPath = UIBezierPath()
//
//        aPath.move(to: CGPoint(x: gridView.frame.minX, y: gridView.frame.minY))
//        aPath.addLine(to: CGPoint(x: gridView.frame.maxX, y: gridView.frame.maxY))
//
//        // Keep using the method addLine until you get to the one where about to close the path
//        aPath.close()
//
//        // If you want to stroke it with a red color
//        UIColor.red.set()
//        aPath.lineWidth = 1
//        aPath.stroke()
//    }
    
    @IBAction func onTapTakePhoto(_ sender: Any){
        if canShoot == true {
            takePicture = true
        } else {
            let alert = UIAlertController(title: "Cannot Take Photo", message: "You must put the object in the correct position first until the box turns green", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func onTapCancel(_ sender: Any){
        session.stopRunning()
        performSegue(withIdentifier: "unwindToDetail", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupAVCapture() {
        var deviceInput: AVCaptureDeviceInput!
        
        // Select a video device, make an input
        let videoDevice = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .back).devices.first
        do {
            deviceInput = try AVCaptureDeviceInput(device: videoDevice!)
        } catch {
            print("Could not create video device input: \(error)")
            return
        }
        
        session.beginConfiguration()
        session.sessionPreset = .vga640x480 // Model image size is smaller.
        
        // Add a video input
        guard session.canAddInput(deviceInput) else {
            print("Could not add video device input to the session")
            session.commitConfiguration()
            return
        }
        session.addInput(deviceInput)
        if session.canAddOutput(videoDataOutput) {
            session.addOutput(videoDataOutput)
            // Add a video data output
            videoDataOutput.alwaysDiscardsLateVideoFrames = true
            videoDataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: Int(kCVPixelFormatType_420YpCbCr8BiPlanarFullRange)]
            videoDataOutput.setSampleBufferDelegate(self, queue: videoDataOutputQueue)
        } else {
            print("Could not add video data output to the session")
            session.commitConfiguration()
            return
        }
        
        let captureConnection = videoDataOutput.connection(with: .video)
        // Always process the frames
        captureConnection?.isEnabled = true
        do {
            try  videoDevice!.lockForConfiguration()
            let dimensions = CMVideoFormatDescriptionGetDimensions((videoDevice?.activeFormat.formatDescription)!)
            bufferSize.width = CGFloat(dimensions.width)
            bufferSize.height = CGFloat(dimensions.height)
            
            print(bufferSize.width)
            print(bufferSize.height)
            
            videoDevice!.unlockForConfiguration()
        } catch {
            print(error)
        }
        session.commitConfiguration()
        previewLayer = AVCaptureVideoPreviewLayer(session: session)
        previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        rootLayer = previewView.layer
//        rootLayer.backgroundColor = UIColor.gray.cgColor
        previewLayer.frame = rootLayer.bounds
        rootLayer.addSublayer(previewLayer)
//        previewLayer.backgroundColor = UIColor.white.cgColor
    }
    
    func startCaptureSession() {
        session.startRunning()
    }
    
    // Clean up capture setup
    func teardownAVCapture() {
        previewLayer.removeFromSuperlayer()
        previewLayer = nil
    }
    
    func captureOutput(_ captureOutput: AVCaptureOutput, didDrop didDropSampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        // print("frame dropped")
    }
    
    public func exifOrientationFromDeviceOrientation() -> CGImagePropertyOrientation {
        let curDeviceOrientation = UIDevice.current.orientation
        let exifOrientation: CGImagePropertyOrientation
        
        switch curDeviceOrientation {
        case UIDeviceOrientation.portraitUpsideDown:  // Device oriented vertically, home button on the top
            exifOrientation = .left
        case UIDeviceOrientation.landscapeLeft:       // Device oriented horizontally, home button on the right
            exifOrientation = .upMirrored
        case UIDeviceOrientation.landscapeRight:      // Device oriented horizontally, home button on the left
            exifOrientation = .down
        case UIDeviceOrientation.portrait:            // Device oriented vertically, home button on the bottom
            exifOrientation = .up
        default:
            exifOrientation = .up
        }
        return exifOrientation
    }
    
    func drawGrid() {
        // create path

        let patha = UIBezierPath()
        patha.move(to: CGPoint(x: gridView.frame.width/3, y: 3))
        patha.addLine(to: CGPoint(x: gridView.frame.width/3, y: gridView.frame.height+3))
        
        let pathb = UIBezierPath()
        patha.move(to: CGPoint(x: gridView.frame.width*2/3, y: 3))
        patha.addLine(to: CGPoint(x: gridView.frame.width*2/3, y: gridView.frame.height+3))
        
        let pathc = UIBezierPath()
        pathc.move(to: CGPoint(x: 0, y: gridView.frame.height/3+3))
        pathc.addLine(to: CGPoint(x: gridView.frame.width, y: gridView.frame.height/3+3))
        
        let pathd = UIBezierPath()
        pathd.move(to: CGPoint(x: 0, y: gridView.frame.height*2/3+3))
        pathd.addLine(to: CGPoint(x: gridView.frame.width, y: gridView.frame.height*2/3+3))

        // Create a `CAShapeLayer` that uses that `UIBezierPath`:
        
        let shapeLayera = CAShapeLayer()
        shapeLayera.path = patha.cgPath
        shapeLayera.strokeColor = UIColor.white.cgColor
        shapeLayera.fillColor = UIColor.clear.cgColor
        shapeLayera.lineWidth = 1
        
        let shapeLayerb = CAShapeLayer()
        shapeLayerb.path = pathb.cgPath
        shapeLayerb.strokeColor = UIColor.white.cgColor
        shapeLayerb.fillColor = UIColor.clear.cgColor
        shapeLayerb.lineWidth = 1
        
        let shapeLayerc = CAShapeLayer()
        shapeLayerc.path = pathc.cgPath
        shapeLayerc.strokeColor = UIColor.white.cgColor
        shapeLayerc.fillColor = UIColor.clear.cgColor
        shapeLayerc.lineWidth = 1
        
        let shapeLayerd = CAShapeLayer()
        shapeLayerd.path = pathd.cgPath
        shapeLayerd.strokeColor = UIColor.white.cgColor
        shapeLayerd.fillColor = UIColor.clear.cgColor
        shapeLayerd.lineWidth = 1

        // Add that `CAShapeLayer` to your view's layer:

        gridView.layer.addSublayer(shapeLayera)
        gridView.layer.addSublayer(shapeLayerb)
        gridView.layer.addSublayer(shapeLayerc)
        gridView.layer.addSublayer(shapeLayerd)
        
        gridView.isHidden = false
    }
    
    @IBAction func onTapGridShow(_ sender: Any){
        print("tapped button")
        if grid == false {
            gridView.isHidden = false
            grid = true
        } else {
            gridView.isHidden = true
            grid = false
        }
    }
}

