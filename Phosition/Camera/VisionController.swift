//
//  VisionController.swift
//  Phosition
//
//  Created by Jonathan Clive on 09/06/21.
//

import UIKit
import AVFoundation
import Vision

class VisionController: CameraController {
    
    private var detectionOverlay: CALayer! = nil
    
    // Vision parts
    private var requests = [VNRequest]()
    
    private var found = false
    var tabController: UITabBarController?
    var selCompTitle: String?
    var capturedImage: UIImage?
    @discardableResult
    func setupVision() -> NSError? {
        // Setup Vision parts
        let error: NSError! = nil
        
        guard let modelURL = Bundle.main.url(forResource: "YOLOv3Tiny", withExtension: "mlmodelc") else {
            return NSError(domain: "VisionController", code: -1, userInfo: [NSLocalizedDescriptionKey: "Model file is missing"])
        }
        do {
            let visionModel = try VNCoreMLModel(for: MLModel(contentsOf: modelURL))
            let objectRecognition = VNCoreMLRequest(model: visionModel, completionHandler: { (request, error) in
                DispatchQueue.main.async(execute: {
                    // perform all the UI updates on the main queue
                    if let results = request.results {
                        self.drawVisionRequestResults(results)
                    }
                })
            })
            self.requests = [objectRecognition]
        } catch let error as NSError {
            print("Model loading went wrong: \(error)")
        }
        
        return error
    }
    
    func drawVisionRequestResults(_ results: [Any]) {
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        found = false
        detectionOverlay.sublayers = nil // remove all the old recognized objects
        for observation in results where observation is VNRecognizedObjectObservation {
            if found == false {
                guard let objectObservation = observation as? VNRecognizedObjectObservation else {
                    continue
                }
                // Select only the label with the highest confidence.
                let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
                
                let shapeLayer = self.createRoundedRectLayerWithBounds(objectBounds)
                
                detectionOverlay.addSublayer(shapeLayer)
                found = true
            }
        }
        self.updateLayerGeometry()
        CATransaction.commit()
    }
    
    override func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        
        let exifOrientation = exifOrientationFromDeviceOrientation()
        
        let imageRequestHandler = VNImageRequestHandler(cvPixelBuffer: pixelBuffer, orientation: exifOrientation, options: [:])
        do {
            try imageRequestHandler.perform(self.requests)
        } catch {
            print(error)
        }
        
        if !takePicture {
            return
        }
        
        //get a CIImage out of the CVImageBuffer
        
        
        let ciImage = CIImage(cvImageBuffer: pixelBuffer)
        guard let cgImage = cgImage(from: ciImage) else { return }
        //get UIImage out of CIImage
        let uiImage = UIImage(cgImage: cgImage, scale: 1, orientation: .right)
        capturedImage = uiImage
        
        DispatchQueue.main.async {
            
            self.session.stopRunning()
            self.performSegue(withIdentifier: "congratsSegue", sender: self)
        }
        
        print("ada foto")
        
        takePicture = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "congratsSegue"{
            let dest = segue.destination as! CongratulationController
            dest.selCompTitle = selCompTitle
            dest.tabController = tabController
            dest.capturedImg = capturedImage
        }
    }
    
    func cgImage(from ciImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
    
    override func setupAVCapture() {
        super.setupAVCapture()
        
        // setup Vision parts
        if selCompTitle == "Leading Lines" {
            
        } else {
            self.setupLayers()
            self.updateLayerGeometry()
            self.setupVision()
        }
        
        // start the capture
        startCaptureSession()
    }
    
    func setupLayers() {
        detectionOverlay = CALayer() // container layer that has all the renderings of the observations
        detectionOverlay.name = "DetectionOverlay"
        detectionOverlay.bounds = CGRect(x: 0.0,
                                         y: 0.0,
                                         width: bufferSize.width,
                                         height: bufferSize.height)
        detectionOverlay.position = CGPoint(x: rootLayer.bounds.midX, y: rootLayer.bounds.midY)
        rootLayer.addSublayer(detectionOverlay)
    }
    
    func updateLayerGeometry() {
        let bounds = rootLayer.bounds
        var scale: CGFloat
        
        let xScale: CGFloat = bounds.size.width / bufferSize.height
        let yScale: CGFloat = bounds.size.height / bufferSize.width
        
        scale = fmax(xScale, yScale)
        if scale.isInfinite {
            scale = 1.0
        }
        CATransaction.begin()
        CATransaction.setValue(kCFBooleanTrue, forKey: kCATransactionDisableActions)
        
        // rotate the layer into screen orientation and scale and mirror
        detectionOverlay.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: scale, y: -scale))
        // center the layer
        detectionOverlay.position = CGPoint(x: bounds.midX, y: bounds.midY)
        
        CATransaction.commit()
        
    }
    
    func createRoundedRectLayerWithBounds(_ bounds: CGRect) -> CALayer {
        let shapeLayer = CALayer()
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        let position1 = bufferSize.width/3
        let position2 = bufferSize.width*2/3
        let position3 = bufferSize.height/3
        let position4 = bufferSize.height*2/3
        
        
        shapeLayer.name = "Found Object"
        if selCompTitle == "Rule of Thirds" {
            if bounds.minX < position1 && bounds.maxX > position1 || bounds.minX < position2 && bounds.maxX > position2{
                if bounds.minY < position3 && bounds.maxY > position3 || bounds.minY < position4 && bounds.maxY > position4 {
                    shapeLayer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
                    photoButton.backgroundColor = .white
                    canShoot = true
                } else {
                    shapeLayer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
                    photoButton.backgroundColor = .secondaryLabel
                    canShoot = false
                }
            } else {
                shapeLayer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
                photoButton.backgroundColor = .secondaryLabel
                canShoot = false
            }
            shapeLayer.cornerRadius = 7
        } else {
            shapeLayer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
            photoButton.backgroundColor = .white
            canShoot = true
        }
        
        return shapeLayer
    }
    
    func testShapeLayer(_ bounds: CGRect) -> CALayer {
        
        let testShape = CALayer()
        testShape.bounds = bounds
        testShape.position = CGPoint(x: previewView.frame.maxX, y: previewView.frame.maxY)
        
        testShape.backgroundColor = UIColor.blue.cgColor
        
        return testShape
    }
    
    @IBAction func unwindCamera(_ segue: UIStoryboardSegue){
        session.startRunning()
    }
}
