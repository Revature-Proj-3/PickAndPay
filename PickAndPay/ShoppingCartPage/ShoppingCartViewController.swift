//
//  ShoppingCartViewController.swift
//  PickAndPay
//
//  Created by Matt Caulder on 7/1/22.
//

import UIKit
import SwiftUI

class ShoppingCartViewController: UIViewController {
    @IBOutlet weak var shoppingCartTableView: UITableView!
    @IBOutlet weak var shoppingCartImage: UIImageView!
    @IBOutlet weak var cartEmptyText: UILabel!
    @IBOutlet weak var signIn: UIButton!
    @IBOutlet weak var signUp: UIButton!
    var cartItems : [ShoppingCartItem] = []
    var cartHelper = DBHelper.dbHelper
    let userDefault = UserDefaults.standard
    @IBOutlet weak var checkOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
        cartItems = cartHelper.getAllShoppingCartItem()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        cartItems = cartHelper.getAllShoppingCartItem()
        let currentUser = userDefault.string(forKey: "currentLoggedIn")
        if(cartItems.isEmpty){
            shoppingCartTableView.isHidden = true
            checkOut.isHidden = true
            shoppingCartImage.isHidden = false
            cartEmptyText.isHidden = false
        } else{
            shoppingCartTableView.isHidden = false
            shoppingCartImage.isHidden = true
            cartEmptyText.isHidden = true
            if currentUser != "guest@guest.com" {
                checkOut.isHidden = false
            }else{
                checkOut.isHidden = true
            }
        }
        if currentUser != "guest@guest.com"{
            signIn.isHidden = true
            signUp.isHidden = true
        }
        
        self.shoppingCartTableView.reloadData()
    }
    
    @IBAction func signIn(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let page = storyBoard.instantiateViewController(withIdentifier: "Login")
        show(page, sender: Any?.self)
    }
    @IBAction func signUp(_ sender: Any) {
        let storyBoard = UIStoryboard(name: "Login", bundle: nil)
        let page = storyBoard.instantiateViewController(withIdentifier: "CreateAccount")
        show(page, sender: Any?.self)
    }

}






//MARK: - TableView Extension
extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCartCell", for: indexPath) as! ShoppingCartTableViewCell
        cell.cartTitle.text = cartItems[indexPath.row].title
        cell.cartPrice.text = String(cartItems[indexPath.row].price)
        let url = URL(string: cartItems[indexPath.row].image!)
                let data = try? Data(contentsOf: url!)

                if let imageData = data {
                    cell.cartImage.image = UIImage(data: imageData)
                }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete
        else { return }
        let cartItemDelete = cartItems.remove(at: indexPath.row)
        // Cart Item delete
        cartHelper.context!.delete(cartItemDelete)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        do{
            try cartHelper.context!.save()
        }
        catch{
            print("error deleting item")
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Order", bundle: nil)
        let pricedVC = storyBoard.instantiateViewController(withIdentifier: "PricedOrder") as! PricedViewController
        pricedVC.price = String(cartItems[indexPath.row].price)
        pricedVC.descript = cartItems[indexPath.row].productDescription!
        pricedVC.productImg = cartItems[indexPath.row].image!
        pricedVC.productTitle = cartItems[indexPath.row].title!
        pricedVC.productCategory = cartItems[indexPath.row].category!
        show(pricedVC, sender: Any?.self)
    }
    
}



