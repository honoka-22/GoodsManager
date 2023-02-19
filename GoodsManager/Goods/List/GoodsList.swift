//
//  GoodsList.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/18.
//

import SwiftUI

enum MyList {
    case title
    case product
    case category
}

struct GoodsList: View {
    @ObservedObject var viewModel = GoodsListViewModel()
    
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            
            VStack {
                
                if viewModel.myList == .title {
                    
                    ToolBar(colors: AppColors(), title: "Myグッズ一覧")
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(viewModel.titleMyGoods) { title in
                            TitleGoodsList(title: title, viewModel: viewModel)
                        }
                    }
                    
                   
                } else if viewModel.myList == .product {
                    
                    if let product = viewModel.selectProduct {
                        ToolBar(colors: AppColors(),isShowBackButton: true, title: product.name) {
                            viewModel.selectProduct = nil
                            viewModel.myList = .title
                        }
                        ProductGoodsList(product: product)
                    }
                    
                }
                else if viewModel.myList == .category {
                    ToolBar(colors: AppColors(),isShowBackButton: true, title: "Myグッズ一覧") {
                        
                        viewModel.myList = .product
                    }
                    
                }
                
                Spacer()
                
            }
            
        }
        .fullScreenCover(isPresented: $viewModel.isShowInfo) {
            if let goods = viewModel.selectGoods {
                GoodsView(goods: goods, isShow: $viewModel.isShowInfo)
            }
        }

    }
}

struct GoodsList_Previews: PreviewProvider {
    static var previews: some View {
        GoodsList()
    }
}
