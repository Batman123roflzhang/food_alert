//
//  ViewController.swift
//  SeeFood
//
//  Created by Reza Shirazian on 7/23/17.
//  Copyright © 2017 Reza Shirazian. All rights reserved.
//

import UIKit
import CoreML
import Vision
import AVFoundation
import Alamofire

class ViewController: UIViewController, FrameExtractorDelegate {
 
  var frameExtractor: FrameExtractor!
  var result = String()
  
  @IBOutlet weak var previewImage: UIImageView!
  @IBOutlet weak var iSee: UILabel!
  @IBOutlet weak var modalConstraint: NSLayoutConstraint!
  @IBOutlet weak var confirmButton: UIButton!
  
  var settingImage = false
  var status = false
  
  var currentImage: CIImage? {
    didSet {
      if let image = currentImage{
        self.detectScene(image: image)
      }
    }
  }
  @IBAction func confirmRecognition(_ sender: UIButton) {
    if self.result != ""
    {
      performSegue(withIdentifier: "segue", sender: self)
    }
  }
  override func viewDidLoad() {
    self.confirmButton.backgroundColor = UIColor.orange
    self.confirmButton.layer.cornerRadius = 5
    super.viewDidLoad()
    frameExtractor = FrameExtractor()
    frameExtractor.delegate = self
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    var modalController = segue.destination as! ModalViewController
    modalController.myString = self.result
  }
  
  func captured(image: UIImage) {
    self.previewImage.image = image
    if let cgImage = image.cgImage, !settingImage {
      settingImage = true
      DispatchQueue.global(qos: .userInteractive).async {[unowned self] in
        self.currentImage = CIImage(cgImage: cgImage)
      }
    }
  }

  func detectScene(image: CIImage) {
    guard let model = try? VNCoreMLModel(for: food().model) else {
      fatalError()
    }
    // Create a Vision request with completion handler
    let request = VNCoreMLRequest(model: model) { [unowned self] request, error in
      guard let results = request.results as? [VNClassificationObservation],
        let _ = results.first else {
          self.settingImage = false
          return
      }
      
      DispatchQueue.main.async { [unowned self] in
        if let first = results.first {
          if (first.confidence > 0.6) {
            self.result = first.identifier
            self.status = true
          }
          if (first.confidence > 0.01) {
            self.settingImage = false
          }
        }
      }
    }
    let handler = VNImageRequestHandler(ciImage: image)
    DispatchQueue.global(qos: .userInteractive).async {
      do {
        try handler.perform([request])
      } catch {
        print(error)
      }
    }
  }
}

