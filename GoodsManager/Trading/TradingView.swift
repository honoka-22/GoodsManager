//
//  TradingView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/31.
//

import SwiftUI

struct TradingView: View {
    @Binding var isShow: Bool
    var body: some View {
        VStack {
            ToolBar(colors: AppColors(),isShowBackButton: true, title: "取引") {
                isShow.toggle()
            }
            
            Spacer()
        }
    }
}
