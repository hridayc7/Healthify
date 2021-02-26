//
//  machineLearningViewController.swift
//  healt
//
//  Created by Hriday Chhabria on 1/2/20.
//  Copyright © 2020 Hriday Chhabria. All rights reserved.
//

import UIKit
import CoreML
import Vision
import ImageIO


class machineLearningViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var cameraButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleFilledButton(cameraButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        print("Button Tapped")
        
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "PhotoLibrary", style: .default, handler: { (UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[.originalImage] as? UIImage{
            imageView.image = userPickedImage
            guard let ciimage = CIImage(image: userPickedImage) else{
                fatalError("Failed to convert image")
            }
            detect(image: ciimage)
        }
        
        
        
        picker.dismiss(animated: true, completion: nil)
        //model processing here
    }
    
    func detect(image: CIImage)
    {
     
        guard let model = try? VNCoreMLModel(for: SeeFood().model) else{
            fatalError("Loading coreMl Model failure")
        }
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model Failed to process image")
            }
            //MARK:- Perfom All Result to label modification here
            print(results)
            let itemName = results.first?.identifier
            self.classificationLabel.text = itemName
            FOODDATA.setFoodItem(foo: itemName!)
            
            //MARK: - GET TEXT -> PASS IN STATIC FUNCTION (STORE THE NAME OF THE CURRENT FOOD ITEM THERE) -> SEGUE TO THE PLACE CHANGE STATIC FUNCTION BOOLEAN VALUE -> WHEN THAT APPEARS -> HAVE A CHECK ON THE VIEW DID LOAD TO SEE WHETHER PREVIOUS SCREEN WAS STATIC FUNCTION OR NOT -> IF IT WAS -> MAKE THE STATIC VARIABLE FALSE -> FILL ALL THE TEXT FIELDS WITH THE STATIC FUNCTION VALUES THAT CORRESPOND
            
            
            
        }
        let handler = VNImageRequestHandler(ciImage: image)
        do
        {
            try handler.perform([request])
        }
        catch
        {
            print(error)
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("hello")
        
        let destinationVC = segue.destination as! foodDetailsViewController
        
        FOODDATA.lastPaageWasML =  true
    }
    
    
    
}


