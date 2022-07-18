//
//  CheckOutTableViewCell.swift
//  PickAndPay
//
//  Created by Matt Caulder on 7/18/22.
//

import UIKit

class CheckOutTableViewCell: UITableViewCell {
    @IBOutlet weak var checkOutTitle: UILabel!
    @IBOutlet weak var checkOutPrice: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
