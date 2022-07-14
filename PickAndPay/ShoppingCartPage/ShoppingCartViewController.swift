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
    var cartItems : [ShoppingCartItem] = []
    var cartHelper = DBHelper.dbHelper
    @IBOutlet weak var checkOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
        cartItems = cartHelper.getAllShoppingCartItem()
        

    }
    override func viewWillAppear(_ animated: Bool) {
        print("appear")
        cartItems = cartHelper.getAllShoppingCartItem()
        if(cartItems.isEmpty){
            shoppingCartTableView.isHidden = true
            checkOut.isHidden = true
            shoppingCartImage.isHidden = false
            cartEmptyText.isHidden = false
        } else{
            shoppingCartTableView.isHidden = false
            shoppingCartImage.isHidden = true
            cartEmptyText.isHidden = true
            checkOut.isHidden = false
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
        cell.textLabel?.text = cartItems[indexPath.row].title
        cell.detailTextLabel?.text = cartItems[indexPath.row].productDescription
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cartHelper.deleteShoppingCartItem(cartItems[indexPath.row].title!)
        self.shoppingCartTableView.reloadData()
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
        catch{}
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
}



