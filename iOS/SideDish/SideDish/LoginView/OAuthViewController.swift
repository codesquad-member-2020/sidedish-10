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
        let url = URL(string: "http://13.125.179.178:8080/login/github")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
}

extension OAuthViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(.allow)
        WKWebsiteDataStore.default().httpCookieStore.getAllCookies {
            for cookie in $0 {
                if cookie.name == "jwtToken" {
                    NetworkManager.jwtToken = cookie.value
                    self.dismiss(animated: true)
                    NotificationCenter.default.post(name: .receiveCookie, object: nil)
                }
            }
        }
    }
}

extension WKWebView {
    
    private var httpCookieStore: WKHTTPCookieStore  { return WKWebsiteDataStore.default().httpCookieStore }
    
    func getCookies(for domain: String? = nil, completion: @escaping ([String : Any])->())  {
        var cookieDict = [String : AnyObject]()
        httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if let domain = domain {
                    if cookie.domain.contains(domain) {
                        cookieDict[cookie.name] = cookie.properties as AnyObject?
                    }
                } else {
                    cookieDict[cookie.name] = cookie.properties as AnyObject?
                }
            }
            completion(cookieDict)
        }
    }
}

extension Notification.Name {
    static let receiveCookie = Notification.Name("receiveCookie")
}
