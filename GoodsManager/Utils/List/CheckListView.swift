//
//  CheckListView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/07.
//

import SwiftUI

struct CheckListView: View {
    @Binding var items: [CheckCharacter]

    
    var body: some View {
        
        VStack(spacing: 0) {

            ForEach($items) { item in
                if items.first!.id != item.id {
                    Divider()
                }
                CheckListCell(text: item.name, isChecked: item.isChecked)
                
                
                

            }.background(.white)
        }
        
        
    }
}

//struct CheckListView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckListView()
//    }
//}
