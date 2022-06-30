//
//  HomePageViewController.swift
//  PickAndPay
//
//  Created by admin on 6/30/22.
//

import UIKit

class HomePageViewController: UIViewController {


    let data = [dummyData(name: "Test1"), dummyData(name: "Test2")]
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //pageControl.numberOfPages = data.count
        
        
    }

}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath.row) as! HomePageCategoryCollectionViewCell
    }
    
    
}

struct dummyData {
    var name : String
}

