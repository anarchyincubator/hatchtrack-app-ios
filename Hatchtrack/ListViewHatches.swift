import UIKit
//import "HatchDetailHeader.swift"


class ListViewHatches: UIViewController, UITableViewDelegate, UITableViewDataSource, RemoteDelegate{

    let screenSize = UIScreen.main.bounds.size
    var statusBarHeight:CGFloat = 0
    var topBarHeight:CGFloat = 0.0
    
    var hatchsArray = [[String:Any]]()
    var menuView:UITableViewController = MenuView()
    var menuDrawerTable = UITableView()
    var hatchesTableView = UITableView()
    var dimView = UIView()
    var addHatchButton = UIButton()
    let menuOffsetX: CGFloat = ((UIScreen.main.bounds.size.width/2)/3)
    let menuSize = UIScreen.main.bounds.size.width*0.7
    
    var list:Array<HatchItem> = []
    
   
    
    // left only 2 fields for demo
      struct HatchItem {
        var uuid:String = ""
        var peep_uuid:String = ""
        var species_uuid:String = ""
        var hatch_name:String = ""
        var start_unix_timestamp:Double = 0
        var end_unix_timestamp:Double = 0
        var egg_count:Int = 0
        var hatched_count:Int = 0
        var notes:String = ""
        
     }
    
    var size_completed:CGFloat = 20.0
    var size_daycount:CGFloat = 26.0
    var size_hatchname:CGFloat = 20.0
    var size_species:CGFloat = 26.0
    var size_eggs:CGFloat = 16.0
    
