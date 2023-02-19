//
//  GoodsCell.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import SwiftUI

struct GoodsCell: View {
    
    var body: some View {
        HStack {
            Text("キャラクター名")
            
            Text("所持数")
            
            Text("予約数")
            
            Text("目標数")
        }
    }
}

struct GoodsCell_Previews: PreviewProvider {
    static var previews: some View {
        GoodsCell()
    }
}
