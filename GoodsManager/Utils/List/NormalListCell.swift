//
//  NormalListCell.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/04.
//

import SwiftUI

struct NormalListCell: View {
    let text: String
    var body: some View {
        HStack {
            Text(text)
            Spacer()
        }.padding(10)
    }
}

//struct NormalListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        NormalListCell()
//    }
//}
