//
//  Geometry.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/27.
//

import SwiftUI

extension View {
    /// Geometryを使用したとき、縦幅を子Viewのサイズに合わせる
    func readHeight(_ height: Binding<CGFloat>) -> some View {
        background(GeometryReader { geometry -> Color in
            DispatchQueue.main.async {
                height.wrappedValue = geometry.size.height
            }
            return Color.clear
        })
    }
}
