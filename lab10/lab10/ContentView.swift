//
//  ContentView.swift
//  lab10
//
//  Created by 蕭岳 on 2022/6/8.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var textfirld_name: String = ""
    @State var textfield_email: String = ""
    @State var textfield_password: String = ""
    @State var isNowLogin: Bool = islogin()
    @State var isNotMember: Bool = false
    
    var body: some View {
        NavigationView{
            if(isNowLogin){
                VStack{
                    Text("is login").padding()
                    Text("name : " + String(Auth.auth().currentUser!.displayName!)).padding()
                    Text("email : " + String(Auth.auth().currentUser!.email!)).padding()
                    Button("log out"){
                        dologout()
                        isNowLogin = islogin()
                    }
                }
            }else{
                VStack{
                    TextField("email", text: $textfield_email).padding()
                    TextField("password", text: $textfield_password).padding()
                    Button("Login"){
                        signin(input_email: textfield_email, input_password: textfield_password)
                        if(islogin()){
                            textfield_email = ""
                            textfield_password = ""
                        }
                        isNowLogin = islogin()
                    }.padding()
                    NavigationLink{
                        VStack{
                            TextField("name", text: $textfirld_name).padding()
                            TextField("email", text: $textfield_email).padding()
                            TextField("password", text: $textfield_password).padding()
                            Button("create"){
                                adduser(input_email: textfield_email, input_password: textfield_password)
                                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                                changeRequest?.displayName = textfirld_name
                                changeRequest?.commitChanges(completion: {error in guard error == nil else{
                                    print("is error")
                                    print(error?.localizedDescription)
                                    return
                                }})
                                if(islogin()){
                                    textfield_email = ""
                                    textfield_password = ""
                                    textfirld_name = ""
                                }
                                isNowLogin = islogin()
                            }
                        }
                    } label: {
                        Text("new member page")
                    }
                }
            }
        }
    }
}


func adduser(input_email: String, input_password: String){
    Auth.auth().createUser(withEmail:input_email , password:input_password){
        result, error in
        guard let user = result?.user, error == nil else{
            print(error?.localizedDescription)
            return
        }
        print(user.email, user.uid)
    }
}

func signin(input_email: String, input_password:String){
    Auth.auth().signIn(withEmail:input_email , password:input_password){
        result, error in
        guard error == nil else{
            print(error?.localizedDescription)
            return
        }
        print("sign in success ", input_email, " ", input_password)
    }
}

func islogin()->Bool{
    if let user = Auth.auth().currentUser {
        print("\(user.uid) login")
        return true
    }else{
        print("not login")
        return false
    }
}

func dologout(){
    do{
        try Auth.auth().signOut()
    } catch {
        print(error)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
