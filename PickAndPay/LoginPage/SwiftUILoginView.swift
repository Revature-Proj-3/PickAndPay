//
//  SwiftUILoginView.swift
//  PickAndPay
//
//  Created by Zachary Saffron on 6/29/22.
//

import SwiftUI

struct SwiftUILoginView: View {
    @State var emailOrMobile = ""
    @State var password = ""
    var body: some View {
        ZStack {
            Color(UIColor(named: "Background")!).ignoresSafeArea()
        VStack(spacing: 50) {
            Text("Pick and Pay").font(.system(size: 32, weight: .semibold))
            Spacer()
            VStack(spacing: 30) {
                Text("Login").font(.system(size: 32, weight: .medium)).frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
            
            HStack {
                Image(systemName: "envelope").foregroundColor(.black)
                TextField("Email or mobile phone number", text: $emailOrMobile)
            }
                .padding(.all, 10)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(4)
                .border(Color.black, width: 1)
                .cornerRadius(2)
                .padding(.horizontal, 20)
            
            HStack {
                Image(systemName: "lock").foregroundColor(.black)
                SecureField("Password", text: $password)
            }
                .padding(.all, 10)
                .background(Color.gray.opacity(0.5))
                .cornerRadius(4)
                .border(Color.black, width: 1)
                .cornerRadius(2)
                .padding(.horizontal, 20)
            
            Button(action: {}) {
                Text("Login")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .medium))
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color(UIColor(named: "FilledButton")!))
                .cornerRadius(4)
                .border(Color.black, width: 1)
                .cornerRadius(2)
                .padding(.horizontal, 20)
            }.frame(width: 375, height: 410).border(.gray.opacity(0.5))
                .background(Color.white)
            Spacer()
            Spacer()
            }
        }
    }
}

struct SwiftUILoginView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUILoginView()
            
    }
}
