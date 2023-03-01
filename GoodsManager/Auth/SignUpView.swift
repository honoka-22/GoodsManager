//
//  SignUpView.swift
//  GoodsManager
//
//  Created by cmStudent on 2022/12/02.
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @State var mail:String = ""
    @State var password:String = ""
    @State var rePassword:String = ""
    @Binding var isShow: Bool
    
    @State var message: String = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            Text("Sign Up")
                .font(.largeTitle)
            
            Spacer()
            
            Text(message).padding()
            
            Group {
                TextField("メールアドレスを入力してください", text: $mail)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                
                SecureField("パスワードを入力してください", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("パスワードをもう一度入力してください", text: $rePassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Spacer()
            
            
            TextButton(label: "Sign up") {
                if mail == "" || password == "" || rePassword == "" {
                    message = "未入力の項目があります"
                    return
                }
                if password != rePassword {
                    message = "パスワードが違います"
                    return
                }
                
                // パスワード・メールアドレスの入力チェック
                viewModel.register(
                    withEmail: mail,
                    password: password)
                isShow.toggle()
            }.padding()
            
            
            /// ログイン画面に遷移する
            TextButton(label: "Login") {
                isShow.toggle()
            }.padding()
            
            Spacer()
            
        }.padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    @State static var isShow = true
    static var previews: some View {
        SignUpView(isShow: $isShow)
            .environmentObject(AuthViewModel())
    }
}
