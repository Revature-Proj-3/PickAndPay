//
//  PricedViewController.swift
//  PickAndPay
//
//  Created by Corey Augburn on 7/1/22.
//

import UIKit

class PricedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = descript
        priceLabel.text = price
        priceImg.fetchImage(urlString: productImg)
        priceTitle.text = productTitle
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        descriptionLabel.sizeToFit()
        scroll.contentSize = CGSize(width: self.descriptionLabel.frame.width, height: self.descriptionLabel.frame.height + 20)
    }
    
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var priceImg: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceTitle: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var descript = ""
    var price =  ""
    var productImg = ""
    var productTitle = ""
    
    
    @IBAction func addToCart(_ sender: Any) {
        
        
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
