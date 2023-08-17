//
//  File.swift
//  
//
//  Created by Mac8 on 17/08/2023.
//

import Foundation
import UIKit

enum SToastType {
    case success
    case failure
    case warning
    case custom(bgColor:UIColor, icon:UIImage)
    
    var bgColor: UIColor {
        switch self {
        case .success:
            return .systemGreen
        case .failure:
            return .systemRed
        case .warning:
            return .systemBlue
        case .custom(let bgColor, _):
            return bgColor
        }
    }
    
    var icon:UIImage? {
        switch self {
        case .success:
            return UIImage(systemName: "checkmark.circle.fill")
        case .failure:
            return UIImage(systemName: "multiply.circle.fill")
        case .warning:
            return UIImage(systemName: "exclamationmark.circle.fill")
        case .custom(_ , let icon):
            return icon
        }
    }
}
