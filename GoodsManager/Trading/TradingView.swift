//
//  TradingView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/31.
//

import SwiftUI

struct TradingView: View {
    @ObservedObject var viewModel: TradingViewModel
    let trading: Trading
    @Binding var isShow: Bool
    let color = AppColors()
    
    var body: some View {
        ZStack {
            Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all)
            
            VStack {
                ToolBar(colors: AppColors(),isShowBackButton: true, title: "\(trading.partner.name) 様") {
                    isShow.toggle()
                }
                
                HStack {
                    Text("\(trading.partner.tool)")
                    Spacer()
                    Text("\(trading.partner.account)")
                    Spacer()
                }.padding(.horizontal)
                HStack {
                    Group {
                        Text(trading.status.type)
                        Text(trading.status.method)
                        Text(trading.status.status)
                    }
                    .padding(.vertical, 5)
                    .frame(maxWidth: SCREEN_WIDTH / 3)
                    .background(color.mainColor2)
                    .foregroundColor(color.accentColor3)
                    .cornerRadius(5.0)
                }
                .padding(.horizontal)
                .padding(.bottom)
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 3) {
                        HStack {
                            Text("自分")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                        }
                        
                        if trading.status.type.contains("買取") {
                            Divider()
                            Text("渡す金額: \(trading.purchasePrice)円")
                                .padding(.horizontal)
                        }
                        if trading.status.type != "買取" {
                            ForEach(viewModel.passGoods) { item in
                                Divider()
                                PassListCell(item: item)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10.0)
                    .padding(.horizontal)
                    
                    Text("↑↓")
                    
                    VStack(alignment: .leading, spacing: 3) {
                        HStack {
                            Text(trading.partner.name + " 様")
                                .font(.subheadline)
                                .bold()
                            Spacer()
                        }
                        
                        if trading.status.type.contains("譲渡") {
                            Divider()
                            Text("受け取る金額: \(trading.salesPrice)円")
                                .padding(.horizontal)
                        }
                        if trading.status.type != "譲渡" {
                            ForEach(viewModel.giveGoods) { item in
                                Divider()
                                PassListCell(item: item)
                            }
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.white)
                    .cornerRadius(10.0)
                    .padding(.horizontal)
                    
                    if trading.memo != "" {
                        VStack(alignment: .leading, spacing: 3) {
                            HStack {
                                Text("memo")
                                    .font(.subheadline)
                                    .bold()
                                Spacer()
                            }
                            Divider()
                            .padding(.bottom, 5)
                            Text(trading.memo)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.white)
                        .cornerRadius(10.0)
                        .padding(.horizontal)
                    }
                }
                
                
                Spacer()
                

            }
        }
        
    }
}
