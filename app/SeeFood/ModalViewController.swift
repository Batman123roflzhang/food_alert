//
//  ModalViewController.swift
//  SeeFood
//
//  Created by Shao-An Chien on 9/8/18.
//  Copyright © 2018 Reza Shirazian. All rights reserved.
//

import UIKit
import Alamofire

class ModalViewController: UIViewController {

  @IBOutlet weak var noDataLabel: UILabel!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var proteinLabel: UILabel!
  @IBOutlet weak var sugarsLabel: UILabel!
  @IBOutlet weak var energyLabel: UILabel!
  @IBOutlet weak var fatLabel: UILabel!
    
  @IBOutlet weak var overallLabel: UILabel!
  @IBOutlet weak var carbohydrateLabel: UILabel!
  @IBOutlet weak var class1Label: UILabel!
  @IBOutlet weak var class2Label: UILabel!
  @IBOutlet weak var class3Label: UILabel!
  @IBOutlet weak var nutritionLabel: UILabel!
  @IBOutlet weak var contentView: UIView!
  
  var myString = String()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    titleLabel.text = myString
    Alamofire.request("http://hsiaoyi0504.pythonanywhere.com/food/" + myString, method: .get)
      .responseJSON { response in
        if let JSON = response.result.value as? [String: Any] {
          let foodName = JSON["food_name"] as! String
          self.titleLabel.text = foodName
          if JSON["return_ratings"] != nil
          {
            self.contentView.isHidden = false
            self.noDataLabel.isHidden = true
            let overallRatings = JSON["return_ratings"] as! NSNumber
            let nutritionRatings = JSON["nutrition_ratings"] as! NSNumber
            let protein = JSON["protein"] as! NSNumber
            let sugars = JSON["sugars"] as! NSNumber
            let carbohydrate = JSON["carbohydrate"] as! NSNumber
            let fat = JSON["fat"] as! NSNumber
            let energy = JSON["energy"] as! NSNumber
            let numClassOne = JSON["num_class_1"] as! NSNumber
            let numClassTwo = JSON["num_class_2"] as! NSNumber
            let numClassThree = JSON["num_class_3"] as! NSNumber
            self.proteinLabel.text = "- Protein (per 100g): \(protein) g"
            self.sugarsLabel.text = "- Sugars (per 100g): \(sugars) g"
            self.carbohydrateLabel.text = "- Carbohydrates (per 100g): \(carbohydrate) g"
            self.fatLabel.text = "- Fat (per 100g): \(fat) g"
            self.energyLabel.text = "- Calories (per 100g): \(energy) J"
            self.overallLabel.text = "\(overallRatings)"
            self.nutritionLabel.text = "Nutrition Rating: \(nutritionRatings)"
            self.class1Label.text = "Number of Class I Recall: \(numClassOne)"
            self.class2Label.text = "Number of Class II Recall: \(numClassTwo)"
            self.class3Label.text = "Number of Class III Recall: \(numClassThree)"
          } else {
            self.contentView.isHidden = true
            self.noDataLabel.isHidden = false
          }
          
        }
    }


    // Do any additional setup after loading the view.
  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  @IBAction func dismissModal(_ sender: UIButton) {
//    dismissModal(sender)
    dismiss(animated: true, completion: nil)
  }
  /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
