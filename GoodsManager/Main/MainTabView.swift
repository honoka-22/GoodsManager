//
//  MainTabView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var colors = AppColors()
    /// 選択中のタブ
    @State var selected = 0

    var body: some View {
        VStack(spacing: 0) {
            
            if selected == 0 {
                // ホーム
                HomeView(colors: colors, selected: $selected)
            } else if selected == 1 {
                // カレンダー
                
            } else if selected == 2 {
                // 取引
                TradingList()
            } else if selected == 3 {
                // グッズ
                GoodsList()
                
            } else if selected == 4 {
//                GuideView(colors: colors)
                TestSampleUI()
            }
            
            // TODO: 各種アイコン用意する
            HStack(alignment: .bottom, spacing: 0) {
                TabIcon(tab: 0,
                        image: "house",
                        text: "ホーム",
                        selected: $selected)
                
                // FIXME: 余裕があれば追加する
//                TabIcon(tab: 1,
//                        image: "calendar",
//                        text: "カレンダー",
//                        selected: $selected)
                
                TabIcon(tab: 2,
                        image: "repeat.circle",
                        text: "取引",
                        selected: $selected)
                
                TabIcon(tab: 3,
                        image: "person.crop.circle",
                        text: "グッズ",
                        selected: $selected)
                
                TabIcon(tab: 4,
                        image: "text.book.closed",
                        text: "ガイド",
                        selected: $selected)
                
                
                
            }
            .padding(.top, 5)
            .padding(.bottom)
            .frame(width: SCREEN_WIDTH)
            .background(colors.mainColor1
                .ignoresSafeArea(edges: .bottom))
            
            
        }.ignoresSafeArea(.keyboard, edges: .all)
        
        
        
    }
}

struct TabIcon: View {
    let colors = AppColors()
    
    var tab: Int
    var image: String
    var text: String
    @Binding var selected: Int
    
    var body: some View {
        VStack {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                
                .frame(height: SCREEN_WIDTH / 12)
                .padding(.top, 5)
            Text(text)
                .font(.footnote)
                .bold()
        }
        .foregroundColor(tab == selected ? colors.accentColor1 : colors.accentColor2)
        .onTapGesture {
            selected = tab
        }
        .frame(width: SCREEN_WIDTH / 5)
    }
    
}

//struct MainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabView()
//    }
//}
