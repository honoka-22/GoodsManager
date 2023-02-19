//
//  MyGoodsStep02.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import SwiftUI

struct MGStep02: View {
    @ObservedObject var viewModel: MyGoodsPostViewModel
    
    init(viewModel: MyGoodsPostViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            Text("この商品に入っているキャラクターを選択してください")
                .font(.footnote)
            ScrollView(showsIndicators: false) {
                if !viewModel.road {
                    CheckListView(items: $viewModel.checkList)
                    
                }
            }
        }.padding()
    }
}





//struct MyGoodsStep02_Previews: PreviewProvider {
//    static var previews: some View {
//        MyGoodsStep02()
//    }
//}
