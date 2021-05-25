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
    
    
    static func restore(productId:String?, successfulRestore:@escaping () -> Void) {
        
        Purchases.shared.restoreTransactions { purchaserInfo, error in
            
//            print(purchaserInfo?.allPurchasedProductIdentifiers.contains("premium") as Any)
            if purchaserInfo?.allPurchasedProductIdentifiers.contains("premium") ?? false {
                successfulRestore()
            }
            
            
        }
        
    }
}
