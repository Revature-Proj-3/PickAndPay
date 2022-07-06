//
//  ShoppingCartViewController.swift
//  PickAndPay
//
//  Created by Matt Caulder on 7/1/22.
//

import UIKit

class ShoppingCartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}



//MARK: - TableView Extension
extension ShoppingCartViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "shoppingCartCell", for: indexPath) as! ShoppingCartTableViewCell
        return cell
    }
    
    
}
