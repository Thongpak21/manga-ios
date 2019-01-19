//
//  BaseViewController.swift
//  Template
//
//  Created by Thongpak on 9/10/2560 BE.
//  Copyright © 2560 nextzy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import MBProgressHUD

open class BaseViewController: UIViewController {

    override open func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        addObserver()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    deinit {
        removeObserver()
    }
    
    open func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if let navigationController = self.navigationController {
            let loadingNotification = MBProgressHUD.showAdded(to: navigationController.view, animated: true)
            loadingNotification.mode = .indeterminate
        } else {
            let loadingNotification = MBProgressHUD.showAdded(to: view, animated: true)
            loadingNotification.mode = .indeterminate
        }
    }
    
    func setBackButton() {
         if navigationController?.viewControllers.count == 1 {
            setLeftBarButton(with: "Cancel")
         } else {
            let backButton = UIBarButtonItem()
            backButton.title = "Back"
            navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }
    }

    func setLeftBarButton(with title: String) {
        let button = BaseButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = BaseFontSize.Medium.getFont()
        button.tintColor = UIColor.black
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.gray, for: .highlighted)
        button.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
        
        let buttonItem = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = buttonItem
    }
    
    @objc func backButtonAction() {
        if let navBar = self.navigationController, navBar.viewControllers.first != self {
            navBar.popViewController(animated: true)
        } else {
            dismiss()
        }
    }
    
    open func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if let navigationController = self.navigationController {
            MBProgressHUD.hide(for: navigationController.view, animated: true)
        } else {
            MBProgressHUD.hide(for: view, animated: true)
        }
    }
    
    open func showPopup(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showError(error: BaseError) {
        hideLoading()
        showPopup(title: "", message: error.message)
    }

    func addObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveLanguageChangeNotification), name: NSNotification.Name(rawValue: LCLLanguageChangeNotification), object: nil)
    }
    
    @objc func didReceiveLanguageChangeNotification() {
        
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension BaseViewController: UIGestureRecognizerDelegate {
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

