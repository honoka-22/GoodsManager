//
//  Trading.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/27.
//

import Foundation

struct Partner: Decodable {
    let name: String
    var account = ""
    var tool: String
}


struct Status: Codable {
    var type: String
    var method: String
    var status: String
}


struct PassCharacter: Identifiable, Decodable {
    let id: String
    let name: String
    var countNum: Int = 0
}

struct PassItem: Identifiable, Decodable {
    let id: String
    let goodsData: GoodsBase
    var characters = [PassCharacter]()
}

struct Trading: Identifiable {
    let id: String
    var partner: Partner
    var status: Status
    var passGoods = [[String: Any]]()
    var purchasePrice: Int = 0
    var giveGoods = [[String: Any]]()
    var salesPrice: Int = 0
    var memo: String = ""
}


