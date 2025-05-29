//
//  CommonButtonView.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import SwiftUI

struct CommonButtonView: View {
    let title: String
    var fillColor: Color = Color.custom(.primaryAppColor)
    var strokeColor: Color = Color.custom(.primaryAppColor)
    var borderWidth:CGFloat?
    var buttonWidth:CGFloat = 219
    let action: ()->()

    var body: some View {
        VStack {
            Button(action: {
                action()
            }, label: {
                Text(title)
                    .font(.system(size: 17, weight: .semibold))
                    .padding(.top, 13)
                    .padding(.bottom, 11)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: buttonWidth, maxHeight: 48)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .fill(fillColor)
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(strokeColor, lineWidth: borderWidth ?? 0.5)
                        }
                    )
            })
        } //: VStack
    }
}

#Preview {
    CommonButtonView(title: "Button", action: {})
}
