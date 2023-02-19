//
//  StatusItem.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import SwiftUI

struct StatusItem: View {
    var title: String = ""
    var count: Int = 0
    /// 遷移の処理を記入
    var action: () -> ()
    
    var body: some View {
        VStack(spacing: 0) {
            
            Text(title)
            // 100件以上の場合は99+と表示する
            Text(100 <= count ? "99+" : String(count))
                .font(.title)
                .frame(width: SCREEN_WIDTH / 4, height: SCREEN_WIDTH / 4)
                .background(.gray.opacity(0.5))
                .clipShape(Circle())
                
        }.onTapGesture {
            action()
        }
    }
}

