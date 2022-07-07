//
//  LoginSwiftUIViewController.swift
//  PickAndPay
//
//  Created by admin on 7/7/22.
//

import UIKit
import SwiftUI

class LoginSwiftUIViewController: UIViewController {
    
    @IBOutlet weak var container : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let childView = UIHostingController(rootView: SwiftUILoginView())
        addChild(childView)
        childView.view.frame = container.bounds
        container.addSubview(childView.view)
        
    }

}
