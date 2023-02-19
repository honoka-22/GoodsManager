//
//  PostTradingView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import SwiftUI

struct PostTradingView: View {
    @StateObject var viewModel = PostTradingViewModel()
    @State var isShowWindow = false
    @State var message = ""
    @Binding var isShow: Bool
    let stepCount = 3
    @State var selectStep = 1
    
    
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                ToolBar(colors: AppColors(), isShowBackButton: true, title: "取引登録") {
                    isShow.toggle()
                }
                
                StepView(stepCount: stepCount, selectStep: $selectStep)
                    .padding()
                
                Text(message).font(.caption).foregroundColor(.red)
                Group {
                    if selectStep == 1 {
                        PTStep01(viewModel: viewModel)
                        
                    } else if selectStep == 2 {
                        PTStep02(viewModel: viewModel, isShowWindow: $isShowWindow)
                        
                    }  else if selectStep == 3 {
                        PTStep03(viewModel: viewModel, isShowWindow: $isShowWindow)
                        
                    } else {
                        PTStep04(viewModel: viewModel)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Spacer()
                
                HStackButton(
                    colors: AppColors(),
                    rightText: 1 < selectStep ? "戻る" : "閉じる",
                    rightAction: {
                        if 1 < selectStep {
                            selectStep -= 1
                        } else {
                            isShow.toggle()
                        }
                    },
                    leftText: selectStep < stepCount ? "次へ" : "登録") {
                        if selectStep == 1 {
                            if viewModel.name == "" {
                                message = "未記入の項目があります"
                                return
                            }
                            if viewModel.selectService == "" {
                                message = "未選択の項目があります"
                                return
                            }
                            selectStep += 1
                            message = ""
                            
                        } else if selectStep == 2 {
                            selectStep += 1
                            
                        } else if selectStep == 3 {
                            selectStep += 1
                            
                        } else  {
                            isShow.toggle()
                        }
                    }.cornerRadius(10).padding()
            }
            if isShowWindow {
                
            }
        }
    }
}

//struct PostTradingView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostTradingView()
//    }
//}
