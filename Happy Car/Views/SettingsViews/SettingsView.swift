//
//  SettingsView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/2/21.
//

import SwiftUI
import MessageUI

enum ActiveSheet: Identifiable {
    case feature, bug
    
    var id: Int {
        hashValue
    }
}

struct SettingsView: View {
    
    //    @State private var mailType = "feature"
    //    @State private var showingMailView = false
    @State var mailViewResult: Result<MFMailComposeResult, Error>? = nil
    
    @State var activeSheet: ActiveSheet?
    
    
    var body: some View {
        
        List {
            
            Section {
                NavigationLink(
                    destination: PremiumView()
                    , label: {
                        SettingCellView(title: "Happy Car Premium", imgName: "plus", clr: .blue)
                    })
            }
            
            Section {
                
                
                NavigationLink(
                    destination: TipView(),
                    label: {
                        SettingCellView(title: "Tip Jar", imgName: "suit.heart", clr: Color(.systemPink))
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
                
                
                Button(action: {
                    activeSheet = .feature
                    //                    self.showingMailView.toggle()
                    
                }, label: {
                    SettingCellView(title: "Suggest a Feature", imgName: "star.circle", clr: .yellow)
                    
                })
                .buttonStyle(PlainButtonStyle())
                
                
                Button(action: {
                    activeSheet = .bug
                    //                    self.showingMailView.toggle()
                    
                }, label: {
                    SettingCellView(title: "Report a Bug", imgName: "exclamationmark.triangle", clr: .red)
                })
                .buttonStyle(PlainButtonStyle())
                
            }
            
            
            
            
        }
        .listStyle(InsetGroupedListStyle())
        //            .environment(\.horizontalSizeClass, .regular)
        .navigationTitle("Settings")
        .sheet(item: $activeSheet) { item in
            switch item {
            case .feature:
                MailView(result: self.$mailViewResult, newSubject: "NEW FEATURE", newMsgBody: "")
            case .bug:
                MailView(result: self.$mailViewResult, newSubject: "BUG REPORT", newMsgBody: "")
            }
        }
        
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{
            SettingsView()
        }
        
        
    }
}
