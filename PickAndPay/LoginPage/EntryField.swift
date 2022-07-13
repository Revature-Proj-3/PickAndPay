//
//  EntryField.swift
//  PickAndPay
//
//  Created by admin on 7/13/22.
//

import SwiftUI

struct EntryField: View {
    var sfSymbolName: String
    var placeholder: String
    var prompt: String
    @Binding var field: String
    var isSecure = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: sfSymbolName).foregroundColor(.black)
                if isSecure {
                     SecureField(placeholder, text: $field)
                 } else {
                     TextField(placeholder, text: $field)
                 }
            }.padding(.all, 10)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(4)
            .border(Color.black, width: 1)
            .cornerRadius(2)
            .padding(.horizontal, 20)
            Text(prompt)
                .padding(.horizontal, 20)
                .foregroundColor(.red)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
        }
    }
}

struct EntryField_Previews: PreviewProvider {
    static var previews: some View {
        EntryField(sfSymbolName: "envelope", placeholder: "Email", prompt: "Enter a valid email address", field: .constant(""))
    }
}
