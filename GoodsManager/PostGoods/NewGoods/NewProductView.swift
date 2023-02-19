//
//  NewProductView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import SwiftUI

struct NewProductView: View {
    @ObservedObject var viewModel: NewGoodsPostViewModel
    @State var newItem = ""
    @Binding var isShow: Bool
    var body: some View {
        ZStack {
            Color.gray.opacity(0.5).ignoresSafeArea(.all)
            VStack(alignment: .leading, spacing: 0) {
                Group {
                    Text("作品名").padding(.top)
                    Text(viewModel.selectTitle!.name)
                    
                    if let product = viewModel.selectProduct {
                        Text("商品名").padding(.top)
                        Text(product.name)
                    }
                    
                    if let category1 = viewModel.selectCategory1 {
                        Text("カテゴリー1").padding(.top)
                        Text(category1.name)
                    }
                    
                    TextField("", text: $newItem)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.vertical)
                    
                    
                }.padding(.horizontal)
                
                Divider()
                HStackButton(
                    colors: AppColors(),
                    rightText: "キャンセル",
                    rightAction: {
                        isShow.toggle()
                    }, leftText: "登録") {
                        isShow.toggle()
                    }
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .cornerRadius(10)
            .padding()
        }
    }
}

//struct NewProductView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewProductView()
//    }
//}
