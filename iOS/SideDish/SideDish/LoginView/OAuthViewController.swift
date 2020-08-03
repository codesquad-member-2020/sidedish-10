//
//  OAuthViewController.swift
//  SideDish
//
//  Created by 신한섭 on 2020/04/29.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit
import WebKit

class OAuthViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func loadView() {
        super.loadView()
        WKWebsiteDataStore.default().httpCookieStore.getAllCookies {
            for cookie in $0 {
                WKWebsiteDataStore.default().httpCookieStore.delete(cookie)
            }
        }
        webView.navigationDelegate = self
        self.view = self.webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let url = URL(string: "http://13.125.179.178:8080/login/github") else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

extension OAuthViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        WKWebsiteDataStore.default().httpCookieStore.getAllCookies {
            for cookie in $0 where cookie.name == "jwtToken" {
                NetworkManager.jwtToken = cookie.value
                self.dismiss(animated: true)
                NotificationCenter.default.post(name: .receiveCookie, object: nil)
            }
        }
    }
}

extension Notification.Name {
    static let receiveCookie = Notification.Name("receiveCookie")
}
