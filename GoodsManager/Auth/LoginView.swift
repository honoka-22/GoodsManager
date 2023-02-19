//
//  LoginView.swift
//  GoodsManager
//
//  Created by cmStudent on 2022/12/02.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State var mail:String = ""
    @State var password:String = ""
    @State var isShow = false
    var body: some View {
        VStack {
            Spacer()
            
            Text("Login")
                .font(.largeTitle)
                
            
            Spacer()
            
            TextField("mail", text: $mail)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            
            SecureField("password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text(viewModel.errorMessage)
            
            TextButton(label: "Login") {
                // パスワード・メールアドレスの入力チェック
                viewModel.login(withEmail: mail, password: password)
            }
            

            Button {
                
            } label: {
                Text("パスワードをお忘れのお方")
            }
            
            TextButton(label: "SignUp") {
                isShow.toggle()
            }
            .fullScreenCover(isPresented: $isShow) {
                SignUpView(isShow: $isShow)
                    .environmentObject(AuthViewModel())
            }
            
            Spacer()
            
        }.padding()
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthViewModel())
    }
}
