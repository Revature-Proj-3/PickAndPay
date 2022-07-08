//
//  HomePageViewController.swift
//  PickAndPay
//
//  Created by admin on 6/30/22.
//

import UIKit
import Combine

class HomePageViewController: UIViewController, UISearchBarDelegate {

    let viewModel = HomePageViewModel.HomePageViewModelHelper

    let userDefault = UserDefaults.standard
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var catCollectionView: UICollectionView!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInLabel: UILabel!
    
    @IBOutlet weak var loadingIndicator2: UIActivityIndicatorView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var welcomeText: UILabel!
    var observer : AnyCancellable?
    private var products : [Product] = []
    private var categories : [Product] = []
    private var featuredProducts : [Product] = []
    let searchBarDelegate = SearchBarDelegateFile()
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = searchBarDelegate
        viewModel.setGuestUser()
        loadingIndicator.startAnimating()
        loadingIndicator2.startAnimating()
        observer = viewModel.getProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] products in
            self?.featuredProducts = (self?.viewModel.getFeaturedProducts(products))!
            self?.categories = (self?.viewModel.filterCategories(products))!
            self?.featuredCollectionView.reloadData()
            self?.catCollectionView.reloadData()
            self?.loadingIndicator.stopAnimating()
            self?.loadingIndicator2.stopAnimating()
        })
        
        print(userDefault.string(forKey: "currentLoggedIn")!)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let currentUser = userDefault.string(forKey: "currentLoggedIn")
        if currentUser != "guest" {
            welcomeText.isHidden = false
            signInLabel.text = currentUser
            signInButton.isHidden = true
            createAccountButton.isHidden = true
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let page = storyBoard.instantiateViewController(withIdentifier: "Login")
        show(page, sender: Any?.self)
    }
    
    @IBAction func createAccount(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let page = storyBoard.instantiateViewController(withIdentifier: "CreateAccount")
        show(page, sender: Any?.self)
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


