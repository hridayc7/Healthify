//
//  ViewController.swift
//  healt
//
//  Created by Hriday Chhabria on 12/23/19.
//  Copyright © 2019 Hriday Chhabria. All rights reserved.
//

import UIKit


extension String {
    func capitalizingFirstLetter() -> String {
      return prefix(1).uppercased() + self.lowercased().dropFirst()
    }

    mutating func capitalizeFirstLetter() {
      self = self.capitalizingFirstLetter()
    }
}


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{

    @IBOutlet weak var imageGallery: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var lifeStyleField: UITextField!
    @IBOutlet weak var warningLabels: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    
    
    var sedentaryImages: [UIImage] = []
    var moderateImages: [UIImage] = []
    var activeImages: [UIImage]  = []
    var pickerData: [String] = [String]()
    
    
    
    //MARK: User Default Setups
    let defaults = UserDefaults.standard
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()

        //Hide Keyboard
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        sedentaryImages = createImageArray(total: 300, imagePrefix: "sedentary")
        moderateImages = createImageArray(total: 300, imagePrefix: "moderate")
        activeImages = createImageArray(total: 300, imagePrefix: "active")
        
        animate(imageView: imageGallery, images: sedentaryImages)

        pickerData = ["Sedentary", "Moderate", "Active"]
        self.picker.dataSource = self
        self.picker.delegate = self
        
        
        firstNameField.text = defaults.string(forKey: "FirstName");
        lastNameField.text = defaults.string(forKey: "LastName");

        
        //check coindition here

        
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    //MARK: - Animation Methods
    func createImageArray(total: Int, imagePrefix: String) -> [UIImage] {
        
        var imageArray: [UIImage] = []
        
        for imageCount in 0..<total {
            let imageName = "\(imagePrefix)-\(imageCount).png"
            let image = UIImage(named: imageName)!
            
            imageArray.append(image)
        }
        return imageArray
    }
    
    func animate(imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images
        imageView.animationDuration = 7.0
        imageView.startAnimating()
    }
    
    //MARK: - Sign Up Tapped
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        print("Sign Up Tapped")
        
        let first = formValidation(name: firstNameField.text!)
        let last = formValidation(name: lastNameField.text!)
        
        userInfo.setInformation(name: first, lastNameA: last, lyf: lifeStyleField.text!)
    
        defaults.set(first, forKey: "FirstName")
        defaults.set(last, forKey: "LastName")
        defaults.set(lifeStyleField.text!, forKey: "Style")
        
        print("Defaults Modifield")
    }
    
    //MARK: - Pickerview methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectAnimation(pickerData[row])
    }
    
    //MARK: - Styling
    
    func styleElements(){
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameField)
        Utilities.styleTextField(lastNameField)
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleTextField(lifeStyleField)
    }
    
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! homeVC
        
        
        let first = formValidation(name: firstNameField.text!)
        let last = formValidation(name: lastNameField.text!)
        
        destinationVC.welcome.text = "\(first) " + " " + "\(last)"
        
        
        destinationVC.lifeLabel.text = "Lifestyle: \(lifeStyleField.text!)"
        destinationVC.editProfileButton.alpha = 1.0
        let life = lifeStyleField.text!

        if(life == "Sedentary")
        {
            destinationVC.carbCount.text = "/289"
            destinationVC.proteinCount.text = "/50"
            destinationVC.fatCount.text = "/50"
            destinationVC.addedSugarsCount.text = "/10"
            destinationVC.satFatCount.text = "/7"
            destinationVC.transFatsCount.text = "/0"
            destinationVC.sodiumcount.text = "/2.4"
            
            
        }
        else if(life == "Moderate")
        {
            destinationVC.carbCount.text = "/300"
            destinationVC.proteinCount.text = "/50"
            destinationVC.fatCount.text = "/65"
            destinationVC.addedSugarsCount.text = "/20"
            destinationVC.satFatCount.text = "/20"
            destinationVC.transFatsCount.text = "/2"
            destinationVC.sodiumcount.text = "/2.4"
        }
        else
        {
            destinationVC.carbCount.text = "/375"
            destinationVC.proteinCount.text = "/50"
            destinationVC.fatCount.text = "/80"
            destinationVC.addedSugarsCount.text = "/20"
            destinationVC.satFatCount.text = "/25"
            destinationVC.transFatsCount.text = "/2"
            destinationVC.sodiumcount.text = "/2.4"
        }
        
        defaults.set(destinationVC.carbCount.text, forKey: "CarbLabel")
        defaults.set(destinationVC.proteinCount.text, forKey: "ProteinLabel")
        defaults.set(destinationVC.fatCount.text, forKey: "fatLabel")
        defaults.set(destinationVC.addedSugarsCount.text, forKey: "addeedSugarsLabel")
        defaults.set(destinationVC.satFatCount.text, forKey: "satFatLabel")
        defaults.set(destinationVC.transFatsCount.text, forKey: "transFatLabel")
        defaults.set(destinationVC.sodiumcount.text, forKey: "sodiumLabel")


        destinationVC.self.view.isHidden = false
    }
    
    func selectAnimation(_ type: String)
    {
        if(type == "Sedentary")
        {
            animate(imageView: imageGallery, images: sedentaryImages)
        }
        else if(type == "Moderate")
        {
            animate(imageView: imageGallery, images: moderateImages)
        }
        else
        {
            animate(imageView: imageGallery, images: activeImages)
        }
        lifeStyleField.text = type
    }
    
    
    func formValidation(name: String) -> String{
        var token = name.lowercased()
        token = token.trimmingCharacters(in: .whitespaces)
        token.capitalizeFirstLetter()
        return token
    }

}

