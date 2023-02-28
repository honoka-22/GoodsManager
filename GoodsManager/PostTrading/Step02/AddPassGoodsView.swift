//
//  AddPassGoodsView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/19.
//

import SwiftUI

struct AddPassGoodsView: View {
    @ObservedObject var viewModel = AddPassGoodsViewModel()
    @State var message = ""
    @State var step = 0
    @Binding var passItems: [PassItem]
    @Binding var isShow: Bool
    
    
    var body: some View {
        VStack(spacing: 0) {
            Text(message)
                .font(.footnote)
                .foregroundColor(.red)
                .padding(.top)
            
            if step == 0 {
                AddPassGoods1(viewModel: viewModel)
            } else {
                AddPassGoods2(viewModel: viewModel)
            }
            
            
            Divider()
            HStackButton(
                colors: AppColors(),
                rightText: step == 0 ? "キャンセル" : "戻る",
                rightAction: {
                    if step == 0 {
                        isShow.toggle()
                    } else {
                        step = 0
                    }
                }, leftText: step == 0 ? "次へ" : "登録") {
                    if step == 0 {
                        if !viewModel.nextStep() {
                            message = "未選択の項目があります"
                            return
                        }
                        message = ""
                        viewModel.makeCharacterList()
                        step = 1
                    } else {
                        passItems.append(viewModel.checkCharacterList())
                        isShow.toggle()
                    }
                }
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .padding()
    }
}

struct AddPassGoods1: View {
    @ObservedObject var viewModel: AddPassGoodsViewModel
    
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
                MenuLabel(label: $viewModel.title)
                    .padding(.bottom)
                
            }
            
            if 0 < viewModel.products.count {
                Text("商品名").font(.footnote)
                Menu {
                    ForEach(viewModel.products) { product in
                        Button {
                            viewModel.setProduct(product: product)
                        } label: {
                            Text(product.name)
                        }
                    }
                } label: {
                    MenuLabel(label: $viewModel.product)
                        .padding(.bottom)
                }
                
            }
            
            if 0 < viewModel.firstCategorys.count {
                Text("カテゴリー１").font(.footnote)
                Menu {
                    ForEach(viewModel.firstCategorys) { category in
                        Button {
                            viewModel.setCategory1(category: category)
                        } label: {
                            Text(category.name)
                        }
                    }

                } label: {
                    MenuLabel(label: $viewModel.category1)
                        .padding(.bottom)
                }
            }
            
            if 0 < viewModel.secondCategorys.count {
                Text("カテゴリー2").font(.footnote)
                Menu {
                    ForEach(viewModel.secondCategorys) { category in
                        Button {
                            viewModel.setCategory2(category: category)
                        } label: {
                            Text(category.name)
                        }
                    }
                } label: {
                    MenuLabel(label: $viewModel.category2)
                        .padding(.bottom)
                }
            }
            
        }.padding()
    }
}

struct AddPassGoods2: View {
    @ObservedObject var viewModel: AddPassGoodsViewModel
    
    var body: some View {
        VStack {
            if 0 < viewModel.passCharacters.count {
                ScrollView(showsIndicators: false) {
                    
                    ForEach($viewModel.passCharacters) { character in
                        PassCharacterCell(character: character)
                    }
                    
                }
                
            } else {
                Text("所持しているグッズがありません")
            }
            
        }
        .padding()
        .frame(height: SCREEN_WIDTH / 3 * 2)
    }
}

struct PassCharacterCell: View {
    @Binding var character: PassCharacter
    var body: some View {
        HStack {
            Text(character.name)
            
            Spacer()
            
            Button {
                if 0 < character.countNum {
                    character.countNum -= 1
                }
            } label: {
                Image(systemName: "minus.circle")
                    .font(.subheadline)
            }
            
            TextField("", value: $character.countNum, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.subheadline)
                .frame(width: 80)
            
            Button {
                character.countNum += 1
            } label: {
                Image(systemName: "plus.circle")
                    .font(.none)
            }
        }.padding(.horizontal)
    }
}
