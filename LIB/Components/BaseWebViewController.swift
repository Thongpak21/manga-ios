//
//  BaseWebViewController.swift
//  stock-ios
//
//  Created by Thongpak on 12/10/2561 BE.
//  Copyright © 2561 thongpak. All rights reserved.
//

import WebKit

class BaseWebViewController: BaseViewController, WKScriptMessageHandler {
    public static func openWebView(withUrl url: String, title: String, sender: UIViewController) {
        let webViewController = BaseWebViewController()
        webViewController.title = title
        webViewController.url = url
//        let navController = BaseNavigationViewController(rootViewController: webViewController)
        sender.pushViewController(webViewController)//(navController, animated: true)
    }
    var webView: WKWebView!
    var popupWebView : WKWebView?
    
    open var tintColor: UIColor?
    var url: String = ""
    var htmlString: String?
    fileprivate var progressView: UIProgressView?
    let estimatedProgressKeyPath = "estimatedProgress"
    var dismissCallbackURLScheme: (() -> Void)?
    
    let openDeviceBrowserMessageName = "openDeviceBrowser"
    
    var viewTitle: String = "" {
        didSet {
            navigationItem.title = viewTitle
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()

        setup()
        loadWebView()
        setupProgressView()
    }
    
    open override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //        rollbackState()
    }
    
    
    func setupProgressView() {
        progressView = UIProgressView(progressViewStyle: .default)
        progressView?.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        progressView?.tintColor = UIColor.blue
        navigationController?.navigationBar.addSubview(progressView!)
        if let navigationBarBounds = self.navigationController?.navigationBar.bounds {
            progressView?.frame = CGRect(x: 0, y: navigationBarBounds.size.height - 2, width: navigationBarBounds.size.width, height: 3)
        }
    }
    
    deinit {
        progressView?.removeFromSuperview()
    }
    
    func setup() {
        
        // color
    //    if let navController = self.navigationController {
//            navController.toolbar.tintColor = UIColor.green
//            navController.toolbar.barTintColor = UIColor.green
//            navController.navigationBar.barTintColor = UIColor.green
       // }
        
        // title
        navigationItem.title = viewTitle
        
        // navigation controller
        navigationController?.setNavigationBarHidden(false, animated: true)
        
        // back button
        //        setupBackButton()
        
        // title font
        if let navController = self.navigationController as? BaseNavigationViewController {
            navController.setNavBarFont()
        }
        let userContentController = WKUserContentController()
//        if let cookies = HTTPCookieStorage.shared.cookies {
//            let script = getJSCookiesString(for: cookies)
//            let cookieScript = WKUserScript(source: script, injectionTime: .atDocumentStart, forMainFrameOnly: false)
//            userContentController.addUserScript(cookieScript)
//        }
        userContentController.add(self, name: openDeviceBrowserMessageName)
        // setup web view
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.userContentController = userContentController
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        view.addSubview(webView)
        webView.addObserver(self, forKeyPath: estimatedProgressKeyPath, options: .new, context: nil)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change else { return }
        if keyPath == estimatedProgressKeyPath {
            if let progress = (change[NSKeyValueChangeKey.newKey] as AnyObject).floatValue {
                progressView?.progress = progress;
            }
            return
        }
    }
    
    open func loadWebView() {
        if let _url = URL(string: url) {
            let urlRequest = URLRequest(url: _url)
            webView.load(urlRequest)
        } else if let _ = htmlString {
            webView.loadHTMLString(htmlString!, baseURL: nil)
        }
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == openDeviceBrowserMessageName {
            if let data = message.body as? [String: Any], let urlString = data["url"] as? String {
                if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:]) { (_) in
                        //
                    }
                }
            }
        }
    }
}

extension BaseWebViewController: WKUIDelegate {
//    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
//        if popupWebView == nil {
//            popupWebView = WKWebView(frame: view.bounds, configuration: configuration)
//            popupWebView!.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            popupWebView!.navigationDelegate = self
//            popupWebView!.uiDelegate = self
//            view.addSubview(popupWebView!)
//        }
//        return popupWebView!
//    }
//
//    func webViewDidClose(_ webView: WKWebView) {
//        if webView == popupWebView {
//            popupWebView?.removeFromSuperview()
//            popupWebView = nil
//        } else {
//            dismissWebView()
//        }
//    }
}

extension BaseWebViewController: WKNavigationDelegate {
    open func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        progressView?.isHidden = false
    }
    
    open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
//        let url = navigationAction.request.url?.absoluteString ?? ""
        
        decisionHandler(.allow)
    }
    
    func dismissWebView() {
        dismiss(animated: true) { [weak self] in
            guard let weakSelf = self else { return }
            weakSelf.dismissCallbackURLScheme?()
        }
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let serverTrust = challenge.protectionSpace.serverTrust {
            let cred = URLCredential(trust: serverTrust)
            completionHandler(.useCredential, cred)
        } else {
            completionHandler(.useCredential, nil)
        }
    }
    
    open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView?.isHidden = true
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        if self.viewTitle.isEmpty {
            webView.evaluateJavaScript("document.title") { (result, error) in
                if result != nil {
                    self.viewTitle = (result as? String) ?? ""
                }
            }
        }
    }
}
