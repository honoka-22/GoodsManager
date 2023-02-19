//
//  PTStep02.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import SwiftUI

struct PTStep02: View {
    @ObservedObject var viewModel: PostTradingViewModel
    @Binding var isShowWindow: Bool
    
    var body: some View {
        VStack {
            if viewModel.selectType.contains("買取") {
                HStack {
                    CountField(label: "お渡しする金額", count: $viewModel.purchasePrice)
                    Text("円")
                }
            }
            
            if viewModel.selectType != "買取" {
                Text("お譲りするグッズ")
                
                ScrollView(showsIndicators: false) {
                    
                }
                
                PlusButton() {
                    isShowWindow.toggle()
                }
            }
             
        }.padding()
    }
}

//struct PTStep02_Previews: PreviewProvider {
//    static var previews: some View {
//        PTStep02()
//    }
//}
