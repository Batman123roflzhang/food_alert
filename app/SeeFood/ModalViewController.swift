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
  @IBOutlet weak var overallLabel: UILabel!
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
            let numClassOne = JSON["num_class_1"] as! NSNumber
            let numClassTwo = JSON["num_class_2"] as! NSNumber
            let numClassThree = JSON["num_class_3"] as! NSNumber
            self.proteinLabel.text = "Protein: \(protein) g"
            self.overallLabel.text = "Overall Ratings: \(overallRatings)"
            self.nutritionLabel.text = "Nutrition Ratings: \(nutritionRatings)"
            self.class1Label.text = "Class I: \(numClassOne)"
            self.class2Label.text = "Class II: \(numClassTwo)"
            self.class3Label.text = "Class III: \(numClassThree)"
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
