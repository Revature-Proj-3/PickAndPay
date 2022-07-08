//
//  ShoppingCartViewController.swift
//  PickAndPay
//
//  Created by Matt Caulder on 7/1/22.
//

import UIKit

class ShoppingCartViewController: UIViewController {
    @IBOutlet weak var shoppingCartTableView: UITableView!
    @IBOutlet weak var shoppingCartImage: UIImageView!
    @IBOutlet weak var cartEmptyText: UILabel!
    var cartItems : [ShoppingCartItem] = []
    var cartHelper = DBHelper.dbHelper
    override func viewDidLoad() {
        super.viewDidLoad()
        shoppingCartTableView.delegate = self
        shoppingCartTableView.dataSource = self
        cartItems = cartHelper.getAllShoppingCartItem()

    }
    override func viewWillAppear(_ animated: Bool) {
        if(cartItems.isEmpty){
            shoppingCartTableView.isHidden = true
            shoppingCartImage.isHidden = true
            cartEmptyText.isHidden = true
        } else{
            shoppingCartTableView.isHidden = false
            shoppingCartImage.isHidden = false
            cartEmptyText.isHidden = false
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
    }
    @IBAction func signUp(_ sender: Any) {
    }
    @IBAction func continueShopping(_ sender: Any) {
    }
    
}






//MARK: - TableView Extension
extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCartCell", for: indexPath) as! ShoppingCartTableViewCell
        
        return cell
    }
    
    
}

