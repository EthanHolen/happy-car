//
//  SettingsView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/2/21.
//

import SwiftUI

struct SettingsView: View {
    
    
    var body: some View {
        
        List {
            
            Section {
                NavigationLink(
                    destination: Text("Premium Page")
                    , label: {
                        SettingCellView(title: "Premium", imgName: "plus", clr: .blue)
                    })
            }
            
            Section {
                
                
                NavigationLink(
                    destination: Text("General"),
                    label: {
                        SettingCellView(title: "General", imgName: "gear", clr: .gray)
                    })
                
                NavigationLink(
                    destination: Text("Review"),
                    
                    label: {
                        SettingCellView(title: "Write a Review", imgName: "pencil", clr: .green)
                    })
                
                NavigationLink(
                    destination: Text("Tell a Friend")
                ) {
                    SettingCellView(title: "Tell a Friend", imgName: "gift", clr: .purple)
                }
            }
            
            
            Section {
                NavigationLink(
                    destination: Text("Feature Suggestion"),
                    label: {
                        SettingCellView(title: "Suggest a Feature", imgName: "star.circle", clr: .yellow)
                    })
                
                NavigationLink(
                    destination: Text("Bug Report"),
                    label: {
                        SettingCellView(title: "Report a Bug", imgName: "exclamationmark.triangle", clr: .red)
                    })
            }
            
            
            
            
        }
        .listStyle(InsetGroupedListStyle())
        //            .environment(\.horizontalSizeClass, .regular)
        .navigationTitle("Settings")
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{
            SettingsView()
        }

    }
}
