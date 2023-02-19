//
//  MyGoodsPostView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import SwiftUI

struct MyGoodsPostView: View {
    @StateObject var viewModel = MyGoodsPostViewModel()
    @ObservedObject var viewModel1 = MGStep01ViewModel()
    
    @State var message = ""
    @Binding var isShow: Bool
    let stepCount = 3
    @State var selectStep = 1
    
    @State var isShowWindow = false
    
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                ToolBar(colors: AppColors(), isShowBackButton: true, title: "Myグッズ登録") {
                    isShow.toggle()
                }
                
                StepView(stepCount: stepCount, selectStep: $selectStep)
                    .padding()
                
                Text(message).font(.caption).foregroundColor(.red)
                Group {
                    if selectStep == 1 {
                        MGStep01(viewModel: viewModel1, isShowWindow: $isShowWindow)
                        
                    } else if selectStep == 2 {
                        MGStep02(viewModel: viewModel)
                        
                    }  else if selectStep == 3 {
                        MGStep03(viewModel: viewModel, isShow: $isShowWindow)
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
                            if !viewModel1.nextStep() {
                                message = "未選択の項目があります"
                                return
                            }
                            viewModel.baseData = viewModel1.baseData
                            message = ""
                            viewModel.checkGoods()
                            viewModel.makeCheckList()
                            selectStep += 1
                            
                        } else if selectStep == 2 {
                            viewModel.makeCountsList()
                            selectStep += 1
                            
                        } else  {
                            viewModel.postMyGoods()
                            isShow.toggle()
                        }
                    }.cornerRadius(10).padding()
            }
            
            if isShowWindow {
                Color.gray.opacity(0.5).ignoresSafeArea(.all)
                if selectStep == 1 {
                    NewBaseDataWindow(viewModel: viewModel1, isShow: $isShowWindow)
                }
                
                if selectStep == 3 {
                    CountWindow(viewModel: viewModel, isShow: $isShowWindow)
                }
            }
        }
    }
}

//struct MyGoodsPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        MyGoodsPostView()
//    }
//}
