//
//  SettingView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

struct SettingView: View {
    @ObservedObject var colors: AppColors
    @Binding var isShowSetting: Bool
    @State var isShowSettingColors = false
    
    var body: some View {
        VStack(spacing: 0) {
            ToolBar(colors: colors,
                    isShowBackButton: true,
                    title: "設定") {
                isShowSetting = false
            }
            
            List {
                HStack {
                    Text("色変更")
                    Spacer()
                }
                .contentShape(Rectangle())
                .foregroundColor(.black)
                .onTapGesture {isShowSettingColors.toggle()}
            }
        }
        .fullScreenCover(isPresented: $isShowSettingColors) {
            ChangeColorsView(colors: colors, isShow: $isShowSettingColors)
        }
        
    }
}
