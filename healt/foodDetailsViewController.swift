//
//  foodDetailsViewController.swift
//  healt
//
//  Created by Hriday Chhabria on 1/1/20.
//  Copyright © 2020 Hriday Chhabria. All rights reserved.
//

import UIKit

class foodDetailsViewController: UIViewController {
    
    
    let defaults = UserDefaults()
    
    //MARK: - Textfiled Declarations
    
    @IBOutlet weak var itemNameField: UITextField!
    @IBOutlet weak var servingSizeField: UITextField!
    @IBOutlet weak var numServingsField: UITextField!
    @IBOutlet weak var carbohydratesField: UITextField!
    @IBOutlet weak var proteinsField: UITextField!
    @IBOutlet weak var fatsField: UITextField!
    @IBOutlet weak var addedSugarsField: UITextField!
    @IBOutlet weak var saturatedFatsField: UITextField!
    @IBOutlet weak var transFatsField: UITextField!
    @IBOutlet weak var sodiumField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    
    //MARK: - viewDidLoad()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styling()
        if(FOODDATA.lastPaageWasML)
        {
            print("True")
            FOODDATA.lastPaageWasML = false
            carbohydratesField.text = "\(FOODDATA.getCabrs())"
            proteinsField.text = "\(FOODDATA.getProteins())"
            fatsField.text = "\(FOODDATA.getFats())"
            addedSugarsField.text = "\(FOODDATA.getAddedSugars())"
            saturatedFatsField.text = "\(FOODDATA.getSatFats())"
            transFatsField.text = "\(FOODDATA.getTransFats())"
            sodiumField.text = "\(FOODDATA.getSodium()/1000)"
        }
        //mlUpdateLabels()
        
        //CHECK FOR THE BLOLEAN ISSUE
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    
    
    //MARK: - dismissKeyboard()
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK: -  hideNavigationBar()
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func styling(){
        
        Utilities.styleTextField(itemNameField)
        Utilities.styleTextField(servingSizeField)
        Utilities.styleTextField(numServingsField)
        Utilities.styleTextField(carbohydratesField)
        Utilities.styleTextField(proteinsField)
        Utilities.styleTextField(fatsField)
        Utilities.styleTextField(addedSugarsField)
        Utilities.styleTextField(saturatedFatsField)
        Utilities.styleTextField(transFatsField)
        Utilities.styleTextField(sodiumField)
        Utilities.styleFilledButton(doneButton)
    }
    
    @IBAction func doneTapped(_ sender: Any) {
        
        let servingSize = getVale(text: numServingsField.text!)
        
        
        let carbs = defaults.integer(forKey: "carbohydrates") + (servingSize * getVale(text: carbohydratesField.text!))
        defaults.set(carbs, forKey: "carbohydrates")
        
        let proteins = defaults.integer(forKey: "proteins") + (servingSize * getVale(text: proteinsField.text!))
        defaults.set(proteins, forKey: "proteins")
        
        let fats = defaults.integer(forKey: "fats") + (servingSize * getVale(text: fatsField.text!))
        defaults.set(fats, forKey: "fats")
        
        let addedSugars = defaults.integer(forKey: "addedSugars") + (servingSize * getVale(text: addedSugarsField.text!))
        defaults.set(addedSugars, forKey: "addedSugars")
        
        let saturatedFats = defaults.integer(forKey: "saturatedFats") + (servingSize * getVale(text: saturatedFatsField.text!))
        defaults.set(saturatedFats, forKey: "saturatedFats")
        
        let transFats = defaults.integer(forKey: "transFats") + (servingSize * getVale(text: transFatsField.text!))
        defaults.set(transFats, forKey: "transFats")
        
        var sodium = defaults.double(forKey: "sodium")
        let value = sodiumGetVal(text: sodiumField.text!) / 1000.0
        sodium = sodium + (Double(servingSize) * value)
        defaults.set(sodium, forKey: "sodium")
        
    }
    
    func getVale(text: String) -> Int{
        let value = Int(text) ?? 0
        return value
    }
    
    func sodiumGetVal(text: String) -> Double
    {
        let value = Double(text) ?? 0
        return value
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let servingSize = getVale(text: numServingsField.text!)
        let destinationVC = segue.destination as! homeVC
        
        destinationVC.carbData.text = "\(getVale(text: destinationVC.carbData.text!) + (servingSize * getVale(text: carbohydratesField.text!)))"
        destinationVC.proteinData.text = "\(getVale(text: destinationVC.proteinData.text!) + (servingSize * getVale(text: proteinsField.text!)))"
        destinationVC.fatData.text = "\(getVale(text: destinationVC.fatData.text!) + (servingSize * getVale(text: fatsField.text!)))"
        destinationVC.addedSugarsDaata.text = "\(getVale(text: destinationVC.addedSugarsDaata.text!) + (servingSize * getVale(text: addedSugarsField.text!)))"
        destinationVC.saturatedFatsDataa.text = "\(getVale(text: destinationVC.saturatedFatsDataa.text!) + (servingSize * getVale(text: saturatedFatsField.text!)))"
        destinationVC.transFatData.text = "\(getVale(text: destinationVC.transFatData.text!) + (servingSize * getVale(text: transFatsField.text!)))"
        
        //fix here
        var sodium = sodiumGetVal(text: destinationVC.sodiumData.text!)
        let value = sodiumGetVal(text: sodiumField.text!) / 1000.0
        sodium = sodium + (Double(servingSize) * value)
        destinationVC.sodiumData.text = "\(sodium)"
        
    }
    
    func mlUpdateLabels()
    {
        if(FOODDATA.lastPaageWasML == true)
        {
            print("Here")
            FOODDATA.lastPaageWasML = false
            carbohydratesField.text = " \(FOODDATA.getCabrs())"
        }
            
    }
    
    
    
    
    
    
}
