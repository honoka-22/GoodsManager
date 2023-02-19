//
//  ListTitle.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/03.
//

import SwiftUI

struct ListTitle: View {
    let title: String
    @Binding var isShowList: Bool
    let colors = AppColors()
    
    var body: some View {
        
        HStack {
            Text(title)
                .fontWeight(.bold)
            Spacer()
            Text(isShowList ? "▲" : "▼")
                
        }
        .padding(8)
        .foregroundColor(colors.accentColor1)
        .background(colors.mainColor1)
        .onTapGesture {
            isShowList.toggle()
        }
        
    }
}
