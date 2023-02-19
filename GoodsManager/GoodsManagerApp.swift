//
//  GoodsManagerApp.swift
//  GoodsManager
//
//  Created by cmStudent on 2022/12/02.
//

import SwiftUI
import Firebase

@main
struct GoodsManagerApp: App {
    // Firebaseを使うとき必ず必要
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(AuthViewModel.shared)
        }
    }
}
