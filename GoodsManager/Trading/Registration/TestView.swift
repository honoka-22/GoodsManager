//
//  TestView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/03.
//

import SwiftUI

struct TestView: View {
    @StateObject var viewModel = FirebaseViewModel()
    @StateObject var viewModel2 = CharacterListViewModel()
    @State var isShowCheckBox = false
    
    @State var isShowList = false
    

    
    var body: some View {
        VStack {
            ToolBar(colors: AppColors(), title: "テスト")
                .padding(.bottom)
            
            if isShowCheckBox {
                
                Spacer()
                
                HStackButton(
                    colors: AppColors(),
                    rightText: "閉じる",
                    rightAction: {
                        isShowCheckBox.toggle()
                    }, leftText: "表示",
                    leftAction: {
                        viewModel.showCheckItem()
                    })
                .padding()
                
            } else {
                ScrollView {
                    ForEach(viewModel2.titlesCharacters) { item in
                        ListView(titleCharacters: item)
                    }
                }
                
                Button {
//                    viewModel.check()
                    isShowCheckBox.toggle()
                } label: {
                    
                    Text("チェックボックスを表示する")
                }
            }
        }
        .background(Color(UIColor.quaternarySystemFill).ignoresSafeArea(.all))
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
