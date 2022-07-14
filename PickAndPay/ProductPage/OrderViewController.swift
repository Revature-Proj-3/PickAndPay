//
//  OrderViewController.swift
//  PickAndPay
//
//  Created by Corey Augburn on 6/30/22.
//

import UIKit
import Combine

class OrderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    

    @IBOutlet weak var collectionViewB: UICollectionView!
    
    @IBOutlet weak var productErrorLabel: UILabel!
    
    
    
    let viewModel = HomePageViewModel.HomePageViewModelHelper
    
    var observer : AnyCancellable?
    private var products : [Product] = []
    private var categories : [Product] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewB.dataSource = self
        collectionViewB.delegate = self
        
        
        observer = viewModel.getProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: {[weak self] products in
                if(products.isEmpty){
                    self?.collectionViewB.isHidden = true
                    self?.productErrorLabel.isHidden = false
                    return
                }
                self?.categories = self?.viewModel.self.catList ?? []
                self?.collectionViewB.reloadData()
            })
        
        

    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return categories.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let myCellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OrderCollectionViewCell

            
        myCellB.labelB.text = categories[indexPath.row].category.capitalized
            
            let url = URL(string: categories[indexPath.row].image)
                    let data = try? Data(contentsOf: url!)
                    if let imageData = data {
                        myCellB.imgB.image = UIImage(data: imageData)
                   }

            return myCellB
        }

    

   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        var storyBoard = UIStoryboard(name: "Order", bundle: nil)
        var selectedVC = storyBoard.instantiateViewController(withIdentifier: "SelectedOrder") as! SelectedViewController
        selectedVC.topic = categories[indexPath.row].category
        show(selectedVC, sender: Any?.self)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 500, height: 900)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

