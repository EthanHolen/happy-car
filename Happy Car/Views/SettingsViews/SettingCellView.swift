//
//  SettingCellView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/2/21.
//

import SwiftUI

struct SettingCellView: View {
    
    var title: String
    var imgName: String
    var clr: Color
    
    var body: some View {
        HStack{
            Image(systemName: imgName)
                .font(.headline)
                .foregroundColor(clr)

            Text(title)
                .font(.headline)
                .padding(.leading, 10)
            
            Spacer()
            
//            Image(systemName: "chevron.right")
//                .font(.headline)
//                .foregroundColor(.gray)
        }
    }
}

struct SettingCellView_Previews: PreviewProvider {
    static var previews: some View {
        SettingCellView(title: "Sample Title", imgName: "clock", clr: .purple)
    }
}
