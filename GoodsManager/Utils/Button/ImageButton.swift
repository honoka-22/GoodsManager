//
//  ImageButton.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

/// 画像を使用したボタン
struct ImageButton: View {
    let image: String
    let action: () -> ()
    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                
        }
    }
}

struct ImageButton_Previews: PreviewProvider {
    static var previews: some View {
        ImageButton(image: ""){}
    }
}
