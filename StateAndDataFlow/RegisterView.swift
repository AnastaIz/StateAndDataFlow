//
//  RegisterView.swift
//  StateAndDataFlow
//
//  Created by Anastasia Izmaylova on 23.02.2022.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var user: UserManager
    @State private var name = ""
    @State private var counter = 0
    @State private var color = Color.gray
    @State private var showAlert = false
    
    var body: some View {
        VStack{
            HStack{
                TextField("Enter your Name", text: $name)
                    .multilineTextAlignment(.center)
                    .onReceive(name.publisher) { _ in
                        counter = name.count
                        if counter < 3 {
                            color = Color.red
                        } else {
                            color = Color.green
                        }
                    }
                Text("\(counter)")
                    .foregroundColor(color)
            }
            
            Button(action: registerUser) {
                HStack{
                    Image(systemName: "checkmark.circle")
                    Text("Ok")
                }
                .foregroundColor(color)
                .alert("Invalid Name", isPresented: $showAlert, actions: {}) {
                    Text("Your Name must contain 3 or more characters")
                }
            }
        }
        .padding(.horizontal)
        .onAppear {
            name = UserDefaults.standard.string(forKey: "name") ?? ""
        }
    }
}

extension RegisterView {
    private func registerUser() {
        if !name.isEmpty, counter > 2 {
            user.name = name
            user.isRegister.toggle()
            UserDefaults.standard.set(name, forKey: "name")
        } else {
            showAlert.toggle()
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
