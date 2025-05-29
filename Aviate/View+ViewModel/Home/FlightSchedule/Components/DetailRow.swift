//
//  DetailRow.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import SwiftUI

struct DetailRow: View {
    let icon: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(width: 20)
            Text(text)
            Spacer()
        }
    }
}

//#Preview {
//    DetailRow(icon: <#String#>, text: <#String#>)
//}
