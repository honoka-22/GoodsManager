//
//  ImageListCell.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/04.
//

import SwiftUI

struct ImageListCell: View {
    var image: String
    let title: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width / 4)
                
                VStack(alignment: .leading) {
                    Text(title)
                        .lineLimit(1)
                        .font(.title3)
                    
                    Spacer()
                }
                Spacer()
            }
        }
        
    }
}

//struct ImageListCell_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageListCell()
//    }
//}
