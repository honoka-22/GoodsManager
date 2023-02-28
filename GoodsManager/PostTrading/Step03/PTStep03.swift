//
//  PTStep03.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import SwiftUI

struct PTStep03: View {
    @ObservedObject var viewModel: PostTradingViewModel
    @Binding var isShowWindow: Bool
    
    var body: some View {
        VStack {
            if viewModel.selectType.contains("譲渡") {
                HStack {
                    CountField(label: "受け取る金額", count: $viewModel.salesPrice)
                    Text("円")
                }
            }
            
            if viewModel.selectType != "譲渡" {
                Text("受け取るグッズ")
                
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.giveItems) { item in
                        GiveListCell(item: item)
                        Divider()
                    }
                }
                
                PlusButton() {
                    isShowWindow.toggle()
                }
            }
        }.padding()
    }
}

struct GiveListCell: View {
    let item: GiveItem
    var title = ""
    var label = ""
    init(item: GiveItem) {
        if let title = item.goodsData.title {
            self.title = title.name
        }
        if let product = item.goodsData.product {
            self.label = product.name
        }
        if let category = item.goodsData.category1 {
            self.label += (" " + category.name)
            
            if let category2 = item.goodsData.category2 {
                self.label += (" " + category2.name)
            }
        }
        self.item = item
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.subheadline)
            Text(label).font(.subheadline)
                .padding(.bottom, 3)
            
            ForEach(item.characters) { character in
                HStack {
                    Text(character.name)
                    Spacer()
                    Text("\(character.countNum)")
                    
                }
            }
        }.padding(.horizontal)
    }
}

