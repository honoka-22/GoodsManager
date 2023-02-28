//
//  TradingList.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import SwiftUI

struct StatusButton: View {
    let label: String
    let tag: Int
    @Binding var select: Int
    let color = AppColors()
    let action: () -> ()
    var body: some View {
        Text(label)
            .padding(.vertical, 5)
            .frame(maxWidth: SCREEN_WIDTH / 3)
            .background(tag == select ? color.mainColor1 : color.mainColor2)
            .foregroundColor(tag == select ? color.accentColor1 : color.accentColor3)
            .cornerRadius(5.0)
            .onTapGesture {
                if tag == select {
                    select = 0
                    action()
                } else {
                    select = tag
                    action()
                }
            }
    }
}
struct TradingList: View {
    @State var isShow = false
    @ObservedObject var viewModel = TradingViewModel()
    @State var selectStatus = 0
    
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            
            VStack {
                ToolBar(colors: AppColors(), title: "取引一覧")
                
                HStack {
                    StatusButton(label: "取引中", tag: 1, select: $selectStatus) {
                        viewModel.allTradings(select: selectStatus)
                    }
                    StatusButton(label: "予約", tag: 2, select: $selectStatus) {
                        viewModel.allTradings(select: selectStatus)
                    }
                    StatusButton(label: "完了", tag: 3, select: $selectStatus) {
                        viewModel.allTradings(select: selectStatus)
                    }
                }.padding()
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 10) {
                        ForEach(viewModel.tradings) { trading in
                            TradingCell(trading: trading)
                                .onTapGesture {
                                    viewModel.selectTrading = trading
                                    viewModel.getTrading(trading: trading)
                                    isShow.toggle()
                                }
                        }
                    }
                }
                .fullScreenCover(isPresented: $isShow) {
                    if let trading = viewModel.selectTrading {
                        TradingView(viewModel: viewModel, trading: trading, isShow: $isShow)
                    }
                    
                }
                
                Spacer()
            }
        }
        
    }
}

struct TradingCell: View {
    let trading: Trading
    let color = AppColors()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("取引相手: \(trading.partner.name)様")
                Text("連絡ツール: \(trading.partner.tool)")
            }
            
            Spacer()
            
            
            VStack(spacing: 3) {
                Group {
                    Text(trading.status.type).bold()
                    Text(trading.status.method).bold()
                    Text(trading.status.status).bold()
                }
                .padding(.vertical, 3)
                .frame(width: SCREEN_WIDTH / 4)
                .font(.subheadline)
                .background(color.mainColor2)
                .foregroundColor(color.accentColor3)
                .cornerRadius(5.0)
            }

            
        }
        .padding()
        .background(.white)
        .cornerRadius(10.0)
        .padding(.horizontal)
        
    }
}