    override func viewDidAppear(_ animated: Bool) {
        showNewButton()
        let defaults = UserDefaults.standard
        defaults.set("", forKey:"currentHatchUUID")
        defaults.synchronize()
    }
    override func viewWillDisappear(_ animated: Bool) {
        hideNewButton()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(red: 240/255.0, green: 246/255.0, blue: 250/255.0, alpha: 1.0) //Light Blue
        //self.title = "Hatches" //Navigation controller title
        
        let logo = #imageLiteral(resourceName: "LogoText")
        let imageView = UIImageView(image:logo)
        //imageView.frame.size = CGSize(width: Int(screenSize.width/3), height: Int(44))
        self.navigationItem.titleView = imageView
        
        navigationItem.backButtonTitle = ""
        UIApplication.shared.isStatusBarHidden = false
        
        let screenWidth = UIScreen.main.bounds.width
                
        if(screenWidth >= CGFloat(320.0)){
            //compeled = 20, daycount = 26, hatchname = 20, species = 16
            size_completed = 18.0
            size_daycount = 14.0
            size_hatchname = 18.0
            size_species = 16.0
            size_eggs = 14.0
        }
        
        if(screenWidth >= CGFloat(375.0)){
            //compeled = 20, daycount = 26, hatchname = 20, species = 16
            size_completed = 20.0
            size_daycount = 22.0
            size_hatchname = 20.0
            size_species = 22.0
            size_eggs = 16.0
        }
        
        if(screenWidth >= CGFloat(414.0)){
            //compeled = 20, daycount = 26, hatchname = 20, species = 16
            size_completed = 20.0
            size_daycount = 26.0
            size_hatchname = 20.0
            size_species = 26.0
            size_eggs = 16.0
        }
        
        let screenHeight = UIScreen.main.bounds.height
        statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        topBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0))
        
        
        /*
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
            //UIColor(red: 64/255.0, green: 97/255.0, blue: 137/255.0, alpha: 1.0) //Nav Blue
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
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.black.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.4
        */
        let button = UIBarButtonItem(image: #imageLiteral(resourceName: "NavMenuIcon").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(self.buttonTapped))
        navigationItem.leftBarButtonItem = button

        
        hatchesTableView.register(TableCellListView.self, forCellReuseIdentifier: "cell")
        hatchesTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-topBarHeight);
        hatchesTableView.backgroundColor = UIColor.clear
        hatchesTableView.delegate = self
        hatchesTableView.dataSource = self
        hatchesTableView.allowsSelection = true
        hatchesTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        hatchesTableView.tag = 1000

        //let insets =
        hatchesTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        
        self.view.addSubview(hatchesTableView);
        
        dimView.frame = self.view.frame
        //dimView.backgroundColor = .black
        //dimView.backgroundColor = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 0.9)
        dimView.backgroundColor = .clear
        dimView.alpha = 0.0
        dimView.isUserInteractionEnabled = false
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        dimView.addGestureRecognizer(tap)
        self.view.addSubview(dimView)
                
        menuDrawerTable.frame = CGRect(x: 0-menuSize, y: statusBarHeight, width: menuSize, height: screenHeight)
        menuDrawerTable.tag = 2000
        menuDrawerTable.separatorStyle = UITableViewCell.SeparatorStyle.none
        menuDrawerTable.backgroundColor = UIColor(red: 209/255.0, green: 230/255.0, blue: 242/255.0, alpha: 1.0) //Light Blue
        menuDrawerTable.isScrollEnabled = true
        menuDrawerTable.delegate = menuView
        menuDrawerTable.dataSource = menuView
        menuDrawerTable.register(MenuDrawerViewTableCell.self, forCellReuseIdentifier: "MenuDrawerViewTableCell")
        
        let currentWindow: UIWindow? = UIApplication.shared.keyWindow
        currentWindow?.addSubview(menuDrawerTable)
        //self.view.addSubview(menuDrawerTable)
        
        let hatchButtonSize:CGFloat = 72.0
        addHatchButton = UIButton()
        addHatchButton.frame = CGRect(x: screenWidth - hatchButtonSize - 16, y: screenHeight - hatchButtonSize - 16, width: hatchButtonSize, height: hatchButtonSize)
        addHatchButton.layer.cornerRadius = CGFloat(hatchButtonSize/2)
        addHatchButton.backgroundColor = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 1.0)
        let spacing: CGFloat = 7.0
        addHatchButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: spacing, bottom: spacing, right: spacing)
        addHatchButton.titleLabel?.font = UIFont.systemFont(ofSize: 43)
        addHatchButton.setTitle("+", for: .normal)
        //UIColor(red: 109/255.0, green: 39/255.0, blue: 28/255.0, alpha: 1.0)
        addHatchButton.setTitleColor(.white, for: .normal)
        addHatchButton.addTarget(self, action: #selector(pressed(_ :)), for: .touchUpInside)

        currentWindow?.addSubview(addHatchButton)
        
        let pan = UIPanGestureRecognizer.init(target: self, action: #selector(handlePan(_:)))
        menuDrawerTable.addGestureRecognizer(pan)
        
        let defaults = UserDefaults.standard
        
        let email = defaults.string(forKey: "email")
        let date = Date()
        let timezone = Double(TimeZone.current.secondsFromGMT(for: date))
        let timezone_token = timezone/3600
        //var tokenData:[String:Any] = ["push_notif_token":"","platform":"ios","email":email,"timezone":Int(timezone_token)]
        let fcmToken = defaults.string(forKey: "fcmToken")!
        if !fcmToken.isEmpty{
           // tokenData = ["push_notif_token":fcmToken,"platform":"ios","email":email,"timezone":timezone_token]
        }
        //print("tokenData: ",tokenData)
        
        let accessToken = defaults.string(forKey: "accessToken")
        let tokenTimestamp = defaults.double(forKey: "tokenTimestamp")
        
        print("accessToken: ",accessToken)
        print("tokenTimestamp: ",tokenTimestamp)
        if(accessToken == nil || NSDate().timeIntervalSince1970-86400>tokenTimestamp){
            //getAPICalling(mainUrl:"https://s49404.gridserver.com/hatchtrack/api_placeholder.php?mode=auth",type:"auth",tokenString:"")
            
        }else{
            let data:[String:String] = [
                "email": String(email!)
            ]
            
            self.reload_hatch_list()
//            self.getAPICalling(mainUrl:"/api/v1/peep/hatches_all_data_email",type:"hatches", tokenString: accessToken!, data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
            
            //getAPICalling(mainUrl:"https://db.hatchtrack.com:18888/api/v1/peep/hatches_all_data_email?email="+email!,type:"hatches",tokenString:accessToken!)
            //RestApi(urlString:"https://s49404.gridserver.com/hatchtrack/api_placeholder.php?mode=all_hatches&accessToken="+accessToken!)
        }
        
        
        //self.getAPICalling(mainUrl:"/api/v1/user/notification_token_platform",type:"update_fcm_and_token", tokenString: String(accessToken!), data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
        
        self.setupUI()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateFCM), name: NSNotification.Name(rawValue: "update_fcm"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload_hatch_list), name: NSNotification.Name(rawValue: "reload_hatch_list"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationCloseMenu), name: NSNotification.Name(rawValue: "dismissMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(loading_true), name: NSNotification.Name(rawValue: "loading_true"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loading_false), name: NSNotification.Name(rawValue: "loading_false"), object: nil)

        
        
        
        //END init
    }
    
    @objc private func updateFCM(){
        print("updateFCM")
        let defaults = UserDefaults.standard
        let date = Date()
        let timezone = Double(TimeZone.current.secondsFromGMT(for: date))
        let timezone_token = timezone/3600
        let data:[String:Any] = [
            "push_notif_token": String(defaults.string(forKey: "fcmToken")!),
            "platform": "ios",
            "email":  String(defaults.string(forKey: "email")!),
            "timezone":  Int(timezone_token)
        ]
        self.getAPICalling(mainUrl:"/api/v1/user/notification_token_platform",type:"update_fcm_and_token", tokenString: String(defaults.string(forKey: "accessToken")!), data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
    }
    
    func RestApi(mainUrl:String,type:String,tokenString:String){
        //let urlString = "http://heyhttp.org/me.json"
        var request = URLRequest(url: URL(string: mainUrl)!)
        request.addValue(tokenString, forHTTPHeaderField: "Access-Token")
        
        print("request: ",request)
        let session = URLSession.shared

        session.dataTask(with: request) {data, response, error in
          if error != nil {
            print(error!.localizedDescription)
            return
          }
            print("[RestApi] - DATA: ",String(data: data!, encoding: .utf8))
          do {
            let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? Any
            print("Synchronous\(jsonResult)")
            
           // let key = (jsonResult! as AnyObject).object("hatches_all_data_email") as! Any
            //print("key: ",key)
          } catch {
            print(error.localizedDescription)
          }
        }.resume()
    }
    
    @objc func pressed(_ sender: UIButton) {
        //hideNewButton()
        print("buttonAction")
        let newView = HatchConfigReconfig()
        
        // Modal - Slide up (Useage: WebView)
        self.navigationController!.modalPresentationStyle = UIModalPresentationStyle.formSheet
        print("newView width", newView.view.frame.size.width)
        self.navigationController!.present(newView, animated: true, completion: nil)
        
        //navigate(vc:newView,a:true,t:"New Hatch")
    }
    
    // MARK: - Properties
    let loadingIndicator: ProgressView = {
        
        let progress = ProgressView(colors: [hatchtrackRed,hatchtrackDarkBlue], lineWidth: 5)
        progress.isUserInteractionEnabled = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    
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
        // loadingIndicator.isAnimating = true
    }
    
    @objc func reload_hatch_list(){
//        let defaults = UserDefaults.standard
//        let accessToken = defaults.string(forKey: "accessToken")
//        let email = defaults.string(forKey: "email")
//        //getAPICalling(mainUrl:"https://db.hatchtrack.com:18888/api/v1/peep/hatches_all_data_email?email="+email!,type:"hatches",tokenString:accessToken!)
//
//        let data:[String:String] = [
//            "email":  String(email!)
//        ]
//        self.getAPICalling(mainUrl:"/api/v1/peep/hatches_all_data_email",type:"hatches", tokenString: accessToken!, data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
        let list = Utility.getHatchData()
        self.hatchsArray = list
        //print(self.hatchsArray)
        DispatchQueue.main.async {
            self.loadingIndicator.isAnimating = false
            self.hatchesTableView.reloadData()
        }
        
    }
    
    @objc func loading_true(){
        // loadingIndicator.isAnimating = true
    }
    @objc func loading_false(){
        loadingIndicator.isAnimating = false
    }
    
    
    @objc func handleTap(_ recognizer: UIPanGestureRecognizer) {
        closeMenu()
    }
    
    @objc func notificationCloseMenu(){
        closeMenu()
    }
    
    @objc func handlePan(_ recognizer: UIPanGestureRecognizer) {
      let gestureIsDraggingFromLeftToRight = (recognizer.velocity(in: view).x > 0)
        print("gestureIsDraggingFromLeftToRight: ",gestureIsDraggingFromLeftToRight)
        switch recognizer.state {
        case .began:
            print("began_pan")
            if(gestureIsDraggingFromLeftToRight){
                recognizer.state = UIGestureRecognizerState.ended
            }
            
        case .changed:
          if let rview = recognizer.view {
            rview.center.x = rview.center.x + recognizer.translation(in: view).x
            var extraDim = rview.center.x/1000;
            //rview.center.y = rview.center.y + (0-rview.center.x)
            recognizer.setTranslation(CGPoint.zero, in: view)
           
            if(rview.center.x>=menuOffsetX){
                self.dimView.alpha = 0.6+extraDim
            }
            if(rview.center.x>=self.menuSize/2){
                recognizer.state = UIGestureRecognizerState.ended
                //openMenu()
                //return
            }
          }
          
        case .ended:
            print("ended_pan")
            //let rview = recognizer.view
            print("recognizer.view!.center.x: ",recognizer.view!.center.x," - menuOffsetX: ",menuOffsetX)
            if(gestureIsDraggingFromLeftToRight && recognizer.view!.center.x>=menuOffsetX){
                openMenu()
            }else{
                closeMenu()
            }
            
          
        default:
          break
        }
    }
    
    func hideNewButton(){
        print("hideNewButton")
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.addHatchButton.alpha = 0.0
                       }, completion: {_ in self.addHatchButton.isUserInteractionEnabled = false})
    }
    func showNewButton(){
        
        if self.viewIfLoaded?.window != nil {
            // viewController is visible
      
        
        print("showNewButton")
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.addHatchButton.alpha = 1.0
                       }, completion: {_ in self.addHatchButton.isUserInteractionEnabled = true})
        }
    }
    
    func closeMenu(){
        print("closeMenu")
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.menuDrawerTable.center = CGPoint(x: 0-(self.menuSize/2), y: self.menuDrawerTable.center.y)
                        self.dimView.alpha = 0.0
                       }, completion: {_ in self.dimView.isUserInteractionEnabled = false;self.showNewButton()})
    }
    
    func openMenu(){
        print("openeMenu")
        self.hideNewButton()
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.menuDrawerTable.center = CGPoint(x: self.menuSize/2, y: self.menuDrawerTable.center.y)
                        self.dimView.alpha = 0.6
                       }, completion: {_ in self.dimView.isUserInteractionEnabled = true})
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        print("animateCenterPanelXPosition: ",targetPosition)
      UIView.animate(withDuration: 0.5,
                     delay: 0,
                     usingSpringWithDamping: 0.8,
                     initialSpringVelocity: 0,
                     options: .curveEaseInOut, animations: {
                       self.view.frame.origin.x = targetPosition
      }, completion: completion)
    }
    
    // On opening
    @objc func buttonTapped() {
        
        NSLog("buttonTapped")
        if(self.menuDrawerTable.frame.origin.x != 0){
            NSLog("openMenu")
            openMenu()
        }else{
            NSLog("closeMenu")
            closeMenu()
        }
    }
    
    

    @objc func handlerMenuToggle(){
        NSLog("handlerMenuToggle")
    }
    
    /* TABLE */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
         NSLog("sections")
         return 2
     }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            let cell = tableView.cellForRow(at: indexPath) as! TableCellListView
            deleteHatch(uuid:cell.hatchUUID)
            //self.hatchsArray[indexPath.row]
        }
    }
    
    func deleteHatch(uuid:String){
//        let defaults = UserDefaults.standard
//        let accessToken:String = defaults.string(forKey: "accessToken")!
//        let data:[String:Any] = ["hatchUUID":uuid,"accessToken":accessToken]
//        print("data",data)
//        self.getAPICalling(mainUrl:"/api/v1/hatch/delete",type:"deleteHatch", tokenString: accessToken, data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
        Utility.deleteHatchByUUID(uuid)
        self.reload_hatch_list()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("self.hatchsArray.count ",self.hatchsArray.count)
           return self.hatchsArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCellListView
        cell.selectionStyle = .none
        var hatchName = ""
//        if ((self.hatchsArray[indexPath.row]["hatch_name"] as? String) != nil){
//            hatchName = self.hatchsArray[indexPath.row]["hatch_name"] as! String
//        }else{
//            hatchName = "HATCH"
//        }
        if ((self.hatchsArray[indexPath.row]["hatchName"] as? String) != nil){
            hatchName = self.hatchsArray[indexPath.row]["hatchName"] as! String
        }else{
            hatchName = "HATCH"
        }
        
        var species = ""
//        if ((self.hatchsArray[indexPath.row]["species_uuid"] as? String) != nil){
//            species = self.hatchsArray[indexPath.row]["species_uuid"] as! String
//        }else{
//            species = "HATCH"
//        }
        
        if ((self.hatchsArray[indexPath.row]["speciesUUID"] as? String) != nil){
            species = self.hatchsArray[indexPath.row]["speciesUUID"] as! String
        }else{
            species = "HATCH"
        }
       
        
        
        //print("hatchsarray",self.hatchsArray[indexPath.row])
       
        var startUnixTimestamp_string:String = ""
//        if ((self.hatchsArray[indexPath.row]["start_unix_timestamp"] as? String) != nil){
//            startUnixTimestamp_string = self.hatchsArray[indexPath.row]["start_unix_timestamp"] as! String
//        }else{
//            startUnixTimestamp_string = "3"
//        }
        
        if ((self.hatchsArray[indexPath.row]["start_unix_timestamp"] as? String) != nil){
            startUnixTimestamp_string = self.hatchsArray[indexPath.row]["start_unix_timestamp"] as! String
        }else{
            startUnixTimestamp_string = "3"
        }
        
        let startUnixTimestamp = Double(startUnixTimestamp_string)
        
       // var startUnixTimestamp:TimeInterval = 0
        /*
        if ((self.hatchsArray[indexPath.row]["start_unix_timestamp"] as? TimeInterval) != nil){
            print("start_unix_timestamp: ",self.hatchsArray[indexPath.row]["start_unix_timestamp"])
            startUnixTimestamp = Double(self.hatchsArray[indexPath.row]["start_unix_timestamp"] as! TimeInterval)
        }else{
            startUnixTimestamp = 4
        } */
        
        
        
        
        //print("ListView - Int - start_timestamp: ",self.hatchsArray[indexPath.row]["start_unix_timestamp"])
        
        //print("startUnixTimestamp: ",startUnixTimestamp)
        let days:Int = Int(NSDate().timeIntervalSince1970-Double(startUnixTimestamp!))/86400
        let diff:CGFloat = CGFloat(NSDate().timeIntervalSince1970)-CGFloat(startUnixTimestamp!)
        //print("Timestamp: ",CGFloat(NSDate().timeIntervalSince1970))
        //print(" - ",days)
        //print(" diff: ",diff/86400)
        
        let today_timestamp:Double = NSDate().timeIntervalSince1970
        //print("today_timestamp: ",today_timestamp)
        //print("startUnixTimestamp: ",startUnixTimestamp)
        //print("diff: ",(today_timestamp - start_timestamp))
        
        var totalDays = 0
        let currDay:Int = Int((today_timestamp - Double(startUnixTimestamp!))/86400)
        //print(" - ",currDay)
        
        
        var egg_count = 0
//        if ((self.hatchsArray[indexPath.row]["egg_count"] as? Int) != nil){
//            egg_count = self.hatchsArray[indexPath.row]["egg_count"] as! Int
//        }else{
//            egg_count = 0
//        }
        
        if ((self.hatchsArray[indexPath.row]["eggCount"] as? Int) != nil){
            egg_count = self.hatchsArray[indexPath.row]["eggCount"] as! Int
        }else{
            egg_count = 0
        }
        
        var speciesName = ""
        
        var speciesIconString:String = "species_chicken"
        
        if(species == "90df88e3-5ed5-4a1f-a689-97dfc097ebf7"){
            totalDays = 21; //Chicken
            speciesName = "Chicken";
            speciesIconString = "species_chicken"
        }else if(species == "7d2051f5-6346-4d6b-ba9a-1f958a7d3db5"){
            totalDays = 35; //Mascovey Duck
            speciesName = "Mascovey Duck";
            speciesIconString = "species_muscovy"
        }else if(species == "c0999080-7749-4c9b-ada1-947ec383a845"){
            totalDays = 28; //Duck
            speciesName = "Duck";
            speciesIconString = "species_duck"
        }else if(species == "7ff48b3f-ee67-4668-a25d-dd9910fe0382"){
            totalDays = 17; //Quail
            speciesName = "Quail";
            speciesIconString = "species_quail"
        }else if(species == "ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b"){
            totalDays = 30; //Goose
            speciesName = "Goose";
            speciesIconString = "species_goose"
        }else if(species == "34dc8aac-3969-4676-a99a-d3406f5c235b"){
            totalDays = 28; //Turkey
            speciesName = "Turkey";
            speciesIconString = "species_turkey"
        }else if(species == "fd761813-f6b2-4e48-b019-bac88c992dc7"){
            totalDays = 28; //Peafowl
            speciesName = "Peafowl";
            speciesIconString = "species_peafowl"
        }else if(species == "e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24"){
            totalDays = 25; //Pheasant
            speciesName = "Pheasant";
            speciesIconString = "species_pheasant"
        }else if(species == "1afc182c-7c83-4ad0-9f8f-56dd0d375950"){
            totalDays = 42; //Ostrich
            speciesName = "Ostrich";
            speciesIconString = "species_ostrich"
        }else if(species == "a3c24b92-8b2d-484e-94d3-825d3b57e1e5"){
            totalDays = 56; //Emu
            speciesName = "Emu";
            speciesIconString = "species_emu"
        }
        
//        if ((self.hatchsArray[indexPath.row]["incubation_length"] as? Int) != nil){
//            totalDays = self.hatchsArray[indexPath.row]["incubation_length"] as! Int
//        }else{
//            //species = "HATCH"
//        }
        
        if ((self.hatchsArray[indexPath.row]["incubationLength"] as? Int) != nil){
            totalDays = self.hatchsArray[indexPath.row]["incubationLength"] as! Int
        }else{
            //species = "HATCH"
        }
        
        //totalDays = (self.hatchsArray[indexPath.row]["incubation_length"] as? Int)!
        cell.dayCount.textColor = hatchtrackDarkBlue
        var dayCountText = "Day "+String(currDay)+" of "+String(totalDays)
        if(currDay>=totalDays){
            dayCountText = "Hatch Complete"
            cell.dayCount.textColor = hatchtrackGreen
        }
        
        print("self.hatchsArray[indexPath.row] ->",self.hatchsArray[indexPath.row])
//        cell.hatchUUID = self.hatchsArray[indexPath.row]["uuid"] as! String
        
        cell.hatchUUID = self.hatchsArray[indexPath.row]["hatchUUID"] as! String
        
        cell.dayCount.text = dayCountText
        
        cell.dayCount.font = UIFont(name:"HelveticaNeue-Bold", size: size_daycount)
        
        cell.customImageView.image = UIImage(named: speciesIconString)
        
        cell.eggCountType.text = String(egg_count)+" eggs"
        cell.eggCountType.font = UIFont(name:"HelveticaNeue-Bold", size: size_eggs)
        
        cell.hatchName.text = hatchName
        cell.hatchName.font = UIFont.systemFont(ofSize: size_hatchname)
        
        cell.speciesLabel.text = speciesName
        cell.speciesLabel.font = UIFont(name:"HelveticaNeue-Bold", size: size_species)
        

        cell.backgroundColor = UIColor.clear
        cell.contentView.backgroundColor = UIColor.clear

        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(120)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
//        var title = self.hatchsArray[indexPath.row]["hatch_name"] as! String
        var title = self.hatchsArray[indexPath.row]["hatchName"] as! String
        print("HACTHES You selected cell #\(indexPath.row)!")
        let detailView = DetailViewHatch()
        //self.navigationController?.pushViewController(detailView, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
        let defaults = UserDefaults.standard
        
        var uuid = ""
//        if ((self.hatchsArray[indexPath.row]["uuid"] as? String) != nil){
//            uuid = self.hatchsArray[indexPath.row]["uuid"] as! String
//            defaults.set(uuid, forKey: "currentHatchUUID")
//            defaults.set(NSDate().timeIntervalSince1970, forKey: "tokenTimestamp")
//            defaults.synchronize()
//           navigate(vc:detailView,a:true,t:title)
//        }else{print("error")}
        
        if ((self.hatchsArray[indexPath.row]["hatchUUID"] as? String) != nil){
            uuid = self.hatchsArray[indexPath.row]["hatchUUID"] as! String
            defaults.set(uuid, forKey: "currentHatchUUID")
            defaults.set(NSDate().timeIntervalSince1970, forKey: "tokenTimestamp")
            defaults.synchronize()
           navigate(vc:detailView,a:true,t:title)
        }else{print("error")}
        
    }
    
    /* END TABLE */
    
    
    func navigate(vc:UIViewController,a:Bool,t:String) {
        vc.title = t
        self.navigationController?.pushViewController(vc, animated: a)
      
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
 
    
    //func getAPICalling(mainUrl:String,type:String,tokenString:String) {
    func getAPICalling(mainUrl:String,type:String,tokenString:String,data:Dictionary<String,Any>,hostUrl:String,portUrl:Int) {
        print("getAPICalling -  "+type,mainUrl)
        
        print("APIdata ",data)
        print("hostUrl ",hostUrl)
        print("portUrl ",portUrl)
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = hostUrl
        components.path = mainUrl
        components.port = portUrl

        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "/", with: "%2F")
        
        
        let defaults = UserDefaults.standard
        let email = defaults.string(forKey: "email")
        if(type == "hatches"){
            components.queryItems = [
                URLQueryItem(name: "email", value: email!)
            ]
        }
        

        
        var urlRequest = URLRequest(url: components.url!)

        //if(type == "hatches"){
        urlRequest.addValue(tokenString, forHTTPHeaderField: "Access-Token")
        
        if(type == "update_fcm_and_token"){
            print("does equl type === update_fcm_and_token")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.httpMethod = "POST"
            
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) // pass dictionary to data object and set it as request body
            } catch let error {
                print(error.localizedDescription)
                //completion(nil, error)
            }
            print("urlRequest: ",urlRequest)
            let str = String(decoding: urlRequest.httpBody!, as: UTF8.self)
            print("urlRequest.httpBody: ",str)
        }
        //}
        if(type == "deleteHatch"){
            print("deleteHatch")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.httpMethod = "POST"
            
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) // pass dictionary to data object and set it as request body
                
                
               // let list:[[String:Any]] = jsonObject?.object(forKey: "hatches_all_data_email") as! [[String : Any]]
               // print("list [hatchsArray]",list)
                //self.hatchsArray = list
                //print(self.hatchsArray)
                DispatchQueue.main.async {
                    let defaults = UserDefaults.standard
                    let accessToken = defaults.string(forKey: "accessToken")
                    let email = defaults.string(forKey: "email")
                    let data:[String:String] = [
                        "email": String(email!)
                    ]
                    self.getAPICalling(mainUrl:"/api/v1/peep/hatches_all_data_email",type:"hatches", tokenString: accessToken!, data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
                }
                
            } catch let error {
                print(error.localizedDescription)
                //completion(nil, error)
            }
            print("deleteHatch-> urlRequest: ",urlRequest)
            let str = String(decoding: urlRequest.httpBody!, as: UTF8.self)
            print("urlRequest.httpBody: ",str)
            return
        }
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
      
        
        let task = session.dataTask(with: urlRequest) {
          (data, response, error) in
            
          guard error == nil else {
            print("error calling GET")
            print(error!.localizedDescription)
            return
          }
            
          guard let responseData = data else {
            print("error: did not receive data")
            return
          }
            
            
            guard let responseString = String(data: responseData, encoding: .utf8) else{
                print("error: did not receive string")
                return
            }
            
            if(type != "hatches"){
                print("responseString: ",responseString)
            }
           
            print(self.hatchsArray.count)
             
            //
            //JSON Response
            switch type {
            case "auth":
                print("Auth")
                do {
                  guard let object = try JSONSerialization.jsonObject(with: responseData, options: [])
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
                    print(accessToken);
                    //self.getAPICalling(mainUrl:"",type:"hatches",accessToken:accessToken)
                } catch  {
                  print("error trying to convert data to JSON")
                  return
                }
                
                
            case "timeline":
                print("timeline data placeholder")
                
                
            case "deleteHatch2":
                do {
                  let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                    print("deleteHatch\(jsonObject)")
                  
                  //let key = (jsonObject! as AnyObject).object("hatches_all_data_email") as! Any
                  //print("key: ",key)
                } catch {
                  print(error.localizedDescription)
                }
                
            case "hatches":
                
                let dict = self.convertToDictionary(text: responseString)
               // let jsonObject = JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions()) as? NSDictionary
                
                do {
                  let jsonObject = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                  //print("hatches\(jsonObject)")
                    
                    let list:[[String:Any]] = jsonObject?.object(forKey: "hatches_all_data_email") as! [[String : Any]]
                   // print("list [hatchsArray]",list)
                    self.hatchsArray = list
                    //print(self.hatchsArray)
                    DispatchQueue.main.async {
                        self.loadingIndicator.isAnimating = false
                        self.hatchesTableView.reloadData()
                    }
                  //let key = (jsonObject! as AnyObject).object("hatches_all_data_email") as! Any
                  //print("key: ",key)
                } catch {
                  print(error.localizedDescription)
                }
                

                 //let object = (jsonObject! as AnyObject).object("hatches_all_data_email") as! Any

                /*
                let peoplesArray = try! JSONSerialization.jsonObject(with: Data(contentsOf: URL(fileURLWithPath: path)), options: JSONSerialization.ReadingOptions()) as? [Any]

                    var finalArray:[Any] = []

                    for peopleDict in peoplesArray {
                        if let dict = peopleDict as? [String: Any], let peopleArray = dict["People"] as? [String] {
                            finalArray.append(peopleArray)
                        }
                    }

                
                
                for peopleDict in dict["hatches_all_data_email"] {
                    if let dict = peopleDict as? [String: Any], let peopleArray = dict["People"] as? [String] {
                        finalArray.append(peopleArray)
                    }
                 }
                */
                
                /*
                if let list = dict.hatches_all_data_email as? [[String:Any]] {
                }
                
                if let hatches_list:[[String:HatchItem]] = dict.hatches_all_data_email as? [[String:HatchItem]] {
                    
                }else{
                    print("NO - hatches_all_data_email")
                }
               */
                //let list = dict["hatches_all_data_email"]
                
                //print("[All hatches for user/email] - Response: ",dict)
                
                //self.hatchsArray = dict["hatches_all_data_email"]! as Array<Any>
                DispatchQueue.main.async {
                    self.loadingIndicator.isAnimating = false
                    self.hatchesTableView.reloadData()
                }
                
                if let list = self.convertToDictionary(text: String(decoding: responseData, as: UTF8.self)) as? [[String:Any]] {
                   // print("list: ",list)
                    self.hatchsArray = list
                    //print(self.hatchsArray)
                    DispatchQueue.main.async {
                        self.loadingIndicator.isAnimating = false
                        self.hatchesTableView.reloadData()
                    }
                   
                }

            case "hatches_all_data":
                print("All hatches for peep")

            default:
                print("N/A")
            }
            
        }
        task.resume()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

}

