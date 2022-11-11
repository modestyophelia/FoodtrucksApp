//
//  LoginView.swift
//  Foodtrucks
//
//  Created by Ophelia Aguilar on 2022-11-02.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var dbConnection: DatabaseConnection
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.white
                
                VStack(spacing: 90){
                    Text("Välkommen").frame(width: 220)
                        .foregroundColor(.mint)
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                    
                    
                    VStack(alignment: .leading, spacing: 20) {
                        TextField("Email", text: $email)
                            .textFieldStyle(.plain)
                        Rectangle()
                            .frame(width: 393, height: 1)
                            .foregroundColor(.mint)
                        
                        SecureField("Lösenord", text: $password)
                            .textFieldStyle(.plain)
                        
                        Rectangle()
                            .frame(width: 393, height: 1)
                        .foregroundColor(.mint)}
                    
                    VStack{
                        Button {dbConnection.RegisterUser(email: email, password: password)
                        } label: {
                            Text("Bli medlem")
                                .bold()
                                .frame(width: 200, height: 40)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(LinearGradient(colors: [.mint, .blue], startPoint: .top, endPoint: .bottomTrailing))
                                ).foregroundColor(.white)
                                .padding()
                        }
                        
                        Button(action: {
                            
                            if email != "" && password != "" {
                                dbConnection.LogInUser(email: email, password: password)
                            }
                        }, label: {
                            Text("Har du redan ett konto? Logga in!").padding().foregroundColor(.mint)
                        })
                        
                    }
                } .ignoresSafeArea()
            }
        }
    }
    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            LoginView()
        }
    }
}
