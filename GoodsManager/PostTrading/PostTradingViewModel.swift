//
//  PostTradingViewModel.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/16.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class PostTradingViewModel: ObservableObject {
    /// お相手様のお名前
    @Published var name = ""
    /// お相手様のアカウント名
    @Published var account = ""
    
    /// 取引ツール
    let tradingServices = ["Twitter", "メルカリ","LINE", "その他"]
    @Published var selectService = ""
    /// 取引タイプ ["交換", "譲渡", "買取", "交換+譲渡", "交換+買取"]
    let tradingTypes = ["交換", "譲渡", "買取", "交換+譲渡", "交換+買取"]
    @Published var selectType = ""
    /// 取引方法
    let tradingMethods = ["郵送", "手渡し", "未定"]
    @Published var selectMethod = ""
    
    let status = ["取引中", "予約", "完了"]
    @Published var selectStatus = ""
    
    /// お渡しする金額
    @Published var purchasePrice = 0
    /// 受け取る金額
    @Published var salesPrice = 0
    
//    @Published var passGoods: [String: Any]
    
    @Published var memo = ""
    
    /// 登録
    func registration() {
        
        let partner = ["name": name,
                       "account" : account,
                       "tool": selectService] as [String: Any]
        
        let status = ["type": selectType,
                       "method": selectMethod,
                       "status": selectStatus] as [String: Any]
        
        let passGoods = ["goodsID": "",
                    "characters":
                     ["character": "",
                      "count": ""]] as [String: Any]
        
        let giveGoods = ["goodsID": "",
                         "characters":
                          ["character": "",
                           "count": ""]] as [String: Any]
        
        let data = ["partner": partner,
                    "status": status,
                    "passGoods": passGoods,
                    "giveGoods": giveGoods,
                    "memo": memo] as [String: Any]
        
        
        firestore.collection("trading").addDocument(data: data) { error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("登録完了")
        }
    }
    
    
}
