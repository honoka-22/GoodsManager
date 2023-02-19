//
//  NewGoodsPostView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import SwiftUI

struct NewGoodsPostView: View {
    @StateObject var viewModel = NewGoodsPostViewModel()
    @State var isShowWindow = false
    let colors = AppColors()
    @Binding var isShow: Bool
    @State var message = ""
    
    let stepCount = 3
    @State var selectStep = 1
    
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)

            VStack(spacing: 0) {
                ToolBar(colors: AppColors(),isShowBackButton: true, title: "新規グッズ登録") {
                    // FIXME: アラートを出す
                    isShow.toggle()
                }
                
                StepView(stepCount: stepCount, selectStep: $selectStep)
                .padding()
                
                Text(message).font(.caption).foregroundColor(.red)
                
                Group {
                    if selectStep == 1 {
                        NewGoodsStep01(viewModel: viewModel,isShowWindow: $isShowWindow)
                        
                    } else if selectStep == 2 {
                        NewGoodsStep02(viewModel: viewModel)
                        
                    }  else {
                        NewGoodsStep03(viewModel: viewModel)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal)

                
                Spacer()
                
                
                HStackButton(
                    colors: colors,
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
                            if viewModel.judgeSecondStep() {
                                message = "未選択の項目があります"
                                return
                            }
                            
                            viewModel.makeCheckList()
                            selectStep = 2
                            message = ""

                        } else if selectStep == 2 {
                            print("step2")
                            viewModel.getCheckItem()
                            if 0 < viewModel.selectCharacters.count {
                                self.selectStep = 3
                                message = ""
                            } else {
                                message = "キャラクターを選択してください"
                            }
                            
                        } else {
                            // 登録
                            viewModel.postNewGoods()
                            isShow.toggle()
                        }
                    }.cornerRadius(10).padding()
                
            }
            
            if isShowWindow {
                NewProductView(viewModel: viewModel, isShow: $isShowWindow)
            }
        }
        
        
        
        
    }
}

//struct NewGoodsPostView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewGoodsPostView()
//    }
//}
