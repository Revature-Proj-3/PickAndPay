//
//  HomePageViewModel.swift
//  PickAndPay
//
//  Created by admin on 7/1/22.
//

import Foundation
import UIKit
import Combine
import CoreData

class HomePageViewModel{
    static var HomePageViewModelHelper = HomePageViewModel()
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    let userDefault = UserDefaults.standard
    //let dbHelper = DBHelper.dbHelper
    let constants = Constants()
    var productList = [Product]()
    var catList = [Product]()
    var featuredProducts = [Product]()
    
    func filterCategories(_ arr : [Product]) -> [Product] {
        var current = arr[0].category
        catList.append(arr[0])
        for i in arr {
            if(i.category != current){
                current = i.category
                catList.append(i)
            }
        }
        return catList
    }
    
    func getFeaturedProducts(_ arr : [Product]) -> [Product] {
        productList = arr
        while featuredProducts.count < 6 {
            let randomProduct = arr.randomElement()
            var contains = false
            for i in featuredProducts {
                if i.title == randomProduct?.title {
                    contains = true
                }
            }
            if !contains {
                if let randomProduct = randomProduct {
                    featuredProducts.append(randomProduct)
                }
                
            }
        }

        return featuredProducts
    }
    
    func getProducts() -> AnyPublisher<[Product], Never>{
        let publisher = URLSession.shared.dataTaskPublisher(for: URL(string: constants.apiURL)!)
            .map({$0.data})
            .decode(type: [Product].self, decoder: JSONDecoder())
            .catch({ _ in
                Just([])
            })
                .eraseToAnyPublisher()

        return publisher

    }
    
}

