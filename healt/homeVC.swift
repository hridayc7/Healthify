//
//  homeVC.swift
//  healt
//
//  Created by Hriday Chhabria on 12/25/19.
//  Copyright © 2019 Hriday Chhabria. All rights reserved.
//

import UIKit

class homeVC: UIViewController {
    
    @IBOutlet weak var editProfileButton: UIButton!
    @IBOutlet weak var welcome: UILabel!
    
    @IBOutlet weak var lifeLabel: UILabel!
    
    //Buttons
    
    @IBOutlet weak var sacnFoodButton: UIButton!
    
    @IBOutlet weak var searchForFoodButton: UIButton!
    
    @IBOutlet weak var enterFoodButton: UIButton!
    
    
    //Labels for Data
    @IBOutlet weak var carbCount: UILabel!
    @IBOutlet weak var proteinCount: UILabel!
    @IBOutlet weak var fatCount: UILabel!
    @IBOutlet weak var addedSugarsCount: UILabel!
    @IBOutlet weak var satFatCount: UILabel!
    @IBOutlet weak var transFatsCount: UILabel!
    @IBOutlet weak var sodiumcount: UILabel!
    

    let defaults = UserDefaults.standard
    
    
    //MARK: - OTHER IMPORTANT LABELS
    
    @IBOutlet weak var carbData: UILabel!
    @IBOutlet weak var proteinData: UILabel!
    @IBOutlet weak var fatData: UILabel!
    @IBOutlet weak var addedSugarsDaata: UILabel!
    @IBOutlet weak var saturatedFatsDataa: UILabel!
    @IBOutlet weak var transFatData: UILabel!
    @IBOutlet weak var sodiumData: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.styleFilledButton(editProfileButton)
        
        Utilities.styleFilledButton(sacnFoodButton)
        
        Utilities.styleFilledButton(searchForFoodButton)
        
        Utilities.styleFilledButton(enterFoodButton)

        var counter = defaults.integer(forKey: "Counter")
        counter += 1
        defaults.set(counter, forKey: "Counter")
        
        if(counter<2){
            welcome.text = ""
            lifeLabel.text = ""
            editProfileButton.alpha = 0
            //Elenents(0.0)
            counter += 2
            performSegue(withIdentifier: "editProfileSegue", sender: nil)
            defaults.set(0, forKey: "carbohydrates")
            defaults.set(0, forKey: "proteins")
            defaults.set(0, forKey: "fats")
            defaults.set(0, forKey: "addedSugars")
            defaults.set(0, forKey: "saturatedFats")
            defaults.set(0, forKey: "transFats")
            defaults.set(0.0, forKey: "sodium")

            self.view.isHidden = true
        }
        else
        {
            //Main View Did Load
            self.view.isHidden = false
            print("Hello View is here lol")
            editProfileButton.alpha = 1
            welcome.text = defaults.string(forKey: "FirstName")! + " " + defaults.string(forKey: "LastName")!
            
            carbCount.text = defaults.string(forKey: "CarbLabel")
            proteinCount.text = defaults.string(forKey: "ProteinLabel")
            fatCount.text = defaults.string(forKey: "fatLabel")
            addedSugarsCount.text = defaults.string(forKey: "addeedSugarsLabel")
            satFatCount.text = defaults.string(forKey: "satFatLabel")
            transFatsCount.text = defaults.string(forKey: "transFatLabel")
            sodiumcount.text = defaults.string(forKey: "sodiumLabel")
            
            carbData.text = "\(defaults.integer(forKey: "carbohydrates"))"
            proteinData.text = "\(defaults.integer(forKey: "proteins"))"
            fatData.text = "\(defaults.integer(forKey: "fats"))"
            addedSugarsDaata.text = "\(defaults.integer(forKey: "addedSugars"))"
            saturatedFatsDataa.text =  "\(defaults.integer(forKey: "saturatedFats"))"
            transFatData.text = "\(defaults.integer(forKey: "transFats"))"
            sodiumData.text = "\(defaults.double(forKey: "sodium"))"
            
            
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
     @IBAction func unwindToAnimationSegue(_ sender: UIStoryboardSegue) {}
    
    
    
    
}
