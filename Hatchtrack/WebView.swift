//
//  ViewController.swift
//  Blank App
//
//  Created by DBOI on 10/29/18.
//  Copyright © 2018 ios100. All rights reserved.
//

import UIKit
import WebKit

class WebView: UIViewController,WKNavigationDelegate {
    let screenSize = UIScreen.main.bounds.size
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = hatchtrackRed
        //self.title = ""
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let webView = WKWebView()
        webView.frame = CGRect(x: 0, y: 44.0, width: screenWidth, height: screenHeight-44.0)
        webView.navigationDelegate = self
        self.view.addSubview(webView)
        let defaults = UserDefaults.standard
        let url_string:String = defaults.string(forKey: "currentWebView")!
        print("url: ",url_string)
        if let url = URL(string: url_string) {
            print("requrest", url.absoluteString)
            let request = URLRequest(url: url)
            webView.load(request)
        }
        let viewtitle = defaults.string(forKey: "viewTitle")!
        
        let titleLabel = UILabel()
        titleLabel.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 44.0)
        titleLabel.textColor = .white
        titleLabel.text = viewtitle
        titleLabel.textAlignment = .center
        self.view.addSubview(titleLabel)
        
        let closeButton = UIButton()
        closeButton.frame = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        closeButton.setTitle("X", for: .normal)
        closeButton.addTarget(self, action: #selector(buttonTapper(_:)), for: .touchUpInside)
        self.view.addSubview(closeButton)
        
        loadingIndicator.alpha = 0.1
        setupUI()
        
        
        //let image = UIImage(systemName: "arrow.merge")
        //closeButton.setImage(image, for: .normal)
        /*
        let webView = UIWebView()
        let url: URL = URL(string:"https://google.com")!
        webView.loadRequest(URLRequest.init(url: url))

        webView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        self.view.addSubview(webView)
 */
    }

    private func setupUI() {
        self.view.addSubview(loadingIndicator)
        loadingIndicator.isAnimating = true
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor
                .constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor
                .constraint(equalTo: self.view.centerYAnchor),
            loadingIndicator.widthAnchor
                .constraint(equalToConstant: self.view.frame.size.width/3),
            loadingIndicator.heightAnchor
                .constraint(equalTo: self.loadingIndicator.widthAnchor)
        ])
        
    }
    
    // MARK: - Properties
    let loadingIndicator: ProgressView = {
        let hatchtrackRed = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 1.0)
        //let hatchtrackRed = UIColor(red: 101/255.0, green: 43/255.0, blue: 32/255.0, alpha: 1.0) //ORANGE
        let hatchtrackDarkBlue = UIColor(red: 64/255.0, green: 97/255.0, blue: 137/255.0, alpha: 1.0)
        let progress = ProgressView(colors: [hatchtrackRed,hatchtrackDarkBlue], lineWidth: 5)
        progress.isUserInteractionEnabled = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
    @objc func buttonTapper(_ sender:UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("Start loading")
        loadingIndicator.alpha = 1.0
        loadingIndicator.isAnimating = true
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("End loading")
        loadingIndicator.isAnimating = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

