//
//  LoginViewController.swift
//  PickAndPay
//
//  Created by Zachary Saffron on 7/1/22.
//

import UIKit

@IBDesignable extension UIButton {
    
    @IBInspectable var borderWidth: CGFloat {
           set {
               layer.borderWidth = newValue
           }
           get {
               return layer.borderWidth
           }
       }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

class LoginViewController: UIViewController {

    @IBOutlet weak var signInOutline: UIButton!
    @IBOutlet weak var createAccountOutline: UIButton!
    @IBOutlet weak var bag: UIImageView!
    @IBOutlet weak var box: UIImageView!
    @IBOutlet weak var list: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        images()
        
    }
    
    func images() {
        bag.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        bag.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        bag.layer.shadowOpacity = 1.0
        bag.layer.shadowRadius = 2.0
        bag.layer.masksToBounds = false
        bag.layer.cornerRadius = 4.0
        
        box.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        box.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        box.layer.shadowOpacity = 1.0
        box.layer.shadowRadius = 2.0
        box.layer.masksToBounds = false
        box.layer.cornerRadius = 4.0
        
        list.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        list.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        list.layer.shadowOpacity = 1.0
        list.layer.shadowRadius = 2.0
        list.layer.masksToBounds = false
        list.layer.cornerRadius = 4.0
    }

    @IBAction func signInButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let loginNextScreen = storyboard.instantiateViewController(withIdentifier: "Login")
        //show the tab controller as an instantiated vc
        loginNextScreen.modalPresentationStyle = .fullScreen
        self.present(loginNextScreen, animated: true, completion: nil)
    }
    
    @IBAction func createAccountButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let createNextScreen = storyboard.instantiateViewController(withIdentifier: "CreateAccount")
        //show the tab controller as an instantiated vc
        createNextScreen.modalPresentationStyle = .fullScreen
        self.present(createNextScreen, animated: true, completion: nil)
    }
}
