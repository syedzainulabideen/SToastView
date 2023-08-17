//
//  File.swift
//  
//
//  Created by Mac8 on 17/08/2023.
//

import Foundation
import UIKit

public struct ToastConfiguration {
    public var widthPercentage:CGFloat
    public var height:CGFloat
    public var edgeDistance:CGFloat
    public var rightButtonText:String?
    public var animationDuration: TimeInterval
    public var displayDuration: TimeInterval
    public var type:SToastType
    
    public init(widthPercentage: CGFloat = 0.8, height: CGFloat = 60.0, edgeDistance: CGFloat = 50, rightButtonText: String? = nil, animationDuration: TimeInterval = 0.3, displayDuration: TimeInterval = 3.0, type: SToastType = .success) {
        self.widthPercentage = widthPercentage
        self.height = height
        self.edgeDistance = edgeDistance
        self.rightButtonText = rightButtonText
        self.animationDuration = animationDuration
        self.displayDuration = displayDuration
        self.type = type
    }
    
    public static let `successConfig` = ToastConfiguration(type: .success)
    public static let `failureConfig` = ToastConfiguration(type: .failure)
    public static let `warningConfig` = ToastConfiguration(type: .warning)
}
