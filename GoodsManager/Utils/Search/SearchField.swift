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
                }
            }
        }
        .frame(height: 30)
        .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1))
        
    }
}

struct SearchField_Previews: PreviewProvider {
    static var previews: some View {
        SearchField()
    }
}
