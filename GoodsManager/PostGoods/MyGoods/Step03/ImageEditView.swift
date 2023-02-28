//
//  ImageEditView.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/14.
//

import SwiftUI

/// 画像編集画面
struct ImageEditView: View {
    @Binding var images: [UIImage]
    @Binding var isShow: Bool
    @Binding var select: Int
    
    @State var imagePickerPresented = false
    
    var body: some View {
        VStack(spacing: 0) {
            ToolBar(colors: AppColors(), isShowBackButton: true,
                    title:"画像選択" ) {
                isShow.toggle()
            }
            
            
            if select < images.count {
                ZStack {
                    Color.gray.opacity(0.5)
                    Image(uiImage: images[select])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.frame(height: UIScreen.main.bounds.width)
                
            }
            
            Spacer()

            HStack {
                ForEach(0..<5) { index in
                    
                    ZStack {
                        Color.gray.opacity(0.3)
                        
                        if index < images.count {
                            // 画像がある
                            Image(uiImage: images[index])
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    select = index
                                }
                                
                            
                        } else if index == images.count {
                            Button {
                                imagePickerPresented.toggle()
                            } label: {
                                Image(systemName: "plus.circle")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .padding()
                            }
                            .sheet(isPresented: $imagePickerPresented) {
                                ImagePicker(images: $images)
                            }
                            
                        }
                    }
                    .border(index == select && select < images.count ? .blue : .clear , width: 3)
                    .frame(width: UIScreen.main.bounds.width / 6,
                           height: UIScreen.main.bounds.width / 6)                    
                        
                }
            }
            
            if select < images.count {
                Button {
                    images.remove(at: select)
                } label: {
                    Text("削除")
                        .foregroundColor(.red)
                }
            }
            
            TextButton(label: "完了") {
                isShow.toggle()
            }.padding()
        }
    }
}

//struct ImageEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageEditView()
//    }
//}
