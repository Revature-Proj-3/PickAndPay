//
//  LoginTableViewCell.swift
//  PickAndPay
//
//  Created by Corey Augburn on 7/19/22.
//

import UIKit

protocol NewTableView{
    func onCellClick(index: Int)
}

class LoginTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBOutlet weak var wishImg: UIImageView!
    
    @IBOutlet weak var wishLabel: UILabel!
    
    @IBOutlet weak var wishPrice: UILabel!
    
    var cellDelegate : NewTableView?
    var index : IndexPath?
    
    
    @IBAction func addToCartBtn(_ sender: Any) {
        cellDelegate?.onCellClick(index: (index?.row)!)
    }
    
    
}
