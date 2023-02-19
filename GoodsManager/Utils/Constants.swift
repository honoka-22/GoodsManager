//
//  Constants.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI
import Firebase

let firestore = Firestore.firestore()
let COLLECTION_USERS = firestore.collection("users")
/// 画面横幅
let SCREEN_WIDTH = UIScreen.main.bounds.width
/// 画面縦幅
let SCREEN_HEIGHT = UIScreen.main.bounds.height
