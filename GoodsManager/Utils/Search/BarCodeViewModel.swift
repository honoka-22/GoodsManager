//
//  BarCodeViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import Foundation

class BarCodeViewModel: ObservableObject {
    /// コード
    @Published var code: String = "read barcode..."
    /// 表示フラグ
    @Published var isShowing: Bool = false
    // 発見フラグ
    @Published var isFound: Bool = false

    /// QRコード読み取り時イベント
    func onFound(_ code: String) {
        self.code = code
        self.isShowing = false
        self.isFound = true
    }
    
    /// 閉じるイベント
    func onClose() {
        self.isShowing = false
    }
}
