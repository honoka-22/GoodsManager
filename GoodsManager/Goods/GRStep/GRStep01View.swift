//
//  GRStep01View.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/04.
//

import SwiftUI

/// グッズ登録画面 Step1
struct GRStep01View: View {
    @ObservedObject var viewModel: GoodsRegistrationViewModel
    @Binding var nextFlag: Bool
    @State var titleLabel = "未選択"
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("作品選択")
            Menu {
                ForEach(viewModel.titles) { title in
                    Button {
                        viewModel.selectTitle = title
                        titleLabel = title.name
                        nextFlag = true
                    } label: {
                        Text(title.name)
                    }
                }
            } label: {
                MenuLabel(label: $titleLabel)
                    
            }
            
            
            if titleLabel != "未選択" {
                Text("商品名")
            }
            Spacer()
            
        }.padding()
    }
}

//struct GRStep01View_Previews: PreviewProvider {
//    static var previews: some View {
//        GRStep01View()
//    }
//}
