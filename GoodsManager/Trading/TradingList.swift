//
//  TradingList.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import SwiftUI

struct TradingList: View {
    var body: some View {
        VStack {
            ToolBar(colors: AppColors(), title: "取引一覧")
            
            Spacer()
        }
    }
}

struct TradingList_Previews: PreviewProvider {
    static var previews: some View {
        TradingList()
    }
}
