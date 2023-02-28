//
//  Goods.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/01.
//

import Foundation

struct Product: Identifiable, Decodable {
    let id: String
    var name: String
    var title: String
}

struct Category: Identifiable, Decodable {
    let id: String
    var name: String
}

struct Goods: Identifiable, Decodable {
    let id: String
    var base = GoodsBase()
}

struct MyGoods: Identifiable, Decodable {
    let id: String
    var base = GoodsBase()
//    var title: String = ""
//    var product: String = ""
//    var category1: String = ""
//    var category2: String = ""
    var code: String = ""
    var price: Int = 0
    var images = [String]()
    var counts: [Count]?
}

struct Count: Identifiable, Decodable {
    var id = UUID()
    /// キャラクター
    var character: Character
    /// 所持数
    var possession: Int = 0
    /// 予約
    var reservation = Detail()
    /// 目標数
    var target: Int = 0
    
}

struct Detail: Decodable {
    /// 手元に残る個数
    var strayChild: Int = 0
    /// お譲り先が決まっている個数
    var trading: Int = 0
    /// お取引で受け取る個数
    var promise: Int = 0
}
