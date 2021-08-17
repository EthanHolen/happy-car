//
//  AppIconService.swift
//  Happy Car
//
//  Created by Ethan Holen on 8/17/21.
//

import Foundation
import UIKit


class AppIconService {
    
    let application = UIApplication.shared

    enum AppIcon: String {
        case CFBundlePrimaryIcon
        case Aqua
        case Green
        case Grey
        case Orange
        case Pink
        case Purple
        case Red
        case Tan
        case Yellow
    }
    
    
    func changeAppIcon(to appIcon: AppIcon) {
        application.setAlternateIconName(appIcon.rawValue)
    }
}
