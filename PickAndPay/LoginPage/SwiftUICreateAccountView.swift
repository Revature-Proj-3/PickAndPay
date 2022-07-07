//
//  SwiftUICreateAccountView.swift
//  PickAndPay
//
//  Created by Zachary Saffron on 6/29/22.
//

import SwiftUI

struct SwiftUICreateAccountView: View {
    @State var name = ""
    @State var email = ""
    @State var mobile = ""
    @State var password = ""
    var body: some View {
        VStack(spacing: 50) {
            Text("Pick and Pay").font(.system(size: 32, weight: .semibold))
            Spacer()
            VStack(spacing: 30) {
                Text("Create Account").font(.system(size: 32, weight: .medium)).frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
            
            HStack {
                Image(systemName: "person").foregroundColor(.black)
                TextField("Name", text: $name)
            }
                .padding(.all, 10)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(4)
                .border(Color.black, width: 1)
                .cornerRadius(2)
                .padding(.horizontal, 20)
                
            HStack {
                Image(systemName: "envelope").foregroundColor(.black)
                TextField("Email", text: $email)
            }
                .padding(.all, 10)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(4)
                .border(Color.black, width: 1)
                .cornerRadius(2)
                .padding(.horizontal, 20)
                
                HStack {
                    Image(systemName: "phone").foregroundColor(.black)
                    TextField("Mobile number", text: $mobile)
                }
                    .padding(.all, 10)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(4)
                    .border(Color.black, width: 1)
                    .cornerRadius(2)
                    .padding(.horizontal, 20)
            
            HStack {
                Image(systemName: "lock").foregroundColor(.black)
                SecureField("Password", text: $password)
            }
                .padding(.all, 10)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(4)
                .border(Color.black, width: 1)
                .cornerRadius(2)
                .padding(.horizontal, 20)
                
            HStack {
                Image(systemName: "lock.shield").foregroundColor(.black)
                SecureField("Re-enter password", text: $password)
            }
                .padding(.all, 10)
                .background(Color.gray.opacity(0.3))
                .cornerRadius(4)
                .border(Color.black, width: 1)
                .cornerRadius(2)
                .padding(.horizontal, 20)
            
            Button(action: {}) {
                Text("Create your Pick and Pay account")
                    .foregroundColor(.black)
                    .font(.system(size: 18, weight: .medium))
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color.yellow.opacity(0.5))
                .cornerRadius(4)
                .border(Color.black, width: 1)
                .cornerRadius(2)
                .padding(.horizontal, 20)
            
                HStack {
                    Text("Already have an account?")
                    .foregroundColor(.black.opacity(0.5))
                    .frame(maxWidth: 200, alignment: .center)
                        .padding(.horizontal, 10)
            
            Button(action: {}) {
                Text("Sign in")
                    .foregroundColor(.blue)
                    .font(.system(size: 18, weight: .medium))
            }.frame(maxWidth: 60, alignment: .leading)
        }
                
            }.frame(width: 375, height: 550).border(.gray.opacity(0.5))
            Spacer()
            Spacer()
        }
    }
}

struct SwiftUICreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUICreateAccountView()
            .accessibilityIdentifier("CreateAccount")
    }
}
