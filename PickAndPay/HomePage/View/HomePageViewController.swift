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

    let userDefault = UserDefaults.standard
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var catCollectionView: UICollectionView!
    @IBOutlet weak var featuredCollectionView: UICollectionView!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signInLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loadingIndicator2: UIActivityIndicatorView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var welcomeText: UILabel!
    var observer : AnyCancellable?
    private var products : [Product] = []
    private var categories : [Product] = []
    private var featuredProducts : [Product] = []
    let searchBarDelegate = SearchBarDelegateFile.searchHelper
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = User()
        print(user)
        searchBar.delegate = self
        //searchBar.delegate = searchBarDelegate
        loadingIndicator.startAnimating()
        loadingIndicator2.startAnimating()
        
//        observer = viewModel.getProducts()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: { [weak self] products in
//                print(products)
//                if(products.isEmpty){
//                    print("products is empty")
//                    self?.loadingIndicator.stopAnimating()
//                    self?.loadingIndicator2.stopAnimating()
//                    self?.catCollectionView.isHidden = true
//                    self?.featuredCollectionView.isHidden = true
//                    self?.errorLabel.isHidden = false
//                    return
//                }
//            self?.featuredProducts = (self?.viewModel.getFeaturedProducts(products)) ?? []
//            self?.categories = (self?.viewModel.filterCategories(products)) ?? []
//            self?.products = (self?.viewModel.productList) ?? []
//            self?.featuredCollectionView.reloadData()
//            self?.catCollectionView.reloadData()
//            self?.loadingIndicator.stopAnimating()
//            self?.loadingIndicator2.stopAnimating()
//        })
        observer = viewModel.getProducts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
               // print("in completion, ", v)
                if case let .failure(error) = completion {
                    print(error)
                    switch error {
                    case .sessionFailed ://(error: error):
                        //handle URL error
                        self.loadingIndicator.stopAnimating()
                        self.loadingIndicator2.stopAnimating()
                        self.catCollectionView.isHidden = true
                        self.featuredCollectionView.isHidden = true
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = "Please check your network"
                        return
                    case .decodingFailed:
                        //handle decoding error
                        self.loadingIndicator.stopAnimating()
                        self.loadingIndicator2.stopAnimating()
                        self.catCollectionView.isHidden = true
                        self.featuredCollectionView.isHidden = true
                        self.errorLabel.isHidden = false
                        return
                    default:
                        //handle "other" error
                        print(error)
                    }
                }
                
            }
                ,receiveValue: { [weak self] products in
//                print(products)
//                if(products.isEmpty){
//                    print("products is empty")
//                    self?.loadingIndicator.stopAnimating()
//                    self?.loadingIndicator2.stopAnimating()
//                    self?.catCollectionView.isHidden = true
//                    self?.featuredCollectionView.isHidden = true
//                    self?.errorLabel.isHidden = false
//                    return
//                }
            self?.featuredProducts = (self?.viewModel.getFeaturedProducts(products)) ?? []
            self?.categories = (self?.viewModel.filterCategories(products)) ?? []
            self?.products = (self?.viewModel.productList) ?? []
            self?.featuredCollectionView.reloadData()
            self?.catCollectionView.reloadData()
            self?.loadingIndicator.stopAnimating()
            self?.loadingIndicator2.stopAnimating()
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        let currentUser = userDefault.string(forKey: "currentLoggedIn")
        if currentUser != "guest@guest.com" {
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == featuredCollectionView {
            let storyBoard = UIStoryboard(name: "Order", bundle: nil)
            let pricedVC = storyBoard.instantiateViewController(withIdentifier: "PricedOrder") as! PricedViewController
            pricedVC.price = String(featuredProducts[indexPath.row].price)
            pricedVC.descript = featuredProducts[indexPath.row].description
            pricedVC.productImg = featuredProducts[indexPath.row].image
            pricedVC.productTitle = featuredProducts[indexPath.row].title
            pricedVC.productCategory = featuredProducts[indexPath.row].category
            
            show(pricedVC, sender: Any?.self)
        }else{
            let storyBoard = UIStoryboard(name: "Order", bundle: nil)
            let selectedVC = storyBoard.instantiateViewController(withIdentifier: "SelectedOrder") as! SelectedViewController
            selectedVC.topic = categories[indexPath.row].category

            show(selectedVC, sender: Any?.self)
        }
    }

}

extension HomePageViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        if collectionView == featuredCollectionView{
            return CGSize(width: featuredCollectionView.frame.width, height: 180.0)
            
        }else {
            return CGSize(width: 130, height: 80)
        }
    }
}

// MARK: - UISearchBarDelegate
extension HomePageViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if(searchBar.text != ""){
            let result = searchBarDelegate.findSearchItems(products, searchBar.text!)
            
            let storyBoard = UIStoryboard(name: "HomePage", bundle: nil)
            let selectedVC = storyBoard.instantiateViewController(withIdentifier: "searchPageController") as! SearchPageViewController
            
            selectedVC.products = result
            show(selectedVC, sender: Any?.self)
        }
    }
    
}
