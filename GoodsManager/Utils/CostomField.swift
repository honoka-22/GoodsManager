//
//  CostomField.swift
//  GoodsManager
//
//  Created by cmStudent on 2023/02/19.
//

import SwiftUI



struct CostomField: View {
    @Binding var text: String
    @FocusState private var focusedField: Field?
    
    private enum Field: Hashable {
           case text
    }
    
    var body: some View {
        TextField("", text: $text)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .focused($focusedField, equals: .text)
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Spacer()
                        Button("Done") {
                            focusedField = nil
                        }
                    }
                }
            }
    }
}

