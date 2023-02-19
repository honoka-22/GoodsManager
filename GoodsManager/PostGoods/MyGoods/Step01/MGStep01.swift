//
//  MyGoodsStep01.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import SwiftUI

struct MGStep01: View {
    @ObservedObject var viewModel: MGStep01ViewModel
    @Binding var isShowWindow: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("作品名").font(.footnote)
            Menu {
                ForEach(viewModel.titles) { title in
                    Button {
                        viewModel.setTitle(title: title)
                        
                    } label: {
                        Text(title.name)
                    }
                    
                }
            } label: {
                MenuLabel(label: $viewModel.titleLabel)
                    .padding(.bottom)
            }
            
            if viewModel.titleLabel != viewModel.defaultLabel {
                Text("商品名").font(.footnote)
                Menu {
                    ForEach(viewModel.products) { product in
                        Button {
                            viewModel.setProduct(product: product)
                        } label: {
                            Text(product.name)
                        }
                    }
                    Button {
                        viewModel.newDataType = .product
                        isShowWindow.toggle()
                    } label: {
                        Text("新規登録")
                    }
                } label: {
                    MenuLabel(label: $viewModel.productLabel)
                        .padding(.bottom)
                }
                
            }
            
            if viewModel.firstCategorys.count != 0 {
                Text("カテゴリー１").font(.footnote)
                Menu {
                    ForEach(viewModel.firstCategorys) { category in
                        Button {
                            viewModel.setCategory1(category: category)
                        } label: {
                            Text(category.name)
                        }
                    }
                    Button {
                        viewModel.newDataType = .category1
                        isShowWindow.toggle()
                    } label: {
                        Text("新規登録")
                    }

                } label: {
                    MenuLabel(label: $viewModel.Category1Lagel)
                        .padding(.bottom)
                }
            }
            
            if viewModel.secondCategorys.count != 0 {
                Text("カテゴリー2").font(.footnote)
                Menu {
                    ForEach(viewModel.secondCategorys) { category in
                        Button {
                            viewModel.setCategory2(category: category)
                        } label: {
                            Text(category.name)
                        }
                    }
                    Button {
                        viewModel.newDataType = .category2
                        isShowWindow.toggle()
                    } label: {
                        Text("新規登録")
                    }
                } label: {
                    MenuLabel(label: $viewModel.Category2Lagel)
                        .padding(.bottom)
                }
            }
            
            if viewModel.productLabel != viewModel.defaultLabel &&
                viewModel.firstCategorys.count == 0 ||
                viewModel.Category1Lagel != viewModel.defaultLabel &&
                viewModel.secondCategorys.count == 0 {
                HStack {
                    Spacer()
                    Button {
                        if viewModel.firstCategorys.count == 0 {
                            viewModel.newDataType = .category1
                        } else {
                            viewModel.newDataType = .category2
                        }
                        isShowWindow.toggle()
                    } label: {
                        Text("カテゴリーを追加")
                            .foregroundColor(.blue)
                            .padding()
                    }
                    Spacer()
                }
            }
            
            Spacer()
            
        }.padding()    
    }
}

//struct MyGoodsStep01_Previews: PreviewProvider {
//    static var previews: some View {
//        MyGoodsStep01()
//    }
//}
