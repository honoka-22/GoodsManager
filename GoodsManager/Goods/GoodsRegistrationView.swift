//
//  GoodsRegistrationView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/31.
//

import SwiftUI

struct GoodsRegistrationView: View {
    @StateObject var viewModel = GoodsRegistrationViewModel()
    @State var nextFlag = false
    @Binding var isShow: Bool
    let colors = AppColors()
    @State var selected = 1
    let step = ["グッズ選択", "詳細情報", "内容確認"]
    
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            VStack(spacing: 0) {
                ToolBar(colors: AppColors(),
                        title: "所持グッズ登録")
                
                StepView(stepCount: step.count,
                         selectStep: $selected)
                .padding()
                
                Text(step[selected - 1])
                Group {
                    if selected == 1 {
                        GRStep01View(viewModel: viewModel, nextFlag: $nextFlag)
                    } else if selected == 2 {
                        GRStep02View(viewModel: viewModel)
                    }  else {
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                    leftText: selected < step.count ? "次へ" : "登録") {
                        if nextFlag {
                            if selected == 1 {
                                viewModel.makeCheckList()
                            }
                            self.selected = selected < step.count ? selected + 1 : 1
                        }
                        
                    }.cornerRadius(10).padding()
                
            }
            
        }
        
        
        
        
    }
}

struct GoodsRegistrationView_Previews: PreviewProvider {
    @State static var fuga = true
    static var previews: some View {
        GoodsRegistrationView(isShow: $fuga)
    }
}
