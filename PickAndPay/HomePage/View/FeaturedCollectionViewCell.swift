//
//  FeaturedCollectionViewCell.swift
//  PickAndPay
//
//  Created by admin on 7/1/22.
//

import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    
   
    @IBOutlet weak var itemDescription: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    public func configure(_ arr : [Product], _ curIndex : Int){
        if arr[curIndex].description.isEmpty{
            self.itemDescription.text = ""
        }else {
            self.itemDescription.text = arr[curIndex].description
        }
        let url = URL(string: arr[curIndex].image)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            self.img.image = UIImage(data: imageData)
        }
    }

}

