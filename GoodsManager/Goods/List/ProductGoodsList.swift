//
//  ProductGoodsList.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/18.
//

import SwiftUI

struct ProductGoodsList: View {
    @State var isShowInfo = false
    
    let product: ProductMyGoods
    @State var selectGoods: MyGoods?
    
    var body: some View {
        VStack {
            ForEach(product.goods) { goods in
                Divider()
                NormalListCell(text: goods.category1 + " " + goods.category2)
                    .onTapGesture {
                        selectGoods = goods
                        isShowInfo.toggle()
                        
                    }
            }
            

        }
        
        .background(.white)
        .cornerRadius(10.0)
        .padding(.horizontal)
        .fullScreenCover(isPresented: $isShowInfo) {
            if let goods = selectGoods {
                GoodsView(goods: goods, isShow: $isShowInfo)
            }
        }
    }
}

//struct ProductGoodsList_Previews: PreviewProvider {
//    static var previews: some View {
//        ProductGoodsList()
//    }
//}
