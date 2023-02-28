//
//  MenuLabel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

struct MenuLabel: View {
    @State private var rectangleHeight: CGFloat = .zero
    @Binding var label: String
    
    var body: some View {
        HStack {
            Text(label == "" ? "未選択" : label)
            Spacer()
            Text("▼")
                .font(.footnote)
        }
        .padding(5)
        
        .frame(maxWidth: .infinity)
        .foregroundColor(Color("fontColor"))
        .background(.white)
        .overlay(RoundedRectangle(cornerRadius: 5)
            .stroke(Color(UIColor.secondaryLabel), lineWidth: 0.3))
        

    }
}

struct TextMenu: View {
    let items: [String]
    @Binding var selectItem: String
    
    var body: some View {
        Menu {
            ForEach(items, id: \.self) { item in
                Button {
                    selectItem = item
                } label: {
                    Text(item)
                }
            }
        } label: {
            MenuLabel(label: $selectItem)
        }
    }
}
