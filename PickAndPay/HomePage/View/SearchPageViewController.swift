//
//  SearchPageViewController.swift
//  PickAndPay
//
//  Created by admin on 7/13/22.
//

import UIKit

class SearchPageViewController: UIViewController {

    var products = [Product]()
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if products.isEmpty{
            errorLabel.isHidden = false
            collectionView.isHidden = true
        }else{
            errorLabel.isHidden = true
            collectionView.isHidden = false
        }
    }
    
}

extension SearchPageViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as!      SearchPageCollectionViewCell
        cell.productTitle.text = products[indexPath.row].title
        cell.productPrice.text = "$" + String(products[indexPath.row].price)
        let url = URL(string: products[indexPath.row].image)
                let data = try? Data(contentsOf: url!)

                if let imageData = data {
                    cell.img.image = UIImage(data: imageData)
                }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let storyBoard = UIStoryboard(name: "Order", bundle: nil)
            let pricedVC = storyBoard.instantiateViewController(withIdentifier: "PricedOrder") as! PricedViewController
            pricedVC.price = String(products[indexPath.row].price)
            pricedVC.descript = products[indexPath.row].description
            pricedVC.productImg = products[indexPath.row].image
            pricedVC.productTitle = products[indexPath.row].title
            pricedVC.productCategory = products[indexPath.row].category
            
            show(pricedVC, sender: Any?.self)
        
    }
    
}

extension SearchPageViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.width, height: 180.0)
    }
}
