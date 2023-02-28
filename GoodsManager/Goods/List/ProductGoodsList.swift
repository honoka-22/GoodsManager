//
//  ProductGoodsList.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/18.
//

import SwiftUI

struct ProductGoodsList: View {
    @ObservedObject var viewModel: GoodsListViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            SortMenu(ascending: {
                viewModel.goodsList.sort{ $0.name < $1.name }
            }) {
                viewModel.goodsList.sort{ $0.name > $1.name }
            }
            
            List {
                ForEach(viewModel.goodsList) { goods in
                    NormalListCell(text: goods.name)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            viewModel.selectGoods = goods.goods
                            viewModel.isShowInfo.toggle()
                        }
                }
            }
        }
        
    }
}
