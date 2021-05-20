//
//  PurchaseService.swift
//  Happy Car
//
//  Created by Ethan Holen on 5/19/21.
//

import Foundation
import Purchases

class PurchaseService {
    
    static func purchase(productId:String?, successfulPurchase:@escaping () -> Void) {
        
        guard productId != nil else {
            return
        }
        
        
        // TODO: Perform Purchase
        
        Purchases.shared.products([productId!]) { (products) in
            
            let skProduct = products[0]
            
            Purchases.shared.purchaseProduct(skProduct) { (transaction, purchaserInfo, error, userCancelled) in
                
                if error == nil && !userCancelled {
                    // Successful purchase
                    successfulPurchase()
                }
            }
        }
        
        
    }
    
    
}
