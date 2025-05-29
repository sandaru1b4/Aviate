//
//  SearchBarView.swift
//  Aviate
//
//  Created by Admin on 2025-05-29.
//

import SwiftUI
//
struct SearchBarView: View {
    
    //MARK: - PROPERTIES
    @Binding var searchText:String
    
    //MARK: - BODY
    var body: some View {
        HStack {
            TextField("", text: $searchText)
                .placeholder(when: searchText.isEmpty) {
                    Text("Search").foregroundStyle(Color.gray.opacity(0.5))
                }
                .foregroundStyle(Color.black)
                .autocapitalization(.none)
                .disableAutocorrection(true)
                .font(.system(size: 16))
                .padding(.horizontal, 10)
            
            Image(.icSearch)
                .resizable()
                .frame(width: 20, height: 20)
                .aspectRatio(contentMode: .fill)
                .foregroundStyle(Color.gray.opacity(0.5))
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gray.opacity(0.2))
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.custom(.primaryAppColor).opacity(0.2), lineWidth: 1)
            }
        )
    }
}


//MARK: - PREVIEW
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
    }
}

#Preview {
    SearchBarView(searchText: .constant(""))
}
