//
//  IconSelectionRow.swift
//  Happy Car
//
//  Created by Ethan Holen on 8/17/21.
//

import SwiftUI

struct IconSelectionRow: View {
    
    let imageName: String
    
    
    var body: some View {
        HStack{
            Image(imageName)
                .resizable()
                .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(10)

            
            Text(imageName)
                .font(.title)
        }
    }
}

struct IconSelectionRow_Previews: PreviewProvider {
    static var previews: some View {
        IconSelectionRow(imageName: "Aqua")
    }
}
