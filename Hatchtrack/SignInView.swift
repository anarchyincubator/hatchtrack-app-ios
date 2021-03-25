//
//  ViewController.swift
//  Blank App
//
//  Created by DBOI on 10/29/18.
//  Copyright © 2018 ios100. All rights reserved.
//

import UIKit

class SignInView: UIViewController, UITextFieldDelegate {

    let scrollView:UIScrollView = UIScrollView()
    let screenSize = UIScreen.main.bounds.size
    var statusBarHeight:CGFloat = 0
    var topBarHeight:CGFloat = 0.0
    
    let textFieldEmail: UITextField = UITextField()
    let textFieldPassword: UITextField = UITextField()
    
    let buttonResetPass: UIButton = UIButton()
    let buttonSignUp: UIButton = UIButton()
    let buttonLogin: UIButton = UIButton()
    
    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.setHidesBackButton(true, animated: false)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // -----------------------------------------------------------
        // NAVIGATION BAR CUSTOMIZATION
        // -----------------------------------------------------------
        //self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false

        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundColor = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 1.0)
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance

        } else {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 64/255.0, green: 97/255.0, blue: 137/255.0, alpha: 1.0) //Nav Blue
            self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        }

        // -----------------------------------------------------------
        // NAVIGATION BAR SHADOW
        // -----------------------------------------------------------
        self.navigationController?.navigationBar.layer.masksToBounds = false
        //self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.clear.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        //self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.navigationController?.navigationBar.layer.shadowRadius = 0
        //self.navigationController?.navigationBar.layer.shadowOpacity = 0.4
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.0
        
        let button = UIBarButtonItem(title: "Sign Up", style: .plain, target: self, action: #selector(SignUpButtonTapped))

        navigationItem.rightBarButtonItem = button
        
        //#selector(self.buttonTapped)
        
        view.backgroundColor = UIColor(red: 240/255.0, green: 246/255.0, blue: 250/255.0, alpha: 1.0) 
        self.title = "" //Navigation controller title
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        topBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0))
        
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        scrollView.isUserInteractionEnabled = false
        scrollView.alpha = 0.0
        self.view.addSubview(scrollView)
        
        let logo:UIImageView = UIImageView()
        logo.frame = CGRect(x: 0, y: 30, width: screenWidth, height: screenHeight/4)
        logo.image = #imageLiteral(resourceName: "LaunchLogo")
        logo.contentMode = .scaleAspectFit
        scrollView.addSubview(logo)
        
        let yPadding:CGFloat = 15.0
        let xPadding:CGFloat = yPadding*2
        let inputHeight:CGFloat = 45.0
        let inputWidth = screenWidth-inputHeight-yPadding
        
        var textInputPaddingView = UIView()
        
        textInputPaddingView = UIView(frame: CGRect(x:0, y:0, width:15, height:inputHeight))
        textFieldEmail.frame = CGRect(x: xPadding, y: screenHeight/4+inputHeight+yPadding, width: inputWidth, height: inputHeight)
        textFieldEmail.delegate = self
        textFieldEmail.clearButtonMode = .whileEditing
        textFieldEmail.backgroundColor = .white
        textFieldEmail.layer.cornerRadius = 4.0
        textFieldEmail.layer.borderWidth = 1.0
        textFieldEmail.leftView = textInputPaddingView
        textFieldEmail.leftViewMode = .always
        
        textFieldEmail.layer.borderColor = UIColor.lightGray.cgColor
        textFieldEmail.placeholder = "Email"
        textFieldEmail.autocapitalizationType = .none
        scrollView.addSubview(textFieldEmail)
        
        textInputPaddingView = UIView(frame: CGRect(x:0, y:0, width:15, height:inputHeight))
        textFieldPassword.frame = CGRect(x: xPadding, y: textFieldEmail.frame.origin.y+inputHeight+yPadding, width: inputWidth, height: inputHeight)
        textFieldPassword.delegate = self
        textFieldPassword.backgroundColor = .white
        textFieldPassword.layer.cornerRadius = 4.0
        textFieldPassword.layer.borderWidth = 1.0
        textFieldPassword.isSecureTextEntry = true
        textFieldPassword.leftView = textInputPaddingView
        textFieldPassword.leftViewMode = .always
        textFieldPassword.rightView = textInputPaddingView
        textFieldPassword.rightViewMode = .always
        textFieldPassword.layer.borderColor = UIColor.lightGray.cgColor
        textFieldPassword.placeholder = "Password"
        textFieldPassword.tag = 200
        scrollView.addSubview(textFieldPassword)
        
        let defaults = UserDefaults.standard
        //let accessToken:String = defaults.string(forKey: "accessToken")!
        
      
        
        textFieldEmail.text = defaults.string(forKey: "email")
        textFieldPassword.text = defaults.string(forKey: "password")
        print("textFieldEmail,password: ",defaults.string(forKey: "email"),defaults.string(forKey: "password"))
        
        let hatchtrackRed = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 1.0)
        buttonLogin.frame = CGRect(x: xPadding, y: textFieldPassword.frame.origin.y+inputHeight+yPadding, width: inputWidth, height: inputHeight)
        buttonLogin.backgroundColor = hatchtrackRed
        buttonLogin.layer.cornerRadius = inputHeight/2
        buttonLogin.setTitle("Sign in", for: .normal)
        buttonLogin.addTarget(self, action: #selector(SignInView.selected(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonLogin)
        
        buttonResetPass.frame = CGRect(x: xPadding, y: buttonLogin.frame.origin.y+80, width: inputWidth, height: inputHeight)
        buttonResetPass.backgroundColor = .clear
        buttonResetPass.layer.cornerRadius = inputHeight/2
        buttonResetPass.setTitle("Reset password", for: .normal)
        buttonResetPass.setTitleColor(hatchtrackRed, for: .normal)
        buttonResetPass.addTarget(self, action: #selector(ResetPasswordButtonTapped(_:)), for: .touchUpInside)
        buttonResetPass.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        scrollView.addSubview(buttonResetPass)
        
        self.setupUI()
        
       // var accessTokenObject: AnyObject? = defaults.object(forKey: "accessToken") as AnyObject
        var accessToken:String? =  defaults.object(forKey: "accessToken") as? String
        if(accessToken == nil){
            accessToken = "";
        }
        if (accessToken != "" ){
            //let accessToken:String = String(accessTokenObject)
            //if(accessToken.characters.count>0){
            self.initLogin()
            
        }else{
            self.showLogin()
        }
    }
    
    func textFieldShouldClear(textField: UITextField) -> Bool {
        if textField == textFieldEmail {
            print("field 1")
        } else {
            print("field 2")
        }
        return true
    }
    
    func showLogin(){
        loadingIndicator.isAnimating = false
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: { self.scrollView.alpha = 1.0 }, completion: {_ in self.scrollView.isUserInteractionEnabled = true})
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
        if(textField.tag == 200){
            initLogin()
        }
       return true
    }
    
    // Reset
    @objc func ResetPasswordButtonTapped(_ sender:UIButton){
        
        NSLog("ResetPasswordpButtonTapped")
        let defaults = UserDefaults.standard
        defaults.set("Reset Password", forKey: "viewTitle")
        defaults.set("https://hatchtrack.auth.us-west-2.amazoncognito.com/forgotPassword?response_type=token&client_id=34uo31crc6dbm4i11sgaqv03lb&redirect_uri=hatchtrack.sensor://main", forKey: "currentWebView")
        defaults.synchronize()
        
        if let navigationController = appDelegate.window?.rootViewController as? UINavigationController{
            navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            navigationController.present(WebView(), animated: true, completion: nil)
        }
    }
    
    // Sign Up
    @objc func SignUpButtonTapped(_ sender:UIButton) {
        //loadingIndicator.isAnimating = true
        
        NSLog("SignUpButtonTapped")
        let defaults = UserDefaults.standard
        defaults.set("Sign Up", forKey: "viewTitle")
        defaults.set("https://hatchtrack.auth.us-west-2.amazoncognito.com/signup?response_type=token&client_id=34uo31crc6dbm4i11sgaqv03lb&redirect_uri=hatchtrack.sensor://main", forKey: "currentWebView")
        defaults.synchronize()
        
        if let navigationController = appDelegate.window?.rootViewController as? UINavigationController{
            navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            navigationController.present(WebView(), animated: true, completion: nil)
        }
        //getAPICalling(mainUrl:"https://s49404.gridserver.com/hatchtrack/api_placeholder.php?mode=auth",type:"auth")
        
    }
    
    func initLogin(){
        loadingIndicator.isAnimating = true
        let defaults = UserDefaults.standard
        var accessToken:String? =  defaults.object(forKey: "accessToken") as? String
        if(accessToken == nil){
            accessToken = "";
        }
        let tokenTimestamp = defaults.double(forKey: "tokenTimestamp")
        print("initLogin - accessToken: ",accessToken)
        print("initLogin - tokenTimestamp: ",tokenTimestamp)
        let data:[String:String] = [
            "email": String(textFieldEmail.text!),
            "password": String(textFieldPassword.text!)
        ]
        defaults.set("", forKey:"currentHatchUUID")
        defaults.set(self.textFieldEmail.text, forKey: "email")
        defaults.set(self.textFieldPassword.text, forKey: "password")
        defaults.synchronize()
        if(accessToken! == "" || NSDate().timeIntervalSince1970-86400>tokenTimestamp){
            print("initLogin - getAPICalling() - /auth")
            if(!self.textFieldEmail.text!.isEmpty && !self.textFieldPassword.text!.isEmpty){
                
                getAPICalling(mainUrl:"/auth",type:"auth", tokenString: "", data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
            }
        }else{
            print("initLogin - gotoHatches()")
            //getAPICalling
            //self.updateFCM()
            gotoHatches()
            
        }
    }
    
    @objc func selected(_ sender: AnyObject) {
        
        
        NSLog("SignInButtonTapped")
        initLogin()
        
    }
    
  
    
    @objc func gotoHatches(){
        print("gotoHatches")
        let hatchesListView = ListViewHatches()
        self.navigationController?.pushViewController(hatchesListView, animated: true)
    }
    
    private func updateFCM(){
        let defaults = UserDefaults.standard
        let date = Date()
        let timezone = Double(TimeZone.current.secondsFromGMT(for: date))
        let data:[String:String] = [
            "push_notif_token": String(defaults.string(forKey: "fcmToken")!),
            "platform": "ios",
            "email":  String(defaults.string(forKey: "email")!),
            "timezone":  String(timezone)
        ]
        self.getAPICalling(mainUrl:"/api/v1/user/notification_token_platform",type:"update_fcm_and_token", tokenString: String(defaults.string(forKey: "accessToken")!), data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
    }
    
    private func setupUI() {
              
        
        //loadingIndicator.center = CGPoint(x:self.view.center.x, y:self.view.center.y - topBarHeight/2)
        self.view.addSubview(loadingIndicator)

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
        //loadingIndicator.isAnimating = true
    }
    
    func convertToDictionary(text: String) -> Any? {

         if let data = text.data(using: .utf8) {
             do {
                 return try JSONSerialization.jsonObject(with: data, options: []) as? Any
             } catch {
                 print(error.localizedDescription)
             }
         }

         return nil

    }
    
    func getAPICalling(mainUrl:String,type:String,tokenString:String,data:Dictionary<String,String>,hostUrl:String,portUrl:Int) {
        print("getAPICalling ",mainUrl)
        
        print("data ",data)
        print("hostUrl ",hostUrl)
        print("portUrl ",portUrl)
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = hostUrl
        components.path = mainUrl
        components.port = portUrl

        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "/", with: "%2F")
        
        print("components.url! :",components.url!)
        //urlRequest = URLRequest(url:components.url!)
        
        var urlRequest = URLRequest(url: (components.url)!)
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.httpMethod = "POST"
        
        
        //urlRequest.httpBody = parameters.percentEncoded()
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) // pass dictionary to data object and set it as request body
            } catch let error {
                print(error.localizedDescription)
                //completion(nil, error)
            }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data,
                    let response = response as? HTTPURLResponse,
                    error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
                }

                guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                    print("statusCode should be 2xx, but is \(response.statusCode)")
                    let defaults = UserDefaults.standard
                    defaults.set("", forKey: "accessToken")
                    defaults.set(NSDate().timeIntervalSince1970-86400, forKey: "tokenTimestamp")
                    defaults.synchronize()
                    self.showLogin()
                    print("response = \(response)")
                    return
                }

                let responseString = String(data: data, encoding: .utf8)
                print(type+" API responseString = \(responseString)")
           

            //JSON Response
            switch type {
            case "auth":
                print("Auth")
                do {
                  guard let object = try JSONSerialization.jsonObject(with: data, options: [])
                    as? [String: Any] else {
                      return
                  }
                    guard let accessToken = object["accessToken"] as? String else {
                      print("Could not get accessToken from JSON")
                      return
                    }
                    let defaults = UserDefaults.standard
                    defaults.set(accessToken, forKey: "accessToken")
                    defaults.set(NSDate().timeIntervalSince1970, forKey: "tokenTimestamp")
                    defaults.synchronize()
                    print("accessToken: ",accessToken)
                    
                    print("SignInView - [Login] - getAPICalling->Auth->Access Token Successful");
                    
                    DispatchQueue.main.async {
                        self.loadingIndicator.isAnimating = false
                        self.gotoHatches()
                        //self.updateFCM()
                    }
                    
                   // self.getAPICalling(mainUrl:"https://s49404.gridserver.com/hatchtrack/api_placeholder.php?mode=timeline&accessToken="+accessToken,type:"timeline")
                } catch  {
                  print("error trying to convert data to JSON")
                  return
                }
                
            case "update_fcm_and_token":
                self.gotoHatches()
            

            default:
                print("N/A")
            }
            
        }
        task.resume()
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}


