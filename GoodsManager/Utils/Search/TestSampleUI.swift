//
//  TestSampleUI.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

struct TestSampleUI: View {
    @ObservedObject var viewModel: BarCodeViewModel = BarCodeViewModel()
    @Binding var code: String
    let action: () -> ()
    
    var body: some View {
        if(self.viewModel.isFound){
            HStack {
                Text(self.viewModel.code)
                Button {
                    viewModel.isFound = false
                } label: {
                    Text("×")
                }
            }
            .onAppear {
                code = viewModel.code
                action()
            }
            
        }else{
            Button {
                self.viewModel.isShowing = true
            } label: {
                Image(systemName: "barcode")
                    .font(.title)
                    
                    
            }.fullScreenCover(isPresented: self.$viewModel.isShowing) {
                BarCodeReader()
                    .found(self.viewModel.onFound)
                    .close(self.viewModel.onClose)
            }
            
        }
    }
}

//struct TestSampleUI_Previews: PreviewProvider {
//    static var previews: some View {
//        TestSampleUI()
//    }
//}
