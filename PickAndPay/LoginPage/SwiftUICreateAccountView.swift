//
//  SwiftUICreateAccountView.swift
//  PickAndPay
//
//  Created by Zachary Saffron on 6/29/22.
//

import SwiftUI

struct SwiftUICreateAccountView: View {

    @StateObject private var viewModel = UserValidation()
    
    var body: some View {
        ZStack {
            Color(UIColor(named: "Background")!).ignoresSafeArea()
        VStack(spacing: 50) {
            Text("Pick and Pay").font(.system(size: 32, weight: .semibold))
            VStack(spacing: 30) {
                Text("Create Account").font(.system(size: 32, weight: .medium)).frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 20)
            
            VStack {
                EntryField(sfSymbolName: "person", placeholder: "Name", prompt: viewModel.namePrompt, field: $viewModel.name)
                EntryField(sfSymbolName: "envelope", placeholder: "Email", prompt: viewModel.emailPrompt, field: $viewModel.email)
                EntryField(sfSymbolName: "phone", placeholder: "Mobile Number", prompt: viewModel.mobilePrompt, field: $viewModel.mobile)
                EntryField(sfSymbolName: "lock", placeholder: "Password", prompt: viewModel.passwordPrompt, field: $viewModel.password, isSecure: true)
                EntryField(sfSymbolName: "lock.shield", placeholder: "Re-Enter Password", prompt: viewModel.confirmPasswordPrompt, field: $viewModel.reEnterPassword, isSecure: true)
            }

            
                Button(action: {viewModel.signUp()}) {
                Text("Create your Pick and Pay account!")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .medium))
            }.frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(Color(UIColor(named: "FilledButton")!))
                .cornerRadius(4)
                .border(Color.black, width: 1)
                .cornerRadius(2)
                .padding(.horizontal, 20)
                .opacity(viewModel.canSubmit ? 1 : 0.6)
                .disabled(!viewModel.canSubmit)
            }.frame(width: 375, height: 550).border(.gray.opacity(0.5))
                .background(Color.white)
            Spacer()
            Spacer()
            }
        }
    }
    
    
    
}

struct SwiftUICreateAccountView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUICreateAccountView()
            
    }
}


