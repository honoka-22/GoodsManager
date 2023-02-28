//
//  GuideView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/31.
//

import SwiftUI

struct GuideView: View {
    @ObservedObject var colors: AppColors
    @State var isShowList = false
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            
            VStack {
                ToolBar(colors: colors,
                        title: "ガイド")
                
                ScrollView(showsIndicators: false) {
                    
                    VStack(spacing: 0) {
                        ListTitle(title: "郵送時の梱包方法", isShowList: $isShowList)
                        
                        
                        if isShowList {
                            VStack(alignment: .leading, spacing: 0) {
                                Text("郵送時は必ず水濡れ防止をしましょう。")
                                    .padding(.bottom)
                                
                                
                                Text("缶バッジなど").bold().font(.footnote)
                                Text("プチプチ二重+水濡れ防止")
                                    .padding(.bottom)
                                
                                Text("紙類").bold().font(.footnote)
                                Text("両面補強+水濡れ防止")
                                Text("補強には100円ショップにあるカラーボードがお勧めです。")
                            }.padding()
                            
                        }
                    }
                    .background(.white)
                    .cornerRadius(10.0)
                    .padding()
                    
                    Spacer()
                }
                
                
                
                
                
            }
        }
        
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView(colors: AppColors())
    }
}
