//
//  GoodsImages.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/01.
//

import SwiftUI

struct GoodsImages: View {
    @Binding var images: [UIImage]
    @State var selection: Int = 0
    let frame = SCREEN_WIDTH
    
    var body: some View {
        VStack {
            ZStack {
                Color.gray.opacity(0.5)
                
                TabView(selection: $selection) {
                    ForEach(0 ..< images.count, id: \.self) { index in
                        Image(uiImage: images[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .tag(index)
                    }
                }.tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack {
                    if selection != 0 && 1 < images.count{
                        Button {
                            selection -= 1
                        } label: {
                            Text("<")
                                .padding()
                                .foregroundColor(.white)
                                .background(.black.opacity(0.3))
                                .clipShape(Circle())
                                
                        }
                    }
                    Spacer()
                    if selection != (images.count - 1) && 1 < images.count{
                        Button {
                            selection += 1
                        } label: {
                            Text(">")
                                .padding()
                                .foregroundColor(.white)
                                .background(.black.opacity(0.3))
                                .clipShape(Circle())
                        }
                        
                    }
                }.padding()
                VStack() {
                    Spacer()
                    HStack() {
                        Spacer()
                        if 1 < images.count {
                            Text("\(selection + 1)/\(images.count)")
                                .font(.footnote)
                                .padding(.horizontal)
                                .foregroundColor(.white.opacity(0.7))
                                .background(.black.opacity(0.5))
                                .cornerRadius(10)
                                .padding()
                            
                        }
                    }
                }
            }.frame(width: frame, height: frame)

            
            
//            SelectView(count: images.count,
//                       selected: $selection)
            
            
        }
    }
}


struct SelectView: View {
    let count: Int
    @Binding var selected: Int
    var body: some View {
        HStack {
            ForEach(0 ..< count, id: \.self) { num in
                Text("●")
                    .font(.caption)
                    .foregroundColor(num == selected ? .white : .black)
                    .onTapGesture {
                        selected = num
                    }
            }
            
            
        }
        .padding(.horizontal)
        .background(.gray)
        .cornerRadius(50)
        
    }
}

