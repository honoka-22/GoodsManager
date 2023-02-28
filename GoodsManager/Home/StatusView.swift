//
//  StatusView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/30.
//

import SwiftUI

struct StatusView: View {
    @ObservedObject var viewModel = StatusViewModel()
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("現在のお取引")
                    .padding(.leading, 20)
                Spacer()
            }
            HStack {
                StatusItem(title: "取引中", count: viewModel.nowTrading) {
                    
                }
                
                StatusItem(title: "予約", count: viewModel.reservation) {
                    
                }
                
                StatusItem(title: "完了", count: viewModel.completed) {
                    
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
