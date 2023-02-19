//
//  MyGoodsStep04.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/13.
//

import SwiftUI

struct MyGoodsStep04: View {
    @ObservedObject var viewModel: MyGoodsPostViewModel
    @State var select = 0
    @State var isImageEdit = false
    @State private var rectangleHeight: CGFloat = .zero
    @Binding var isShow: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("画像を選択")
                .font(.footnote)
                .padding(.top)
            
            HStack {
                ForEach(0 ..< 5) { index in
                    GeometryReader { geometry in
                        ZStack {
                            Color.gray.opacity(0.5)
                            
                            if index <= viewModel.images.count {
                                Button {
                                    select = index
                                    isImageEdit.toggle()
                                } label: {
                                    if index < viewModel.images.count {
                                        Image(uiImage: viewModel.images[index])
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                    } else if index == viewModel.images.count {
                                        Image(systemName: "plus.circle")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .padding()
                                    }
                                }
                                .fullScreenCover(isPresented: $isImageEdit) {
                                    ImageEditView(images: $viewModel.images,
                                                  isShow: $isImageEdit,
                                                  select: $select)
                                }
                                
                            }
                        }
                        .frame(width: geometry.size.width, height: geometry.size.width)
                        .readHeight($rectangleHeight)
                        
                    }.frame(height: rectangleHeight).padding(0.5)
                }
            }

            Text("個数を入力")
                .font(.footnote)
                .padding(.top)

            CountList(viewModel: viewModel, isShow: $isShow)
            
            Spacer()
        }.padding()
    }
}


//struct MyGoodsStep04_Previews: PreviewProvider {
//    static var previews: some View {
//        MyGoodsStep04()
//    }
//}
