//
//  SearchField.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

/// 検索フィールド
struct SearchField: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("キーワード",text: $searchText)
            
            if !searchText.isEmpty {
                Button {
                    searchText.removeAll()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }.padding(.horizontal)
            }
        }
        
        .frame(height: 30)
        .background(.white)
        .cornerRadius(5)
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color(UIColor.secondaryLabel), lineWidth: 0.3))
        
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField()
    }
}
