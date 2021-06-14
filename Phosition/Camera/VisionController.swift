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
                let topLabelObservation = objectObservation.labels[0]
                let objectBounds = VNImageRectForNormalizedRect(objectObservation.boundingBox, Int(bufferSize.width), Int(bufferSize.height))
                
                let shapeLayer = self.createRoundedRectLayerWithBounds(objectBounds)
//                let testLayer = self.testShapeLayer(objectBounds)
                
                let textLayer = self.createTextSubLayerInBounds(objectBounds,
                                                                identifier: topLabelObservation.identifier,
                                                                confidence: topLabelObservation.confidence)
                shapeLayer.addSublayer(textLayer)
                
                detectionOverlay.addSublayer(shapeLayer)
//                detectionOverlay.addSublayer(testLayer)
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
        let uiImage = UIImage(cgImage: cgImage)
        
        DispatchQueue.main.async {
            self.imageVieww.image = uiImage
        }
        
        UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
        
        print("ada foto")
        
        takePicture = false
    }
    
    func cgImage(from ciImage: CIImage) -> CGImage? {
        let context = CIContext(options: nil)
        return context.createCGImage(ciImage, from: ciImage.extent)
    }
    
    override func setupAVCapture() {
        super.setupAVCapture()
        
        // setup Vision parts
//        DispatchQueue.global(qos: .userInitiated).async {
            self.setupLayers()
            self.updateLayerGeometry()
            self.setupVision()
//        }
        
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
    
    func createTextSubLayerInBounds(_ bounds: CGRect, identifier: String, confidence: VNConfidence) -> CATextLayer {
        let textLayer = CATextLayer()
        textLayer.name = "Object Label"
        let formattedString = NSMutableAttributedString(string: String(format: "\(identifier)\nConfidence:  %.2f", confidence))
        let largeFont = UIFont(name: "Helvetica", size: 24.0)!
        formattedString.addAttributes([NSAttributedString.Key.font: largeFont], range: NSRange(location: 0, length: identifier.count))
        textLayer.string = formattedString
        textLayer.bounds = CGRect(x: 0, y: 0, width: bounds.size.height - 10, height: bounds.size.width - 10)
        textLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        textLayer.shadowOpacity = 0.7
        textLayer.shadowOffset = CGSize(width: 2, height: 2)
        textLayer.foregroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.0, 0.0, 0.0, 1.0])
        textLayer.contentsScale = 2.0 // retina rendering
        // rotate the layer into screen orientation and scale and mirror
        textLayer.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(.pi / 2.0)).scaledBy(x: 1.0, y: -1.0))
        return textLayer
    }
    
    func createRoundedRectLayerWithBounds(_ bounds: CGRect) -> CALayer {
        let shapeLayer = CALayer()
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
//        print(bounds.midX)
//        print(bounds.midY)
        let screenRect: CGRect = previewView.frame
        let position1 = screenRect.height*2/3 - screenRect.minY + 10
        let position2 = position1*2
        
        print("position1: \(position1)")
        print("position2: \(position2)")
        print("jarak: \(screenRect.height/3)")
        print(bounds.minX)
        print(bounds.maxX)
        print(screenRect.minY)
//        print(bounds.midX)
//        print(bounds.midY)
//        print(bounds.midY - screenRect.width/3)
//        print(bounds.midY - screenRect.width/3*2)
        shapeLayer.name = "Found Object"
//        shapeLayer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 0.2, 0.4])
        if bounds.minX < position1 && bounds.maxX > position1 {
            shapeLayer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
        } else if bounds.minX < position2 && bounds.maxX > position2 {
            shapeLayer.backgroundColor = UIColor.green.withAlphaComponent(0.5).cgColor
        } else {
            shapeLayer.backgroundColor = UIColor.red.withAlphaComponent(0.5).cgColor
        }
        shapeLayer.cornerRadius = 7
        return shapeLayer
    }
    
    func testShapeLayer(_ bounds: CGRect) -> CALayer {
        
        let testShape = CALayer()
        testShape.bounds = bounds
        testShape.position = CGPoint(x: previewView.frame.maxX, y: previewView.frame.maxY)
        
        testShape.backgroundColor = UIColor.blue.cgColor
        
        return testShape
    }
    
}
