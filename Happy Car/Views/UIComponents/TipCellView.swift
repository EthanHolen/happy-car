//
//  TipCellView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/25/21.
//

import SwiftUI

struct TipCellView: View {
    
    let emoji: String
    let name: String
    let price: String
    
    
    var body: some View {
        
        HStack {
            Text(emoji)
                .font(.title)
            
            Text(name)

            Spacer()
            
            Text(price)
                .bold()
                .padding(5)
                .background(Color(.systemBlue))
                .foregroundColor(.white)
                .cornerRadius(5)

        }
        .padding(.vertical, 5)
    }
}

struct TipCellView_Previews: PreviewProvider {
    static var previews: some View {
        TipCellView(emoji: "☕", name: "Buy me a Coffee", price: "$1.99")
    }
}
