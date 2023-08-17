//
//  File.swift
//  
//
//  Created by Mac8 on 17/08/2023.
//

import Foundation
import UIKit

struct ToastConfiguration {
    var widthPercentage:CGFloat
    var height:CGFloat
    var edgeDistance:CGFloat
    var rightButtonText:String?
    var animationDuration: TimeInterval
    var displayDuration: TimeInterval
    var type:SToastType
    
    init(widthPercentage: CGFloat = 0.8, height: CGFloat = 60.0, edgeDistance: CGFloat = 50, rightButtonText: String? = nil, animationDuration: TimeInterval = 0.3, displayDuration: TimeInterval = 3.0, type: SToastType = .success) {
        self.widthPercentage = widthPercentage
        self.height = height
        self.edgeDistance = edgeDistance
        self.rightButtonText = rightButtonText
        self.animationDuration = animationDuration
        self.displayDuration = displayDuration
        self.type = type
    }
    
    static let `successConfig` = ToastConfiguration(type: .success)
    static let `failureConfig` = ToastConfiguration(type: .failure)
    static let `warningConfig` = ToastConfiguration(type: .warning)
}
