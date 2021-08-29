//
//  GeneralSettingsView.swift
//  Happy Car
//
//  Created by Ethan Holen on 7/20/21.
//

import SwiftUI

struct GeneralSettingsView: View {
    
    @AppStorage("DaysBeforeAlert") var alertDays = 7

    
    var body: some View {
        
        
        
        List {
            
            Section(header: Text("Icon")) {
                
                NavigationLink(
                    destination: IconSelectionView(),
                    label: {
                        Text("Change App Icon")

                    })
                    .buttonStyle(PlainButtonStyle())
                
            }
            
            Section(header: Text("Notifications")) {
                
                
                
                Stepper(value: $alertDays, in: 0...1000) {
                    Text("Alert me \(self.alertDays) days before a document expires")
                }
                
                Text("If you have notifications disabled you can go to the Settings App > Happy Car > Notifications")
                    .foregroundColor(Color(.systemGray))
                
                
            }
            
            
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("General")
    }
}

struct GeneralSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralSettingsView()
    }
}
