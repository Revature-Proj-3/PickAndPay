//
//  OrderViewModel.swift
//  PickAndPay
//
//  Created by Corey Augburn on 7/7/22.
//

import Foundation
import Combine

class OrderViewModel{
    
    static var OrderViewModelHelper = OrderViewModel()
    
    let constants = Constants()
    var response = [Product]()
    
    
    func getProducts(from url: String) -> AnyPublisher<[Product], Never>{
        
        var newUrl = url.replacingOccurrences(of: " ", with: "%20")
        let publisher = URLSession.shared.dataTaskPublisher(for: URL(string: "\(constants.apiURL)/category/\(newUrl)")!)
            .map({$0.data})
            .decode(type: [Product].self, decoder: JSONDecoder())
            .catch({ _ in
                Just([])
            })
                .eraseToAnyPublisher()
        
        return publisher
        
    }
    
    
    func fetchProducts(_ arr : [Product]) -> [Product] {
        self.response.removeAll()
        var items = arr[0]
        response.append(arr[0])
        for i in arr{
            response.append(i)
        }
        return response
    }
    
    
    
    
    
}
