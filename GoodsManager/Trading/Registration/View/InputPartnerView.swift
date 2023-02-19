//
//  InputPartnerView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import SwiftUI

/// 取引相手入力
struct InputPartnerView: View {
    @ObservedObject var viewModel: TradingRegistrationViewModel
    // TODO: firebaseから取ってくる
    let tradingServices = ["Twitter", "メルカリ", "その他"]
    @State var selectItem = "未選択"
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("お名前: ")
            TextField("", text: $viewModel.name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
            
            HStack {
                Text("連絡ツール: ")
                TextMenu(items: tradingServices, selectItem: $selectItem)
            }.padding(.vertical)
            
            HStack {
                
            }
            
            Text("アカウント名: ")
            TextField("", text: $viewModel.account)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
        }.padding()
    }
}

//struct InputPartnerView_Previews: PreviewProvider {
//    static var previews: some View {
//        InputPartnerView()
//    }
//}
