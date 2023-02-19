//
//  AppColors.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

class AppColors: ObservableObject {
    // 現在登録されている色
    @Published var mainColor1: Color = .cyan
    @Published var accentColor1: Color = .white
    @Published var accentColor2: Color = .brown
    
    @Published var mainColor2: Color = .mint
    @Published var accentColor3: Color = .white
    
    
    // Pickerで選択されている色
    @Published var selectedMainColor1: Color = .cyan
    @Published var selectedAccentColor1: Color = .white
    @Published var selectedAccentColor2: Color = .brown
    
    @Published var selectedMainColor2: Color = .mint
    @Published var selectedAccentColor3: Color = .white
    
    init() {
        initColors()
    }
    
    func initColors() {
        setStartColor(key: "mainColor1Data",
                      color: &mainColor1,
                      selectedColor: &selectedMainColor1)
        
        setStartColor(key: "mainColor2Data",
                      color: &mainColor2,
                      selectedColor: &selectedMainColor2)
        
        setStartColor(key: "accentColor1Data",
                      color: &accentColor1,
                      selectedColor: &selectedAccentColor1)
        
        setStartColor(key: "accentColor2Data",
                      color: &accentColor2,
                      selectedColor: &selectedAccentColor2)
        
        setStartColor(key: "accentColor3Data",
                      color: &accentColor3,
                      selectedColor: &selectedAccentColor3)
        
    }
    
    
    /// UserDefaultから取得したデータをセットする
    private func setStartColor(key: String, color: inout Color, selectedColor: inout Color) {
        
        let jsonDecoder = JSONDecoder()
        
        guard let colorData = UserDefaults.standard.data(forKey: key),
              let startColor = try? jsonDecoder.decode(Color.self, from: colorData) else {
            return
        }
        color = startColor
        selectedColor = color
    }

    
    func changeColors() {
        mainColor1 = selectedMainColor1
        mainColor2 = selectedMainColor2
        accentColor1 = selectedAccentColor1
        accentColor2 = selectedAccentColor2
        accentColor3 = selectedAccentColor3

        setColorData(color: mainColor1, key: "mainColor1Data")
        setColorData(color: mainColor2, key: "mainColor2Data")
        setColorData(color: accentColor1, key: "accentColor1Data")
        setColorData(color: accentColor2, key: "accentColor2Data")
        setColorData(color: accentColor3, key: "accentColor3Data")
        
        initColors()
    }
    
    // colorをData型に変換して保存する
    private func setColorData(color: Color, key: String) {
        
        let jsonEncoder = JSONEncoder()

        guard let colorData = try? jsonEncoder.encode(color) else {
            return
        }

        UserDefaults.standard.set(colorData, forKey: key)
    }
    
    /// 色が変更されていればtrue,されていなければfalseを返す
    func checkColor() -> Bool {
        if mainColor1 != selectedMainColor1 ||
            mainColor2 != selectedMainColor2 ||
            accentColor1 != selectedAccentColor1 ||
            accentColor2 != selectedAccentColor2 ||
            accentColor3 != selectedAccentColor3{
            return true
        } else {
            return false
        }
    }
}
