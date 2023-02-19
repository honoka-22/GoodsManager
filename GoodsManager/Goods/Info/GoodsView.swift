//
//  GoodsView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import SwiftUI

struct GoodsView: View {
    @ObservedObject var viewModel: GoodsViewModel
    @Binding var isShow: Bool
    
    init(goods: MyGoods, isShow: Binding<Bool>) {
        viewModel = GoodsViewModel(goods: goods)
        self._isShow = isShow
        viewModel.getInfo()
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ToolBar(colors: AppColors(), isShowBackButton: true, title: "グッズ") {
                isShow.toggle()
            }
            
            ScrollView {
                if 0 < viewModel.images.count {
                    GoodsImages(images: $viewModel.images)
                } else {
                    Spacer().frame(height: 10)
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(viewModel.title).font(.title3)
                        if viewModel.product != "" {
                            Text(viewModel.product + " " + viewModel.category1 + " " + viewModel.category2).font(.title3)
                        }
                        
                        
                    }
                    
                    Spacer()
                }.padding(.horizontal)
                
                
                if !viewModel.isProgress {
                    VStack {
                        Divider()
                        ForEach($viewModel.counts) { counts in
                            ItemCountCell(counts: counts)
                            Divider()
                        }
                    }.padding(.horizontal)
                    
                }
                
            }

            
            
            
            
            

            
            Spacer()
        }
    }
}

//struct GoodsView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoodsView()
//    }
//}
