//
//  HomeButton.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import SwiftUI

struct HomeButton: View {
    let text: String
    let colors: AppColors
    let action: () -> ()
    
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Button {
                    // アニメーション無効
                    var transaction = Transaction()
                    transaction.disablesAnimations = true
                    withTransaction(transaction) {
                        action()
                    }
                } label: {
                    Text(text)
                        .font(.title2)
                        .bold()
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity)
                        .foregroundColor(colors.accentColor3)
                        .background(colors.mainColor2)
                        .cornerRadius(15)
                        .onTapGesture {
                            action()
                        }
                }
                
            }
        }
        
        
    }
}
