//
//  lab10App.swift
//  lab10
//
//  Created by 蕭岳 on 2022/6/8.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct lab10App: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
