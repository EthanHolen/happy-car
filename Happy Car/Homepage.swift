//
//  ContentView.swift
//  Happy Car
//
//  Created by Ethan Holen on 3/7/21.
//

import SwiftUI

struct Homepage: View {
    var body: some View {
        NavigationView {
            VStack{
                
                Text("Welcome to your happy car!")
                
            }
            .navigationBarTitle(Text("Happy Car"))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
