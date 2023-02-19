//
//  CustomPicker.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/31.
//

import SwiftUI

struct CustomPicker: View {
    let width = (SCREEN_WIDTH - 30) / 2
    let height = (SCREEN_WIDTH - 20) / 10
    let items: [String]
    @Binding var selectItem: Int
    
    var body: some View {
        
        VStack {
            
            Menu {
                ForEach(items, id: \.self) { item in
                    Button {
                        selectItem = items.firstIndex(of: item) ?? 0
                    } label: {
                        Text(item)
                    }
                }
            } label: {
                HStack {
                    Text(items[selectItem])
                        .padding(.leading)
                    Spacer()
                    Text("▼")
                        .padding(.trailing)
                }
                .frame(width: width, height: height)
                .foregroundColor(.black)
                .background(.white)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.brown, lineWidth: 1))
            }
        }
    }
}

struct CustomPicker_Previews: PreviewProvider {
    @State static var selectItemSample = 1
    static var previews: some View {
        CustomPicker(items: ["hoge", "fuga", "piyo"],
                     selectItem: $selectItemSample)
    }
}
