//
//  TradingRegistrationView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import SwiftUI

/// 取引登録画面
struct TradingRegistrationView: View {
    @Binding var isShow: Bool
    @ObservedObject var colors = AppColors()
    @ObservedObject var viewModel = TradingRegistrationViewModel()
    @State var selected = 1
    let step = ["お相手様の情報", "基本情報", "詳細入力", "内容確認"]
    @State var name = ""
    @State var account = ""
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            VStack(spacing: 0) {
                ToolBar(colors: AppColors(),
                        title: "取引登録")
                
                StepView(stepCount: step.count,
                         selectStep: $selected)
                .padding()
                
                Text(step[selected - 1])

                    
                }
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
                HStackButton(
                    colors: colors,
                    rightText: "キャンセル",
                    rightAction: {
                        // FIXME: アラートを出す
                        isShow.toggle()
                    },
                    leftText: selected < step.count ? "次へ" : "登録"){
                        self.selected = selected < step.count ? selected + 1 : 1
                    }.cornerRadius(10).padding()
                
            }.ignoresSafeArea(.keyboard, edges: .all)
        }.ignoresSafeArea(.keyboard, edges: .all)
    }
}

struct TradingRegistrationView_Previews: PreviewProvider {
    @State static var hoge = true
    static var previews: some View {
        TradingRegistrationView(isShow: $hoge)
            .foregroundColor(Color("fontColor"))
    }
}
