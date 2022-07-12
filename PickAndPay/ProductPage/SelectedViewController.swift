//
//  SelectedViewController.swift
//  PickAndPay
//
//  Created by Corey Augburn on 7/1/22.
//

import UIKit
import Combine

class SelectedViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    let orderViewModel = OrderViewModel.OrderViewModelHelper
    let viewModel = HomePageViewModel.HomePageViewModelHelper
    
    var observer : AnyCancellable?
    var productSeclected : [Product] = []
//    var products : [Product] = []

    @IBOutlet weak var collectionSelect: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionSelect.dataSource = self
        collectionSelect.delegate = self
        
        topicLabel.text = topic.capitalized
        
        observer = orderViewModel.getProducts(from: self.topicLabel.text!.lowercased())
                    .receive(on: DispatchQueue.main)
                    .sink(receiveValue: { [weak self] products in
                        print("These are the ", products)
                        self?.productSeclected = products
                    self?.collectionSelect.reloadData()
                        print("This is the ", self?.productSeclected)
                })
        
//        observer = orderViewModel.getProducts(from: self.topicLabel.text!)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: { [weak self] products in
//                print("These are the ", products)
//                self?.productSeclected = (self?.orderViewModel.fetchProducts(products))!
//            self?.collectionSelect.reloadData()
//                print("This is the ", self?.productSeclected)
//        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionSelect.reloadData()
        sleep(1)
    }
    
    
    @IBOutlet weak var topicLabel: UILabel!
    

    
    var topic = ""
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productSeclected.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SelectedCollectionViewCell
        
        myCell.productName.text = productSeclected[indexPath.row].title
        myCell.productPrice.text = String( productSeclected[indexPath.row].price)
        let url = URL(string: productSeclected[indexPath.row].image)
                let data = try? Data(contentsOf: url!)

                if let imageData = data {
                    myCell.productImg.image = UIImage(data: imageData)
                }
        
        return myCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var storyBoard2 = UIStoryboard(name: "Order", bundle: nil)
        var pricedVC = storyBoard2.instantiateViewController(withIdentifier: "PricedOrder") as! PricedViewController
        
//        var storyBoard3 = UIStoryboard(name: "Order", bundle: nil)
//        
////        var pCV = storyBoard3.instantiateViewController(withIdentifier: "PricedOrder") as! PricedCollectionViewController
//        
//        
////        pCV.descript = productSeclected[indexPath.row].description
        
        pricedVC.price = String(productSeclected[indexPath.row].price)
        pricedVC.descript = productSeclected[indexPath.row].description
        pricedVC.productImg = productSeclected[indexPath.row].image
        pricedVC.productTitle = productSeclected[indexPath.row].title
        show(pricedVC, sender: Any?.self)
    }
    
    
}
