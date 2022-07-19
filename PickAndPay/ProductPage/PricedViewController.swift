//
//  PricedViewController.swift
//  PickAndPay
//
//  Created by Corey Augburn on 7/1/22.
//

import UIKit

class PricedViewController: UIViewController {

    var dbHelper = DBHelper.dbHelper
    var orderView = OrderViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = descript
        priceLabel.text = orderView.priceSetter(price: price)
        priceImg.fetchImage(urlString: productImg)
        priceTitle.text = productTitle
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        descriptionLabel.sizeToFit()
        scroll.contentSize = CGSize(width: self.descriptionLabel.frame.width, height: self.descriptionLabel.frame.height + 5)
        
        print("This is the db Healer", dbHelper.getAllShoppingCartItem())
        print("this is userData", dbHelper.getUserData("guest@guest.com"))
        print("this is wish", dbHelper.getWishListItem())
    }
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var priceImg: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    
    var descript = ""
    var price =  ""
    var productImg = ""
    var productTitle = ""
    var productCategory = ""
    var productRate = 0
   
    
    @IBAction func stepper(_ sender: UIStepper) {
        let numberFomatter = NumberFormatter()
        let formatNumber = numberFomatter.string(for: sender.value)
        stepperLabel.text = formatNumber
    }
    
    @IBAction func addToCart(_ sender: Any) {
        
        var newPrice = Double(price)
        var productCount = Int32(stepperLabel.text!)!
        
        dbHelper.addShoppingCartItem(productTitle, descript, productImg, productCategory, newPrice!, Int32(productRate), productCount)
        
        let dialogMessage = UIAlertController(title: "Item Added", message: " Item added to Cart", preferredStyle: .alert)

            // Create Confirm button with action handler
            let confirm = UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            print("Confirm button tapped")

            })

            // Add Confrim and Cancel button to dialog message
            dialogMessage.addAction(confirm)

            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
    }
    
    
    @IBAction func wishListBtn(_ sender: Any) {
        
        var newPrice = Double(price)
        var productCount = Int32(stepperLabel.text!)!
        
        let dialogMessage = UIAlertController(title: "Item Added", message: "Would you like to add your Item to WishList", preferredStyle: .alert)

            // Create Confirm button with action handler
            let confirm = UIAlertAction(title: "Confirm", style: .default, handler: { (action) -> Void in
            print("Confirm button tapped")

            })

            // Add Confrim and Cancel button to dialog message
            dialogMessage.addAction(confirm)

            // Present dialog message to user
            self.present(dialogMessage, animated: true, completion: nil)
        
        dbHelper.addWishListItem(productTitle, descript, productImg, productCategory, newPrice!, Int32(productRate), productCount)
    }
    
    

    
    

}


extension UIImageView{
    func fetchImage(urlString: String){
        let urlRequest = URL(string: urlString)
                if urlRequest == nil{
                    print("url does not exist")
                    return
                }
                print("url does exista")
                let dataTask = URLSession.shared.dataTask(with: urlRequest!, completionHandler: { data, response, error in
                    if error == nil && data != nil{
                        let image = UIImage(data: data!)
                        DispatchQueue.main.async { [self] in
                            self.image = image
                        }
                    }
                    else{
                        print("error loading web image")
                    }
                })
                dataTask.resume()
            }
}
