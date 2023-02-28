//
//  PTStep04.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import SwiftUI

struct PTStep04: View {
    @ObservedObject var viewModel: PostTradingViewModel
    @FocusState  var isActive:Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            RequiredMenu(label: "現在の状況",
                         items: viewModel.status,
                         selectItem: $viewModel.selectStatus)
            
            
            HStack {
                Text("メモ").font(.footnote)
                
                Spacer()
                
                if isActive {
                    Button("閉じる"){
                        isActive = false
                    }
                }
            }.padding(.horizontal)
            
            TextEditor(text: $viewModel.memo)
                .frame(minHeight: 100, maxHeight: .infinity)
                .focused($isActive)
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color(UIColor.secondaryLabel), lineWidth: 0.3))
                .ignoresSafeArea(.keyboard, edges: .all)
            
            Spacer()
        }
        .padding()
            
    }
}

//struct PTStep04_Previews: PreviewProvider {
//    static var previews: some View {
//        PTStep04()
//    }
//}
