//
//  CheckOutViewController.swift
//  PickAndPay
//
//  Created by Matt Caulder on 7/18/22.
//

import UIKit

class CheckOutViewController: UIViewController {
    
    @IBOutlet weak var TotalPrice: UILabel!
    private var total: Double = 0.0
    @IBOutlet weak var checkOutTableView: UITableView!
    
    var checkOutItems : [ShoppingCartItem] = []
    var checkOutHelper = DBHelper.dbHelper
    override func viewDidLoad() {
        super.viewDidLoad()
        checkOutTableView.delegate = self
        checkOutTableView.dataSource = self
        checkOutItems = checkOutHelper.getAllShoppingCartItem()
    }
    override func viewWillAppear(_ animated: Bool) {
        for i in 0..<checkOutItems.count{
            total = total + checkOutItems[i].price
        }
        TotalPrice.text = "Total: $\(total)"
    }
    
    @IBAction func ItemCheckOutButton(_ sender: Any) {
        checkOutItems = checkOutHelper.getAllShoppingCartItem()
        if !checkOutItems.isEmpty{
            for i in 0..<checkOutItems.count{
                checkOutHelper.deleteShoppingCartItem(checkOutItems[i].title ?? "")
            }
            checkOutItems = checkOutHelper.getAllShoppingCartItem()
            checkOutTableView.reloadData()
            TotalPrice.text = "Total: $0.00"
        }else{
            checkOutItems = checkOutHelper.getAllShoppingCartItem()
        }
    }
    
}
extension CheckOutViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkOutItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckOutCell", for: indexPath) as! CheckOutTableViewCell
        cell.checkOutTitle.text = checkOutItems[indexPath.row].title
        cell.checkOutPrice.text = String(checkOutItems[indexPath.row].price)
        let url = URL(string: checkOutItems[indexPath.row].image!)
                let data = try? Data(contentsOf: url!)

                if let imageData = data {
                    cell.itemImage.image = UIImage(data: imageData)
                }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
