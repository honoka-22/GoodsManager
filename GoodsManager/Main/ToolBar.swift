//
//  ToolBar.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

struct ToolBar: View {
    @ObservedObject var colors: AppColors
    @State var isShowSetting = false
    
    /// バックボタンの表示・非表示 (デフォルト: 非表示)
    var isShowBackButton: Bool = false
    /// 設定ボタンの表示・非表示 (デフォルト: 非表示)
    var isShowSettingButton: Bool = false
    /// タブバーに表示するタイトル
    let title: String
    var backAction: () -> () = {}
    
    
    var body: some View {
        ZStack {
            HStack(alignment: .top, spacing: 0) {
                if isShowBackButton {
                    ToolBarItem(image:"chevron.backward") {
                        backAction()
                    }
                }
                
                Spacer()
                
                if isShowSettingButton {
                    ToolBarItem(image: "gear") {
                        isShowSetting.toggle()
                    }
                    .fullScreenCover(isPresented: $isShowSetting) {
                        SettingView(colors: colors,
                                    isShowSetting: $isShowSetting)
                    }
                }
            }
            
            HStack {
                Text(title)
                    .font(.title2)
            }
        }
        
        .foregroundColor(colors.accentColor1)
        .padding(.vertical)
        .frame(width: SCREEN_WIDTH)
        .background(colors.mainColor1
            .ignoresSafeArea(edges: .top))
    }
}

struct ToolBarItem: View {
    let image: String
    let action: () -> ()
    var body: some View {
        ImageButton(image: image) {
            // アニメーション無効
            var transaction = Transaction()
            transaction.disablesAnimations = true
            withTransaction(transaction) {
                action()
            }
        }
        .frame(height: 30)
        .padding(.horizontal)
        
    }
}

//struct ToolBar_Previews: PreviewProvider {
//    static var previews: some View {
//        ToolBar()
//    }
//}
