//
//  StatusViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/19.
//

import Foundation

class StatusViewModel: ObservableObject {
    private let firebase = FirebaseFunction()
    @Published var nowTrading = 0;
    @Published var reservation = 0;
    @Published var completed = 0;
    
    init() {
        firebase.getTradings() { tradings, error in
            if let _ = error { return }
            guard let tradings = tradings else { return }

            for trading in tradings {
                let status = trading.status.status
                if status == "取引中" {
                    self.nowTrading += 1
                }
                if status == "予約" {
                    self.reservation += 1
                }
                if status == "完了" {
                    self.completed += 1
                }
            }
        }
    }
}
