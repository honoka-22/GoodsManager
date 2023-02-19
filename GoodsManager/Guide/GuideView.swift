//
//  GuideView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/31.
//

import SwiftUI

struct GuideView: View {
    @ObservedObject var colors: AppColors
    var body: some View {
        VStack {
            ToolBar(colors: colors,
                    title: "ガイド")
            
            Spacer()
        }
    }
}

struct GuideView_Previews: PreviewProvider {
    static var previews: some View {
        GuideView(colors: AppColors())
    }
}
