//
//  TipView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/25/21.
//

import SwiftUI

struct TipView: View {
    var body: some View {
        VStack {
            
            
            
            
            
            List {
                
                Section {
                    Text("Hey there 👋, \n\tMy name is Ethan, I'm a student and developer working on this app in my free time. If you're enjoying it and would like to provide me with food or caffeine while I work on adding new features that would be greatly appreciated! 😁\n\nThank you for your support of Happy Car!")
    
                }
                .padding(5)
                .frame(alignment: .leading)
                
                Section {
                    Button(action: {
                        
                        PurchaseService.purchase(productId: "tip199") {
                            print("199 Purchased")
                        }
                        
                    }, label: {
                        TipCellView(emoji: "☕", name: "Get Ethan a Coffee", price: "$1.99")
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        
                        PurchaseService.purchase(productId: "tip399") {
                            print("199 Purchased")
                        }
                        
                    }, label: {
                        TipCellView(emoji: "☕☕", name: "Get Ethan two coffees 😳", price: "$3.99")
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        
                        PurchaseService.purchase(productId: "tip699") {
                            print("199 Purchased")
                        }
                        
                    }, label: {
                        TipCellView(emoji: "🌯", name: "Get Ethan a burrito", price: "$6.99")
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        
                        PurchaseService.purchase(productId: "tip999") {
                            print("199 Purchased")
                        }
                        
                    }, label: {
                        TipCellView(emoji: "🍛", name: "Get Ethan a poke bowl", price: "$9.99")
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                
 
                
                
                
            }
            //            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Tip jar")
        }
    }
}

struct TipView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        TipView()
        
        
    }
}
