//
//  TestSampleUI.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

struct BarCodeButton: View {
    @ObservedObject var viewModel: BarCodeViewModel = BarCodeViewModel()
    
    var body: some View {
        Button {
            self.viewModel.isShowing = true
        } label: {
            Image(systemName: "barcode")
                .resizable()
                .frame(width: 40, height: 20)
            
        }.fullScreenCover(isPresented: self.$viewModel.isShowing) {
            BarCodeReader()
                .found(self.viewModel.onFound)
                .close(self.viewModel.onClose)
        }

    }
}

struct TestSampleUI: View {
    @ObservedObject var viewModel: BarCodeViewModel = BarCodeViewModel()
    
    var body: some View {
        VStack{
            if(self.viewModel.isFound){
                Spacer()
                //番号表示
                Text(self.viewModel.code).foregroundColor(.gray)
                Button {
                    viewModel.isFound = false
                } label: {
                    Text("閉じる")
                }
                .padding()
                Spacer()
                
            }else{
                HStack {
                    //読み取り
                    Button {
                        self.viewModel.isShowing = true
                    } label: {
                        Image(systemName: "barcode")
                            .resizable()
                            .frame(width: 40, height: 20)
                        Text("Read Barcode")
                    }.fullScreenCover(isPresented: self.$viewModel.isShowing) {
                        BarCodeReader()
                            .found(self.viewModel.onFound)
                            .close(self.viewModel.onClose)
                    }
                    Spacer()
                }
                
            }
        }
        .overlay(VStack{Divider().offset(x: 0, y: 15)})
        .padding(.horizontal)
    }
}

struct TestSampleUI_Previews: PreviewProvider {
    static var previews: some View {
        TestSampleUI()
    }
}
