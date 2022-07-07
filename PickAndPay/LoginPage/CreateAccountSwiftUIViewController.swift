//
//  CreateAccountSwiftUIViewController.swift
//  PickAndPay
//
//  Created by admin on 7/7/22.
//

import UIKit
import SwiftUI

class CreateAccountSwiftUIViewController: UIViewController {

    @IBOutlet weak var container : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let childView = UIHostingController(rootView: SwiftUICreateAccountView())
        addChild(childView)
        childView.view.frame = container.bounds
        container.addSubview(childView.view)
        
    }

}
