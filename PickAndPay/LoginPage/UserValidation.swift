//
//  UserValidation.swift
//  PickAndPay
//
//  Created by Zachary Saffron on 7/7/22.
//

import Foundation
import Combine

class UserValidation: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var mobile = ""
    @Published var password = ""
    @Published var reEnterPassword = ""
    
    @Published var isNameValid = false
    @Published var isEmailValid = false
    @Published var isMobileValid = false
    @Published var isPasswordValid = false
    @Published var isPasswordEqual = false
    @Published var canSubmit = false
    private var cancellableSet: Set<AnyCancellable> = []
    
    let namePredicate = NSPredicate(format: "SELF MATCHES %@", "(?<! )[-a-zA-Z' ]{2,26}")
    
    let emailPredicate = NSPredicate(format: "SELF MATCHES %@", "(?:[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}~-]+(?:\\.[a-zA-Z0-9!#$%\\&'*+/=?\\^_`{|}" +
                                                                "~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\" +
                                                                "x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-" +
                                                                "z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5" +
                                                                "]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-" +
                                                                "9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21" +
                                                                "-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])")
    
    let mobilePredicate = NSPredicate(format: "SELF MATCHES %@", "^\\d{10}$")
    
    let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$")
    
    init() {
        $name.map { name in
            return self.namePredicate.evaluate(with: name)
        }
        .assign(to: \.isNameValid, on: self)
        .store(in: &cancellableSet)
        
        $email.map { email in
            return self.emailPredicate.evaluate(with: email)
        }
        .assign(to: \.isEmailValid, on: self)
        .store(in: &cancellableSet)
        
        $mobile.map { mobile in
            return self.mobilePredicate.evaluate(with: mobile)
        }
        .assign(to: \.isMobileValid, on: self)
        .store(in: &cancellableSet)
        
        $password.map { password in
            return self.passwordPredicate.evaluate(with: password)
        }
        .assign(to: \.isPasswordValid, on: self)
        .store(in: &cancellableSet)
        
        Publishers.CombineLatest($password, $reEnterPassword).map { password, reEnterPassword in
            return password == reEnterPassword
        }
        .assign(to: \.isPasswordEqual, on: self)
        .store(in: &cancellableSet)
        
        Publishers.CombineLatest($isNameValid, $isMobileValid)
            .map { isNameValid, isMobileValid in
                return (isNameValid && isMobileValid)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
        
        Publishers.CombineLatest3($isEmailValid, $isPasswordValid, $isPasswordEqual)
            .map { isEmailValid, isPasswordValid, isPasswordEqual in
                return (isEmailValid && isPasswordValid && isPasswordEqual)
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellableSet)
    }
    
    var namePrompt: String {
        isNameValid ? "" : "Required"
    }
    
    var emailPrompt: String {
        isEmailValid ? "" : "Enter a valid email address"
    }
    
    var mobilePrompt: String {
        isMobileValid ? "" : "Required"
    }
    
    var passwordPrompt: String {
        isPasswordValid ? "" : "Invalid Password"
    }
    
    var confirmPasswordPrompt: String {
        isPasswordEqual ? "" : "Password fields do not match"
    }
    
    func didRegisterAccountValidation(input: String?) -> Bool {
        var validInput = false
        if input != nil && input != "" && !input!.isEmpty {
            validInput = true
        }
        return validInput
    }
    
    func didRegisterAccountNewUser(email: String) -> User {
        let newUser = DBHelper.dbHelper.getUserData(email)
        return newUser
    }
    
    func regexValidation(value: String, regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: value)
    }
    
    func regexCredentials(name: String, email: String, mobile: String, password: String, reEnterPassword: String) -> Bool {
        var validation = false
        if !isNameValid {
        }
        else if !isEmailValid {
            }
            else if !isMobileValid {
                }
                else if !isPasswordValid {
                    }
                    else if !isPasswordEqual {
                        }
                        else {
                            validation = true
                        }
                return validation
            }
    
    func signUp() -> Bool {
        let name = name
        let email = email
        let mobile = mobile
        let password = password
        let reEnterPassword = reEnterPassword
        
    if !(didRegisterAccountValidation(input: name) && didRegisterAccountValidation(input: email) && didRegisterAccountValidation(input: password) && didRegisterAccountValidation(input: reEnterPassword) && didRegisterAccountValidation(input: mobile)) {
        return false
        
    } else if !regexCredentials(name: name, email: email, mobile: mobile, password: password, reEnterPassword: reEnterPassword) {
        return false
        }

        else if DBHelper.dbHelper.getUserData(email).email == email {
                print("already in DBHelper")
            return false
            
            } else {
                DBHelper.dbHelper.createUser(name, email, mobile, password)
                print("Saved to DBHelper")
                return true
        }
    }
    
}


