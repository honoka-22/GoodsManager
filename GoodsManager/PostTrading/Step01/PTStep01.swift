//
//  PTStep01.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import SwiftUI

struct PTStep01: View {
    @ObservedObject var viewModel: PostTradingViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("お名前").font(.footnote)
                Text("必須").font(.footnote).foregroundColor(.red)
                
            }
            
            TextField("", text: $viewModel.name)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom)
            
            RequiredMenu(label: "連絡ツール",
                         items: viewModel.tradingServices,
                         selectItem: $viewModel.selectService)
            
            Text("アカウント名").font(.footnote)
            TextField("", text: $viewModel.account)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom)
            
            RequiredMenu(label: "取引タイプ",
                         items: viewModel.tradingTypes,
                         selectItem: $viewModel.selectType)
            
            RequiredMenu(label: "取引方法",
                         items: viewModel.tradingMethods,
                         selectItem: $viewModel.selectMethod)
            
            Spacer()
        }.padding()
    }
}

struct RequiredMenu: View {
    let label: String
    let items: [String]
    @Binding var selectItem: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text(label).font(.footnote)
                Text("必須").font(.footnote).foregroundColor(.red)
            }
            TextMenu(items: items,
                     selectItem: $selectItem)
            .padding(.bottom)
        }
        
    }
    
}


//struct PTStep01_Previews: PreviewProvider {
//    static var previews: some View {
//        PTStep01()
//    }
//}
