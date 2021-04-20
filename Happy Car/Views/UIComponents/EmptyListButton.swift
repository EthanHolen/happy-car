//
//  EmptyListButton.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/14/21.
//

import SwiftUI

struct EmptyListButton: View {
    
    let buttonText: String
    
    var body: some View {
        HStack {
            Image(systemName: "plus")
                .font(.title)
            
            Text(buttonText)
                .font(.title)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.systemGray2))
        .cornerRadius(20)
        .foregroundColor(.white)
        .padding()
    }
}

struct EmptyListButton_Previews: PreviewProvider {
    static var previews: some View {
        EmptyListButton(buttonText: "New Item")
    }
}
