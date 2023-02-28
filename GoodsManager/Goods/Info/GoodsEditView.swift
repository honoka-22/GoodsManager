//
//  GoodsEditView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/27.
//

import SwiftUI

struct GoodsEditView: View {
    @State var isShowWindow = false
    @ObservedObject var viewModel: MyGoodsPostViewModel
    @Binding var isShow: Bool
    let action: () -> ()
    
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            
            VStack {
                ToolBar(colors: AppColors(), title: "編集")
                
                Text("※反映に時間がかかる場合があります")
                    .font(.caption).foregroundColor(.red)
                
                MGStep03(viewModel: viewModel, isShow: $isShowWindow)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                HStackButton(
                    colors: AppColors(),
                    rightText: "キャンセル",
                    rightAction: {
                        isShow.toggle()
                    },
                    leftText: "編集") {
                        viewModel.postMyGoods()
                        isShow.toggle()
                        if viewModel.road {
                            action()
                        }
                        
                    }.cornerRadius(10).padding()
            }
            
            if isShowWindow {
                Color.gray.opacity(0.5).ignoresSafeArea(.all)
                CountWindow(viewModel: viewModel, isShow: $isShowWindow)
            }
        }

    }
}

//struct GoodsEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoodsEditView()
//    }
//}


//MGStep03(viewModel: MGViewModel, isShow: $isShowMG)
//@ObservedObject var MGViewModel: MyGoodsPostViewModel
//MGViewModel = MyGoodsPostViewModel(baseData: viewModel.baseData,
//                                   images: viewModel.images,
//                                   counts: viewModel.counts)
