//
//  NewGoodsStep01.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import SwiftUI

struct NewGoodsStep01: View {
    @ObservedObject var viewModel: NewGoodsPostViewModel
    @Binding var isShowWindow: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("作品名")
            Menu {
                ForEach(viewModel.titles) { title in
                    Button {
                        if viewModel.titleLabel != title.name {
                            viewModel.selectTitle = title
                            viewModel.getProducts()
                            viewModel.resetProduct()
                            viewModel.titleLabel = title.name
                        }
                        
                    } label: {
                        Text(title.name)
                    }
                }
            } label: {
                MenuLabel(label: $viewModel.titleLabel)
                    .padding(.bottom)
            }
            
            if viewModel.titleLabel != "未選択" {
                Text("商品名")
                Menu {
                    ForEach(viewModel.products) { product in
                        Button {
                            if viewModel.productLabel != product.name {
                                viewModel.selectProduct = product
                                viewModel.get1stCategorys()
                                viewModel.resetCategory1()
                                viewModel.productLabel = product.name
                            }
                        } label: {
                            Text(product.name)
                        }
                    }
                } label: {
                    MenuLabel(label: $viewModel.productLabel)
                }
                
                button
            }
            
            if viewModel.firstCategorys.count != 0 {
                Text("カテゴリー１")
                Menu {
                    ForEach(viewModel.firstCategorys) { category in
                        Button {
                            if viewModel.Category1Lagel != category.name {
                                viewModel.selectCategory1 = category
                                viewModel.get2ndCategorys()
                                viewModel.resetCategory2()
                                viewModel.Category1Lagel = category.name
                            }
                        } label: {
                            Text(category.name)
                        }
                    }
                } label: {
                    MenuLabel(label: $viewModel.Category1Lagel)
                }
                button
            }
            
            if viewModel.secondCategorys.count != 0 {
                Text("カテゴリー2")
                Menu {
                    ForEach(viewModel.secondCategorys) { category in
                        Button {
                            if viewModel.Category2Lagel != category.name {
                                viewModel.selectCategory2 = category
                                viewModel.Category2Lagel = category.name
                            }
                        } label: {
                            Text(category.name)
                        }
                    }
                } label: {
                    MenuLabel(label: $viewModel.Category2Lagel)
                }
                button
            }
            
            if viewModel.productLabel != viewModel.defaultLabel &&
                viewModel.firstCategorys.count == 0 ||
                viewModel.Category1Lagel != viewModel.defaultLabel &&
                viewModel.secondCategorys.count == 0 {
                HStack {
                    Spacer()
                    Button {
                        isShowWindow.toggle()
                    } label: {
                        Text("カテゴリーを追加")
                            .foregroundColor(.blue)
                    }
                    Spacer()
                }
            }
            
            Spacer()
            
        }.padding()
    }
    
    var button: some View {
        HStack {
            Spacer()
            Button {
                isShowWindow.toggle()
            } label: {
                Text("新規登録")
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
        }
    }
}

//struct NewGoodsStep01_Previews: PreviewProvider {
//    static var previews: some View {
//        NewGoodsStep01()
//    }
//}
