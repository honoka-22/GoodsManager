//
//  StepView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/01/31.
//

import SwiftUI

struct StepView: View {
    var stepCount: Int
    @Binding var selectStep: Int
    let colors = AppColors()
    @State private var rectangleHeight: CGFloat = .zero
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 2) {
                ForEach(1...stepCount, id: \.self) { step in
                    Text("step\(step)")
                        .bold()
                        .padding(5)
                        .frame(width: geometry.size.width / CGFloat(stepCount))
                        .foregroundColor(colors.accentColor1)
                        .background(colors.mainColor2)
                        .opacity(step == selectStep ? 1.0 : 0.5)
                        
                }
            }
            .clipShape(Capsule())
            .readHeight($rectangleHeight)
        }.frame(height: rectangleHeight).padding(.horizontal)
        
    }
}

//struct StepView_Previews: PreviewProvider {
//    static var previews: some View {
//        StepView(stepCount: 3)
//
//    }
//}
