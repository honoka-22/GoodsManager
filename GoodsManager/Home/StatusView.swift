//
//  StatusView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import SwiftUI

struct StatusView: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("今月のお取引")
                    .padding(.leading, 20)
                Spacer()
            }
            HStack {
                StatusItem(title: "取引中", count: 1) {
                    
                }
                
                StatusItem(title: "予約", count: 10) {
                    
                }
                
                StatusItem(title: "完了", count: 100) {
                    
                }
            }
            .padding()
             .overlay(RoundedRectangle(cornerRadius: 10)
                 .stroke(Color.brown, lineWidth: 1))
        }
        
    }
}

struct StatusView_Previews: PreviewProvider {
    static var previews: some View {
        StatusView()
    }
}
