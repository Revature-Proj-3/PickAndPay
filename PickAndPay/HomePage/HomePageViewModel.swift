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
    
    func setGuestUser(){
        do{
            let request = User.fetchRequest() as NSFetchRequest<User>
            let pred = NSPredicate(format: "email == %@", "guest@guest.com" )
            request.predicate = pred
            let userArr = try context?.fetch(request)
            let user = userArr?.first
            if user?.email != nil {
                userDefault.set("guest", forKey: "currentLoggedIn")
                return
            }else{
                let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
                user.name = "guest"
                user.email = "guest@guest.com"
                user.phoneNumber = "N/A"
                user.password = "N/A"
                user.balance = 0.00
                do{
                    try context?.save()
                } catch{
                    print("Error saving user")
                }
            }
        }catch{
            print("error fetching user")
        }
        userDefault.set("guest", forKey: "currentLoggedIn")
    }
    
    func getFeaturedProducts(_ arr : [Product]) -> [Product] {
        
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

