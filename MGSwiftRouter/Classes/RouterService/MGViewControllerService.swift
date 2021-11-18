//
//  MGViewControllerService.swift
//  MGSwiftRouter
//
//  Created by hello on 2021/11/18.
//

import Foundation

public extension UIViewController {
    static var mg_router_parameters_key = "mg_router_parameters_key"
    
    /// 入参
    var mg_router_parameters: [String: Any]? {
        get {
            return objc_getAssociatedObject(self, &UIViewController.mg_router_parameters_key) as? [String: Any]
        }
        set {
            objc_setAssociatedObject(self, &UIViewController.mg_router_parameters_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    static var mg_router_return_closure_key = "mg_router_return_closure_key"
    
    /// 退出时执行的回调
    var mg_router_return_closure: MGServiceEntry.RetClosure? {
        get {
            return objc_getAssociatedObject(self, &UIViewController.mg_router_return_closure_key) as? MGServiceEntry.RetClosure
        }
        set {
            objc_setAssociatedObject(self, &UIViewController.mg_router_return_closure_key, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

public extension UIViewController {
    class func mg_router_top_view_controller() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.first
        let rootVC = keyWindow?.rootViewController
        var resultVC = self.mg_router_top_view_controller(vc: rootVC)
        while resultVC?.presentedViewController != nil {
            resultVC = self.mg_router_top_view_controller(vc: resultVC?.presentedViewController)
        }
        return resultVC
    }
    
    fileprivate class func mg_router_top_view_controller(vc: UIViewController?) -> UIViewController? {
        if let ctrl = vc as? UINavigationController {
            return self.mg_router_top_view_controller(vc: ctrl.topViewController)
        } else if let ctrl = vc as? UITabBarController {
            return self.mg_router_top_view_controller(vc: ctrl.selectedViewController)
        } else {
            return vc
        }
    }
    
    /// 退出
    func close_with_parameters(parameters: Any?) {
        let isAnimated = Bool((mg_router_parameters?["isAnimated"] as? String) ?? "true") ?? true
        let isPushed = Bool((mg_router_parameters?["isPushed"] as? String) ?? "true") ?? true
        if true == isPushed {
            self.navigationController?.popViewController(animated: isAnimated)
        } else {
            self.dismiss(animated: isAnimated, completion: nil);
        }
        
        mg_router_return_closure?(parameters)
    }
    
}

/// 跳转路由服务
/// 参数
/// isPushed: 是否是push方式，如果不是push方式，则会以present方式载入
/// isAnimated: 是否使用动画
/// 注意：isPushed等Bool类型的变量，只支持true或false，不可以用数字
public class MGViewControllerService<T: UIViewController>: MGServiceEntry {
    public static func shooting(scheme: String, path: String, params: [String : Any], retClosure: RetClosure?) {
        let vc = T()
        vc.mg_router_parameters = params
        vc.mg_router_return_closure = retClosure
        guard let parentVc = UIViewController.mg_router_top_view_controller() else {
            return
        }
        
        let isAnimated = Bool((params["isAnimated"] as? String) ?? "true") ?? true
        let isPushed = Bool((params["isPushed"] as? String) ?? "true") ?? true
        if true == isPushed {
            parentVc.navigationController?.pushViewController(vc, animated: isAnimated)
        } else {
            parentVc.navigationController?.present(vc, animated: isAnimated, completion: nil)
        }
    }
    
    public static func host() -> String {
        return "mg.router"
    }
    
}
