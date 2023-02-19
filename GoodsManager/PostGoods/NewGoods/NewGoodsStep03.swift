//
//  NewGoodsStep03.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import SwiftUI

struct NewGoodsStep03: View {
    @ObservedObject var viewModel: NewGoodsPostViewModel
    var body: some View {
        VStack(spacing: 0) {
            Text("登録内容を確認してください")
                .font(.footnote)
                .padding(.bottom)
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        Text("作品名").font(.footnote).bold()
                        Spacer()
                    }
                    
                    Text(viewModel.selectTitle!.name)
                        .padding(.bottom)
                    Text("商品名").font(.footnote).bold()
                    Text(viewModel.selectProduct!.name)
                        .padding(.bottom)
                    Text("内容").font(.footnote).bold()
                    
                    ForEach(viewModel.selectCharacters) { character in
                        Text(character.firstName + " " + character.lastName)
                    }
                }
                
            }
            
        }.padding()
    }
}

//struct NewGoodsStep03_Previews: PreviewProvider {
//    static var previews: some View {
//        NewGoodsStep03()
//    }
//}
