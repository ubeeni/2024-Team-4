//
//  MarshmelloApp.swift
//  Marshmello
//
//  Created by KimYuBin on 6/14/24.
//

import SwiftUI

@main
struct MarshmelloApp: App {
    @State var addressName = UserDefaults.standard.string(forKey: "addressName") ?? ""
    var body: some Scene {
        WindowGroup {
            //ContentView()
            if (addressName != ""){
                MarshmelloView(address: $addressName)
            }
            else{
                OnboardingView()
            }
        }
    }
}
