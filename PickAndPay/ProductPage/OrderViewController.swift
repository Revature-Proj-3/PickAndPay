//
//  OrderViewController.swift
//  PickAndPay
//
//  Created by Corey Augburn on 6/30/22.
//

import UIKit

class OrderViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionViewA: UICollectionView!
    
    
    @IBOutlet weak var collectionViewB: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewA.dataSource = self
        collectionViewA.delegate = self
        
        collectionViewB.dataSource = self
        collectionViewB.delegate = self
    }
    
    var imageArrayA = [UIImage(named: "android"), UIImage(named: "html")]
    
    var imageArrayB = [UIImage(named: "android"), UIImage(named: "html"), UIImage(named: "iOS"), UIImage(named: "java"),UIImage(named: "android"), UIImage(named: "html"), UIImage(named: "iOS"), UIImage(named: "java")]
    
    var labelA = ["Android", "Html"]
    
    var labelB = ["Android", "Html", "iOs", "Java", "Android", "Html", "iOs", "Java"]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionViewA{
            return imageArrayA.count
        }
        return imageArrayB.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionViewA{
            let myCellA =  collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OrderCollectionViewCell
            myCellA.imgA.image = imageArrayA[indexPath.row]
            myCellA.labelA.text = labelA[indexPath.row]
            return myCellA
        }
        else{
            let myCellB = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! OrderCollectionViewCell
            myCellB.imgB.image = imageArrayB[indexPath.row]
            myCellB.labelB.text = labelB[indexPath.row]
            return myCellB
        }
    }
    

   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        var storyBoard = UIStoryboard(name: "Order", bundle: nil)
        var selectedVC = storyBoard.instantiateViewController(withIdentifier: "SelectedOrder") as! SelectedViewController
        
        selectedVC.topic = labelB[indexPath.row]
        present(selectedVC, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
