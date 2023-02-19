//
//  CountList.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/15.
//

import SwiftUI

struct CountList: View {
    @ObservedObject var viewModel: MyGoodsPostViewModel
    @Binding var isShow: Bool
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Divider()
            ForEach(0 ..< viewModel.counts.count) { index in
                ItemCountCell(counts: $viewModel.counts[index])
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.countIndex = index
                        isShow.toggle()
                    }
                Divider()
            }
        }
    }
}

//struct CountList_Previews: PreviewProvider {
//    static var previews: some View {
//        CountList()
//    }
//}
