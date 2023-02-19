//
//  NewBaseDataWindow.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/15.
//

import SwiftUI



struct NewBaseDataWindow: View {
    @ObservedObject var viewModel: MGStep01ViewModel
    @State var newItem = ""
    @Binding var isShow: Bool
    @State var message = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Group {
                HStack {
                    Spacer()
                    Text(message)
                        .font(.footnote)
                        .foregroundColor(.red)
                    Spacer()
                }
                
                
                Text("作品名").font(.footnote).padding(.top)
                Text(viewModel.baseData.title!.name)
                
                Text("商品名").font(.footnote).padding(.top)
                if viewModel.newDataType != .product {
                    Text(viewModel.baseData.product!.name)
                    
                    Text("カテゴリー1").font(.footnote).padding(.top)
                    if viewModel.newDataType != .category1 {
                        Text(viewModel.baseData.category1!.name)
                        Text("カテゴリー2").font(.footnote).padding(.top)
                    }
                }
                
                TextField("", text: $newItem)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding(.bottom)
                
            }.padding(.horizontal)
            
            Divider()
            HStackButton(
                colors: AppColors(),
                rightText: "キャンセル",
                rightAction: {
                    isShow.toggle()
                }, leftText: "登録") {
                    if newItem == "" {
                        message = "値が入力されていません"
                        return
                    }
                    viewModel.addData(name: newItem)
                    isShow.toggle()
                }
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .padding()
    }
}

//struct NewBaseDataWindow_Previews: PreviewProvider {
//    static var previews: some View {
//        NewBaseDataWindow()
//    }
//}
