//
//  LoginViewController.swift
//  PickAndPay
//
//  Created by Zachary Saffron on 7/1/22.
//

import UIKit
import Combine

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
           set {
               layer.borderWidth = newValue
           }
           get {
               return layer.borderWidth
           }
       }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

class LoginViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NewTableView{
    

    @IBOutlet weak var signInOutline: UIButton!
    @IBOutlet weak var createAccountOutline: UIButton!
    @IBOutlet weak var bag: UIImageView!
    @IBOutlet weak var box: UIImageView!
    @IBOutlet weak var list: UIImageView!
    @IBOutlet weak var wishListTableView: UITableView!
    
    var wishListItems : [WishListItem] = []
    var cartHelper = DBHelper.dbHelper
    var observer : AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        images()
        
        wishListTableView.delegate = self
        wishListTableView.dataSource = self
        wishListItems = cartHelper.getWishListItem()
        //
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(!wishListItems.isEmpty){
            wishListTableView.isHidden = false
        }else{
            wishListTableView.isHidden = true
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishListItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LoginTableViewCell
        
        myCell.index = indexPath
        myCell.cellDelegate = self
        
        myCell.wishLabel.text = wishListItems[indexPath.row].title
        myCell.wishPrice.text = String(wishListItems[indexPath.row].price)
        
        // change to nil coal with label
        let url = URL(string: wishListItems[indexPath.row].image!)
        let data = try? Data(contentsOf: url!)
        
        if let imageData = data {
            myCell.wishImg.image = UIImage(data: imageData)
        }
        
        return myCell
    }
    
    
    func onCellClick(index: Int) {
        var title = wishListItems[index].title!
        var productDescription = wishListItems[index].productDescription!
        var image = wishListItems[index].image!
        var category = wishListItems[index].category!
        var price = wishListItems[index].price
        var rate = wishListItems[index].rate
        var count = wishListItems[index].count
        cartHelper.addShoppingCartItem(title, productDescription, image, category, price, rate, count)
        let cartItemDelete = wishListItems.remove(at: index)
        // Cart Item delete
        cartHelper.context!.delete(cartItemDelete)
        //
        do{
            try cartHelper.context!.save()
        }
        catch{
            print("error deleting item")
        }
        wishListTableView.reloadData()
        cartHelper.getWishListItem()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

            guard editingStyle == .delete
            else { return }
            let cartItemDelete = wishListItems.remove(at: indexPath.row)
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
    
    
    
    func images() {
        bag.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        bag.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        bag.layer.shadowOpacity = 1.0
        bag.layer.shadowRadius = 2.0
        bag.layer.masksToBounds = false
        bag.layer.cornerRadius = 4.0
        
        box.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        box.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        box.layer.shadowOpacity = 1.0
        box.layer.shadowRadius = 2.0
        box.layer.masksToBounds = false
        box.layer.cornerRadius = 4.0
        
        list.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        list.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        list.layer.shadowOpacity = 1.0
        list.layer.shadowRadius = 2.0
        list.layer.masksToBounds = false
        list.layer.cornerRadius = 4.0
    }

}
