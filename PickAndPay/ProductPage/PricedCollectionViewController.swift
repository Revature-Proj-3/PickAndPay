//
//  PricedCollectionViewController.swift
//  PickAndPay
//
//  Created by Corey Augburn on 7/8/22.
//

import UIKit


class PricedCollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        

//        priceLabel.text = price
//
//        priceImg.fetchImage(urlString: productImg)
//
//        priceTitle.text = productTitle
        
        
//        priceCollection.reloadData()
    }
    
//@IBOutlet weak var priceTitle: UILabel!
//    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var priceImg: UIImageView!
////@IBOutlet weak var priceCollection: UICollectionView!
    
//    var descript = ""
//    var price =  ""
//    var productImg = ""
//    var productTitle = ""

   

    // MARK: UICollectionViewDataSource



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PricedCollectionViewCell
    
//        myCell.productLabel.text = String(descript)
    
        return myCell
    }



}

//extension UIImageView{
//    func fetchImage(urlString: String){
//        let urlRequest = URL(string: urlString)
//                if urlRequest == nil{
//                    print("url does not exist")
//                    return
//                }
//                print("url does exista")
//                let dataTask = URLSession.shared.dataTask(with: urlRequest!, completionHandler: { data, response, error in
//                    if error == nil && data != nil{
//                        let image = UIImage(data: data!)
//                        DispatchQueue.main.async { [self] in
//                            self.image = image
//
//
//                        }
//                    }
//                    else{
//                        print("error loading web image")
//                    }
//                })
//                dataTask.resume()
//            }
//}
