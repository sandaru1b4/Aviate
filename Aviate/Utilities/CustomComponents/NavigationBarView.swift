//
//  NavigationBarView.swift
//  Aviate
//
//  Created by Admin on 2025-05-28.
//

import SwiftUI

struct NavigationBarView: View {
    
    @EnvironmentObject var appManager: AppManager

    var isShowBackButton: Bool? = true
    var title: String
    var action: (() -> Void)?

    var body: some View {
        ZStack {
            Text(title)
                .font(.system(size: 25, weight: .bold))
                .foregroundStyle(Color.black)
                .lineLimit(2)

            HStack {
                if isShowBackButton == true {
                    Button(action: { appManager.navigateBack() }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(Color.black)
                            .font(.system(size: 23, weight: .bold))
                    })
                }

                Spacer()

            }
        }
        .frame(height: 44)
    }
}

#Preview {
    NavigationBarView(title: "Flight")
}
