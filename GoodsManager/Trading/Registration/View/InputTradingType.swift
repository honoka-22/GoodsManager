//
//  InputTradingType.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/31.
//

import SwiftUI

struct InputTradingType: View {
    let type = ["交換", "譲渡", "買取", "交換+譲渡", "交換+買取"]
    @State var selectType = "未選択"
    let method = ["郵送", "手渡し", "未定"]
    @State var selectMethod = "未選択"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("取引タイプ: ")
                Spacer()
                TextMenu(items: type, selectItem: $selectType)
                
            }
            
            HStack {
                Text("受け渡し方法: ")
                Spacer()
                TextMenu(items: method, selectItem: $selectMethod)
                
            }.padding(.vertical)
            Spacer()
            
        }.padding()

    }
}

struct InputTradingType_Previews: PreviewProvider {
    static var previews: some View {
        InputTradingType()
    }
}
