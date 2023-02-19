//
//  GoodsList.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import SwiftUI

struct TitleGoodsList: View {

    let title: TitleMyGoods
    @ObservedObject var viewModel: GoodsListViewModel
    
    @State var isShowList = false
    
//    @Binding var selectProduct: ProductMyGoods?
//    @Binding var myList: MyList
//    @State var selectGoods: MyGoods?

    var body: some View {
        VStack(spacing: 0) {
            ListTitle(title: title.title.name, isShowList: $isShowList)

            if isShowList {
                ForEach(title.products) { product in
                    Divider()
                    NormalListCell(text: product.name)
                        .onTapGesture {
                            if product.goods.count == 1 {
                                viewModel.selectGoods = product.goods[0]
                                viewModel.isShowInfo.toggle()
                                
                            } else {
                                viewModel.selectProduct = product
                                viewModel.myList = .product
                            }
                        }
                }.background(.white)
            }
                
        }
        .cornerRadius(10.0)
        .padding(.horizontal)
    }
}
