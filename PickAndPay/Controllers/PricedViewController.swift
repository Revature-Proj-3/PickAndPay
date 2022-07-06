//
//  PricedViewController.swift
//  PickAndPay
//
//  Created by Corey Augburn on 7/1/22.
//

import UIKit

class PricedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = descript
        
        priceLabel.text = price
        
        priceImg.image = pricedPicture
        
        
    }
    

    @IBOutlet weak var priceImg: UIImageView!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    
    
    var descript = ""
    var price =  ""
    var pricedPicture = UIImage()
    
}
