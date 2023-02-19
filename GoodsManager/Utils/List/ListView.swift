//
//  ListView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/05.
//

import SwiftUI

struct ListView: View {
    let title: String
    let items: [String]
    @State var isShowList = false
    
    
    init(title: String, items: [String]) {
        self.title = title
        self.items = items
    }
    
//    init(titleCharacters: TitleCharacters) {
//        title = titleCharacters.title
//        var items = [String]()
//        for character in titleCharacters.characters {
//            items.append(character.firstName + " " + character.lastName)
//        }
//        self.items = items
//    }
 
    var body: some View {
        VStack(spacing: 0) {
            ListTitle(title: title, isShowList: $isShowList)
            
            
            if isShowList {
                ForEach(items, id: \.self) { item in
                    Divider()
                    NormalListCell(text: item)
                    
                }.background(.white)
            }
        }
        .cornerRadius(10.0)
        .padding(.horizontal)
    }
}

