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
    @State var sortItem = "昇順"
    
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            
            VStack {
       
                if viewModel.myList == .title {
                    
                    ToolBar(colors: AppColors(), title: "Myグッズ一覧")
                    
                    SortMenu(ascending: {
                        viewModel.titleMyGoods.sort{ $0.title.name < $1.title.name }
                    }) {
                        viewModel.titleMyGoods.sort{$0.title.name > $1.title.name}
                    }
                    
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
                        
                        ProductGoodsList(viewModel: viewModel)
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

struct SortMenu: View {
    @State var sortItem = "昇順"
    /// 昇順
    let ascending: () -> ()
    /// 降順
    let descending: () -> ()
    
    var body: some View {
        HStack {
            Spacer()
            
            Menu {
                Button("昇順") {
                    sortItem = "昇順"
                    ascending()
                }
                Button("降順") {
                    sortItem = "降順"
                    descending()
                }
            } label: {
                MenuLabel(label: $sortItem)
            }.frame(width: UIScreen.main.bounds.width / 4)
            
            
        }.padding(.horizontal)
    }
}


struct GoodsList_Previews: PreviewProvider {
    static var previews: some View {
        GoodsList()
    }
}
