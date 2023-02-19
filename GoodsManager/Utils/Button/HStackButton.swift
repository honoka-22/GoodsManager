//
//  HStackButton.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

struct HStackButton: View {
    @ObservedObject var colors: AppColors
    var rightText: String
    var rightAction: () -> ()
    var leftText: String
    var leftAction: () -> ()
    
    @State private var rectangleHeight: CGFloat = .zero
    
    var body: some View {
        
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Button {
                    rightAction()
                } label: {
                    Text(rightText)
                        .bold()
                        .padding()
                        .frame(width: geometry.size.width / 2)
                        .background(colors.accentColor1)
                        .foregroundColor(colors.mainColor1)
                }
                
                Button {
                    leftAction()
                } label: {
                    Text(leftText)
                        .bold()
                        .padding()
                        .frame(width: geometry.size.width / 2)
                        .background(colors.mainColor1)
                        .foregroundColor(colors.accentColor1)
                }
            }.frame(width: geometry.size.width)
                .readHeight($rectangleHeight)
        }.frame(height: rectangleHeight)
        
    }
}


//struct HStackButton_Previews: PreviewProvider {
//    static var previews: some View {
//        HStackButton()
//    }
//}
