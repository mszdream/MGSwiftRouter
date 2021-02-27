//
//  CommonTools.swift
//  iosProject
//
//  Created by hello on 2018/4/11.
//  Copyright © 2018年 Mobi Magic. All rights reserved.
//

import UIKit
import Foundation

class CommonTools {
    
}

// UIViewController
extension CommonTools {
    
    class func topViewController() -> UIViewController? {
//        let rootVC = UIApplication.shared.keyWindow?.rootViewController   // ios13后弃用
        let keyWindow = UIApplication.shared.windows.first
        let rootVC = keyWindow?.rootViewController
        var resultVC = self.topViewController(vc: rootVC)
        while resultVC?.presentedViewController != nil {
            resultVC = self.topViewController(vc: resultVC?.presentedViewController)
        }
        return resultVC
    }
    
    fileprivate class func topViewController(vc: UIViewController?) -> UIViewController? {
        if let ctrl = vc as? UINavigationController {
            return self.topViewController(vc: ctrl.topViewController)
        } else if let ctrl = vc as? UITabBarController {
            return self.topViewController(vc: ctrl.selectedViewController)
        } else {
            return vc
        }
    }
}

// UIImage
extension CommonTools {
//    + (UIImage *)imageWithColor:(UIColor *)color {
//        CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
//        UIGraphicsBeginImageContext(rect.size);
//        CGContextRef context = UIGraphicsGetCurrentContext();
//        CGContextSetFillColorWithColor(context, [color CGColor]);
//        CGContextFillRect(context, rect);
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        return image;
//    }
    
    static func imageWithColor(color: UIColor,
                               size: CGSize = CGSize(width: 1, height: 1)) -> UIImage? {
        
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image

//        guard let cgImage = image?.CGImage else { return nil }
//        self.init(CGImage: cgImage)
        
    }
    
}
