//
//  ContentView.swift
//  GoodsManager
//
//  Created by cmStudent on 2022/12/02.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        Group {
            
            if viewModel.userSession == nil {
                LoginView()
            } else {
                MainTabView()
                    .foregroundColor(Color("fontColor"))
                    .environmentObject(AuthViewModel())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
