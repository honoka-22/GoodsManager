//
//  CheckListCell.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/03.
//

import SwiftUI

struct CheckListCell: View {
    @Binding var text: String
    @Binding var isChecked: Bool
    
    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
            Text(text)
            Spacer()
        }
        .padding(10)
        // spacer部分でもtapが反応するようにする
        .contentShape(Rectangle())
        .onTapGesture {
            isChecked.toggle()
            // 押した時の感覚
            UIImpactFeedbackGenerator(style: .medium)
                    .impactOccurred()
        }
    }
}
