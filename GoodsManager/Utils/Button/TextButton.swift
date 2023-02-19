//
//  TextButton.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

struct TextButton: View {
    @ObservedObject var colors = AppColors()
    let label: String
    let action: () -> ()
    @State private var rectangleHeight: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            Button {
                action()
            } label: {
                Text(label)
                    .padding()
                    .foregroundColor(colors.accentColor3)
                    .frame(maxWidth:geometry.size.width)
                    .readHeight($rectangleHeight)
                    .background(colors.mainColor2)
                    .clipShape(Capsule())
            }

        }.frame(height: rectangleHeight).padding()
    }
}

struct TextButton_Previews: PreviewProvider {
    static var previews: some View {
        TextButton(label: ""){}
    }
}
