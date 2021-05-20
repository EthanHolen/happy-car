//
//  PremiumView.swift
//  Happy Car
//
//  Created by Ethan Holen on 4/20/21.
//

import SwiftUI

struct PremiumView: View {
    
    //    @State private var premiumActive = UserDefaults.standard.bool(forKey: "PremiumActive")
    
    
    // Premium
    @AppStorage("PremiumActive") var premiumActive = false
    
    
    
    var body: some View {
        
        
        VStack{
            
            VStack{
                
                
                
                VStack {
                    Image(systemName: "car.fill")
                        .font(.system(size: 50))
                        .padding(.vertical, 5)
                    
                    
                    Text("Happy Car Premium")
                        .font(.title)
                        .bold()
                    
                }
                .padding(.horizontal, 10)
                .padding(.top, 20)
                
                
                
                Text("Purchase Happy Car premium to unlock unlimited vehicle and document support, along with custom document naming.")
                    .font(.footnote)
                    .padding(.horizontal, 25)
                
                
                
                if !premiumActive {
                    Button(action: {
                        
                        makePurchase(productId: "premium")
                        
                    }, label: {
                        
                        VStack {
                            Text("Purchase Happy Car Premium")
                                .font(.headline)
                            Text("$5.99 (One time Purchase)")
                                .font(.caption)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemBlue))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.bottom,20)
                        
                    })
                    
                } else {
                    Button(action: {
                        
                    }, label: {
                        
                        VStack {
                            Text("Thank you for your Purchase")
                                .font(.headline)
                            Text("You're Awesome!")
                                .font(.caption)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.systemGreen))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                        .padding(.bottom,20)
                    })
                    
                }
                
                
            }
//            .background(Color(.systemBlue).opacity(0.2))
            .cornerRadius(10)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 25)
            
            //TESTINGONLY: REMOVE THIS
            Toggle(isOn: $premiumActive, label: {
                Text("Test Premium on/off")
            })
            .padding()
            
        }
        .navigationTitle("Premium")
        .navigationBarItems(trailing:
                                Button(action: {
                                    // TODO: implement the restore functionality
                                }, label: {
                                    Text("Restore")
                                })
        )
        
        
    }
}


func makePurchase(productId: String){
    
    PurchaseService.purchase(productId: productId) {

        if productId != "" {
            // Set premium to active on a successful purchase
            UserDefaults.standard.setValue(true, forKey: "PremiumActive")
            
        }
        
    }
    
}

struct PremiumView_Previews: PreviewProvider {
    static var previews: some View {
        
        return NavigationView{
            PremiumView()
        }
        
    }
}
