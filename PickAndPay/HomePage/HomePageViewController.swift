//
//  HomePageViewController.swift
//  PickAndPay
//
//  Created by admin on 6/30/22.
//

import UIKit
import Combine

class HomePageViewController: UIViewController {

    let viewModel = HomePageViewModel.HomePageViewModelHelper


    @IBOutlet weak var catCollectionView: UICollectionView!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    
    var observer : AnyCancellable?
    private var products : [Product] = []
    private var categories : [Product] = []
    private var featuredProducts : [Product] = []
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        observer = viewModel.getProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] products in
            self?.featuredProducts = (self?.viewModel.getFeaturedProducts(products))!
            self?.categories = (self?.viewModel.filterCategories(products))!
            self?.featuredCollectionView.reloadData()
            self?.catCollectionView.reloadData()
        })
    }
    
    @IBAction func signIn(_ sender: Any) {
        
    }
    
}

// MARK: - UICOllectionViewDelegate, UICOllectionViewDataSource
extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == catCollectionView {
            return categories.count
        }else {
            return featuredProducts.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == catCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as!      HomePageCategoryCollectionViewCell
            cell.label.text = categories[indexPath.row].category
            let url = URL(string: categories[indexPath.row].image)
                    let data = try? Data(contentsOf: url!)

                    if let imageData = data {
                        cell.img.image = UIImage(data: imageData)
                    }
            return cell
        }else{
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as! FeaturedCollectionViewCell
            cell2.itemDescription.text = featuredProducts[indexPath.row].description
            let url = URL(string: featuredProducts[indexPath.row].image)
                    let data = try? Data(contentsOf: url!)

                    if let imageData = data {
                        cell2.img.image = UIImage(data: imageData)
                    }
            
            return cell2
        }
    }

}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == featuredCollectionView{
            return CGSize(width: self.view.frame.width, height: 180.0)
        }else {
            return CGSize(width: 130, height: 80)
        }
    }
}


