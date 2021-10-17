//
//  ViewController.swift
//  MLPractice
//
//  Created by 董静 on 10/14/21.
//

import UIKit
import CoreML
import Vision


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    private let imagePicker : UIImagePickerController = {
        let vc = UIImagePickerController()
        return vc
    }()
    
    private let previewImage : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "hot"
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        
        view.addSubview(previewImage)
        let rightButton = UIBarButtonItem(image: UIImage(systemName: "camera"), style: .plain, target: self, action: #selector(didClickRight))
        rightButton.tintColor = .gray
        navigationItem.rightBarButtonItem = rightButton

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewImage.frame = CGRect(x: 0, y: view.safeAreaInsets.bottom, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.bottom)
    }
    
    @objc func didClickRight() {
        present(imagePicker, animated: true) {
            
        }
    }
    
    func detect(image: CIImage) {
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("could not convert uiimage into ciimage")
        }
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model fialed to process image")
            }
            if let firstResult = results.first {
                if firstResult.identifier.contains("cello") {
                    self.title = "cello"
                }else {
                    self.title = "Not foudn"
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickeImage = info[.originalImage] as? UIImage {
            previewImage.image = pickeImage
            guard let ciimage = CIImage(image: pickeImage) else {
                fatalError("load coreml model failed")
            }
            detect(image: ciimage)
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
}

