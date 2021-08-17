//
//  IconSelectionView.swift
//  Happy Car
//
//  Created by Ethan Holen on 8/17/21.
//

import SwiftUI

struct IconSelectionView: View {
    
    let appIconService = AppIconService()
    
    var body: some View {
        List{

                Button(action: {
                    appIconService.changeAppIcon(to: .CFBundlePrimaryIcon)
                }, label: {
                    IconSelectionRow(imageName: "Default")
                })
                
                Button(action: {
                    appIconService.changeAppIcon(to: .Aqua)
                }, label: {
                    IconSelectionRow(imageName: "Aqua")
                })
                
                Button(action: {
                    appIconService.changeAppIcon(to: .Green)
                }, label: {
                    IconSelectionRow(imageName: "Green")
                })
                
                Button(action: {
                    appIconService.changeAppIcon(to: .Grey)
                }, label: {
                    IconSelectionRow(imageName: "Grey")
                })
                Button(action: {
                    appIconService.changeAppIcon(to: .Orange)
                }, label: {
                    IconSelectionRow(imageName: "Orange")
                })
                
                Button(action: {
                    appIconService.changeAppIcon(to: .Pink)
                }, label: {
                    IconSelectionRow(imageName: "Pink")
                })
                
                Button(action: {
                    appIconService.changeAppIcon(to: .Purple)
                }, label: {
                    IconSelectionRow(imageName: "Purple")
                })
                
                Button(action: {
                    appIconService.changeAppIcon(to: .Red)
                }, label: {
                    IconSelectionRow(imageName: "Red")
                })
                
                Button(action: {
                    appIconService.changeAppIcon(to: .Tan)
                }, label: {
                    IconSelectionRow(imageName: "Tan")
                })
                
                Button(action: {
                    appIconService.changeAppIcon(to: .Yellow)
                }, label: {
                    IconSelectionRow(imageName: "Yellow")
                    
                })
            
        }
        .navigationTitle("Icon")
        .listStyle(InsetGroupedListStyle())
        
    }
}

struct IconSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        IconSelectionView()
    }
}
