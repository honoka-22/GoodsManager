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
                    
                    ColorPicker("メインカラー1",
                                selection : $colors.selectedMainColor1,
                                supportsOpacity: false).padding()
                    
                    ColorPicker("メインカラー2",
                                selection : $colors.selectedMainColor2,
                                supportsOpacity: false).padding()
                    
                    HStack {
                        Text("メインカラー1の上に載せる色")
                            .font(.title3)
                        Spacer()
                    }.padding(.top)
                    ColorPicker("アクセントカラー1",
                                selection : $colors.selectedAccentColor1,
                                supportsOpacity: false).padding()
            
                    ColorPicker("アクセントカラー2",
                                selection : $colors.selectedAccentColor2,
                                supportsOpacity: false).padding()
                    
                    HStack {
                        Text("メインカラー2の上に載せる色")
                            .font(.body)
                        Spacer()
                    }.padding(.top)
                    ColorPicker("アクセントカラー3",
                                selection : $colors.selectedAccentColor3,
                                supportsOpacity: false).padding()
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
                .foregroundColor(.black).background(.white)
                .cornerRadius(10)
                .padding()
                
                
                Spacer()
                
            }
            .alert("警告", isPresented: $isShowAlert){
                        Button("閉じる", role: .destructive){
                            isShow.toggle()
                        }
                    } message: {
                        Text("データが保存されていません。本当に閉じますか?")
                    }
            
        }.onAppear {
            colors.initColors()
        }
        
    }
}
