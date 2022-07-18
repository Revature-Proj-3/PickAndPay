//
//  HomePageCategoryCollectionViewCell.swift
//  PickAndPay
//
//  Created by admin on 6/30/22.
//

import UIKit

class HomePageCategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    public func configure(_ arr : [Product], _ curIndex : Int){
        if arr[curIndex].category.isEmpty{
            self.label.text = ""
        }else {
            self.label.text = arr[curIndex].category
        }
        let url = URL(string: arr[curIndex].image)
        let data = try? Data(contentsOf: url!)
        if let imageData = data {
            self.img.image = UIImage(data: imageData)
        }
    }
}
