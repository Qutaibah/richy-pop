//
//  WebView.swift
//  Richy
//
//  Created by Qutaibah Essa on 16/04/2020.
//  Copyright © 2020 Richy. All rights reserved.
//

import UIKit
import WebKit

class WebView: BaseView {
        
    private lazy var webView: WKWebView = {
        let web = WKWebView()
        web.layer.borderColor = Identity.color(.lightGray).cgColor
        web.clipsToBounds = true
        web.scrollView.showsVerticalScrollIndicator = false
        web.scrollView.showsHorizontalScrollIndicator = false
        web.scrollView.bounces = false
        web.translatesAutoresizingMaskIntoConstraints = false
        return web
    }()
    
    init(url: URL) {
        super.init(frame: .zero)
        let request = URLRequest(url: url)
        webView.load(request)
        contentHeight = UIScreen.main.bounds.size.height * 0.4
        contentView = webView
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
