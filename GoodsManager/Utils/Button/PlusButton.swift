//
//  PlusButton.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/17.
//

import SwiftUI

struct PlusButton: View {
    let action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: "plus.circle")
                .foregroundColor(.blue)
                .font(.title)
        }
    }
}

struct PlusButton_Previews: PreviewProvider {
    static var previews: some View {
        PlusButton(){}
    }
}
