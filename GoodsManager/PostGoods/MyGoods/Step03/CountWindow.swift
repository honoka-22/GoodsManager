//
//  CountWindow.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/15.
//

import SwiftUI

struct CountWindow: View {
    @ObservedObject var viewModel: MyGoodsPostViewModel
    @Binding var isShow: Bool
    @State var possession = 0
    @State var reservation = 0
    
    var body: some View {
        VStack(spacing: 0) {
            
            Text(viewModel.getCountName())
                .padding(.top)
            HStack {
                CountField(label: "所持", count: $possession)
                CountField(label: "予約", count: $reservation)
            }.padding()
            
            
            
            Divider()
            HStackButton(
                colors: AppColors(),
                rightText: "キャンセル",
                rightAction: {
                    isShow.toggle()
                }, leftText: "登録") {
                    viewModel.saveCount(possession: possession, reservation: reservation)
                    isShow.toggle()
                }
        }
        .frame(maxWidth: .infinity)
        .background(.white)
        .cornerRadius(10)
        .padding()
        .onAppear {
            possession = viewModel.counts[viewModel.countIndex].possession
            reservation = viewModel.counts[viewModel.countIndex].reservation.strayChild
        }
    }
}

struct CountField: View {
    let label: String
    @Binding var count: Int
    
    var body: some View {
        HStack {
            Text(label + ": ")
            TextField("", value: $count, formatter: NumberFormatter())
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        
    }
}
