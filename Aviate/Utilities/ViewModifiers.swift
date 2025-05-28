//
//  ViewModifiers.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import SwiftUI

struct CustomTFStyle: ViewModifier {
    
    var textName: String
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(Color.black)
            .font(.system(size: 14, weight: .regular, design: .default))
            .padding(.horizontal, 10)
            .frame(height:44)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .background(
                
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(textName != "" ? Color.custom(.primaryAppColor) : Color.gray.opacity(0.5),
                                lineWidth: 1)
                }
            
            )
    }
}


extension View {
    func customTFStyle(with text: String) -> some View {
        self.modifier(CustomTFStyle(textName: text))
    }
}
