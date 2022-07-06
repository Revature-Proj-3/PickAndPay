//
//  SelectedViewController.swift
//  PickAndPay
//
//  Created by Corey Augburn on 7/1/22.
//

import UIKit

class SelectedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        topicLabel.text = topic
        
        
    }
    
    @IBOutlet weak var topicLabel: UILabel!
    
    
    var textImg = ["grad2", "grad3", "grad4", "love"]
    
    var textLabel = ["Bold and Beautiful", "Young and Restless", "Days of Our Lives", "Love and Hip Hop"]
    
    var priceLabel = ["$2.99", "$29.99", "$19.99", "$59.99"]
    
    var topic = ""
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        textImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SelectedCollectionViewCell
        
        myCell.productName.text = textLabel[indexPath.row]
        myCell.productPrice.text = priceLabel[indexPath.row]
        myCell.productImg.image = UIImage(named: textImg[indexPath.row])
        
        return myCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var storyBoard2 = UIStoryboard(name: "Order", bundle: nil)
        var pricedVC = storyBoard2.instantiateViewController(withIdentifier: "PricedOrder") as! PricedViewController
        
        //change to nil coalesing from a force
        pricedVC.pricedPicture =   UIImage(named: textImg[indexPath.row])!
        
        
        pricedVC.price = priceLabel[indexPath.row]
        pricedVC.descript = textLabel[indexPath.row]
        
        present(pricedVC, animated: true)
    }
    
    
}
