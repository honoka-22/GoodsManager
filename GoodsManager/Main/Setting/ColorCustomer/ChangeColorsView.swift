//
//  ChangeColorsView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

struct ChangeColorsView: View {
    @ObservedObject var colors: AppColors
    @Binding var isShow: Bool
    @State var isShowAlert = false
    
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            
            VStack(spacing: 0) {
                ToolBar(colors: colors, title: "カラーカスタマー")
                    .padding(.bottom)

                VStack(spacing: 0) {
                    VStack() {
                        ColorPicker("メインカラー1",
                                    selection : $colors.selectedMainColor1,
                                    supportsOpacity: false)
                        
                        ColorPicker("メインカラー2",
                                    selection : $colors.selectedMainColor2,
                                    supportsOpacity: false).padding(.bottom)
                        
                        HStack {
                            Text("メインカラー1の上に載せる色")
                                .font(.footnote)
                            Spacer()
                        }.padding(.top)
                        
                        ColorPicker("アクセントカラー1",
                                    selection : $colors.selectedAccentColor1,
                                    supportsOpacity: false)
                
                        ColorPicker("アクセントカラー2",
                                    selection : $colors.selectedAccentColor2,
                                    supportsOpacity: false)
                        
                        HStack {
                            Text("メインカラー2の上に載せる色")
                                .font(.footnote)
                            Spacer()
                        }.padding(.top)
                        
                        ColorPicker("アクセントカラー3",
                                    selection : $colors.selectedAccentColor3,
                                    supportsOpacity: false)
                        
                    }
                    .padding()
                    .foregroundColor(Color("fontColor"))
                    .background(.white)
                    
                    Divider()
                    
                    HStackButton(
                        colors: colors,
                        rightText: "閉じる", rightAction: {
                            if colors.checkColor() {
                                isShowAlert.toggle()
                            } else {
                                colors.initColors()
                                isShow.toggle()
                            }
                        },
                        leftText: "変更", leftAction: {
                            colors.changeColors()
                        })
                }
                .cornerRadius(10)
                .padding()
                
                
                Spacer()
                
            }
            .alert("警告", isPresented: $isShowAlert){
                        Button("閉じる", role: .destructive){
                            isShow.toggle()
                        }
                    } message: {
                        Text("データが保存されていません。\n本当に閉じますか?")
                    }
            
        }.onAppear {
            colors.initColors()
        }
        
    }
}
