//
//  HomeView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var colors: AppColors
    @State var isShowTRView = false
    @State var isShowGRView = false
    @ObservedObject var viewModel = TradingViewModel()
    @Binding var selected: Int
    
    var body: some View {
        VStack {
            ToolBar(colors: colors,
                    isShowSettingButton: true,
                    title: "ホーム")
            
            StatusView()
            
            VStack() {
                HStack() {
                    HomeButton(text: "取引登録", colors: colors) {
                        isShowTRView.toggle()
                    }.fullScreenCover(isPresented: $isShowTRView) {
                        PostTradingView(isShow: $isShowTRView)
//                        TradingRegistrationView(isShow: $isShowTRView)
                    }
                    
                    HomeButton(text: "取引", colors: colors) {
                        selected = 2
                    }
                    
                }
                
                HStack() {
                    HomeButton(text: "グッズ登録", colors: colors) {
                        isShowGRView.toggle()
                        
                    }.fullScreenCover(isPresented: $isShowGRView) {
                        MyGoodsPostView(isShow: $isShowGRView)
                    }
                    
                    HomeButton(text: "グッズ", colors: colors) {
                        selected = 3
                    }
                }
            }
            .padding()
            
        }
    }
}




//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(colors: <#Binding<AppColors>#>)
//    }
//}
 
