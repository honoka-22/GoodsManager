//
//  PTStep03.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import SwiftUI

struct PTStep03: View {
    @ObservedObject var viewModel: PostTradingViewModel
    @Binding var isShowWindow: Bool
    
    var body: some View {
        VStack {
            if viewModel.selectType.contains("譲渡") {
                HStack {
                    CountField(label: "受け取る金額", count: $viewModel.purchasePrice)
                    Text("円")
                }
            }
            
            if viewModel.selectType == "買取" {
                Text("受け取るグッズ")
                
                ScrollView(showsIndicators: false) {
                    
                }
                
                PlusButton() {
                    isShowWindow.toggle()
                }
            }
            Spacer()
        }.padding()
    }
}

//struct PTStep03_Previews: PreviewProvider {
//    static var previews: some View {
//        PTStep03()
//    }
//}
