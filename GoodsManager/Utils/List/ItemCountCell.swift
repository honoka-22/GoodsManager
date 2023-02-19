//
//  ItemCountCell.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/15.
//

import SwiftUI

struct ItemCountCell: View {
    @Binding var counts: Count
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(counts.character.lastName)
                .font(.subheadline)
            
            Spacer()
            
            Text("所持: ")
                .font(.footnote)
            Text("\(counts.possession)")
                .font(.subheadline)
                .frame(width: 30)
            
            Text("予約: ")
                .font(.footnote)

            Text("\(counts.reservation.strayChild + counts.reservation.trading)")
                .font(.subheadline)
                .frame(width: 30)
        }
        .padding(.horizontal)
    }
}

//struct ItemCountCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemCountCell()
//    }
//}
