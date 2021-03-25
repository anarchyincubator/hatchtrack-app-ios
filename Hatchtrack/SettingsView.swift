import UIKit



class SettingsView: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    struct NavItems {
        var name: String
        var vc: String
    }
    var menu = [[
        NavItems(name: "placeholder@email.com", vc: "")
    ]]
    let sections = [
        "Account Email",
        "Temperature Unit",
        "Default Notification Settings",
        "App Version"
    ]
    var settingsTableView = UITableView()
    let screenSize = UIScreen.main.bounds.size
    let menuOffsetX: CGFloat = ((UIScreen.main.bounds.size.width/2)/3)
    let menuSize = UIScreen.main.bounds.size.width*0.7
    var statusBarHeight:CGFloat = 0
    var topBarHeight:CGFloat = 0.0
    
    var notificationDefaults:[Bool] = [true,false,true,false,false,true,true]
    
    var n_daily_info:Bool = Bool()
    var n_5x_turning:Bool = Bool()
    var n_candling:Bool = Bool()
    var n_weighing:Bool = Bool()
    var n_cell_check:Bool = Bool()
    var n_lockdown:Bool = Bool()
    var n_hatch_day:Bool = Bool()
    
   

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let email:String = defaults.string(forKey: "email")!
        //let tokenTimestamp = defaults.double(forKey: "tokenTimestamp")
       
        if(defaults.object(forKey: "notificationDefaults") != nil){
            notificationDefaults = defaults.array(forKey: "notificationDefaults")! as! [Bool]
        }
        
        menu = [[
            NavItems(name: email, vc: "")
        ],[
           
            NavItems(name: "Farenheight (*F)", vc: "")
        ],[
            //NavItems(name: "Too Cold(over 120F)", vc: ""),
            //NavItems(name: "Too cold(under 98 for > 2 hrs)", vc: ""),
            //NavItems(name: "Humidity under 25%", vc: ""),
            //NavItems(name: "Humidity over 60% for 1 day", vc: "")
            NavItems(name: "Daily Informational", vc: ""),
            NavItems(name: "5x Turning Reminders", vc: ""),
            NavItems(name: "Candling", vc: ""),
            NavItems(name: "Weighing", vc: ""),
            NavItems(name: "Air-Cell Check", vc: ""),
            NavItems(name: "Lockdown", vc: ""),
            NavItems(name: "Hatch Day", vc: "")
        ],[
            NavItems(name: "1.1.0", vc: "")
        ]]
        
        
        self.title = "Settings"
        self.view.backgroundColor = UIColor(red: 240/255.0, green: 246/255.0, blue: 250/255.0, alpha: 1.0)  //Light Blue
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        topBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0))
        
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        settingsTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight-topBarHeight);
        settingsTableView.backgroundColor = UIColor.clear
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.allowsSelection = true
        settingsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        settingsTableView.tag = 1000
        settingsTableView.alpha = 0.0
        settingsTableView.bounds = settingsTableView.frame.insetBy(dx: 10.0, dy: 0.0)
        settingsTableView.isUserInteractionEnabled = false
        self.view.addSubview(settingsTableView);
        
        settingsTableView.register(TableCellSettings.self, forCellReuseIdentifier: "cell")
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(showTable), userInfo: nil, repeats: false)
        setupUI()

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
        loadingIndicator.isAnimating = true
    }
   
    @objc func showTable(){
        print("showTable")
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.settingsTableView.alpha = 1.0
                       }, completion: {_ in self.settingsTableView.isUserInteractionEnabled = true})
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loading_false"), object: nil)
        loadingIndicator.isAnimating = false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    /*
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 80))
        returnedView.backgroundColor = .clear

        let label = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 30))
        label.textColor = .gray
        label.text = self.sections[section]
        label.font = UIFont.systemFont(ofSize: 14)
        returnedView.addSubview(label)

        return returnedView
    }
 */
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        //returnedView.backgroundColor = .clear
        /*
        let label = UILabel(frame: CGRect(x: 20, y: 0, width: tableView.frame.size.width, height: 30))
        label.textColor = .gray
        label.text = self.sections[section]
        label.font = UIFont.systemFont(ofSize: 14)
        returnedView.addSubview(label)
        */
        
        tableView.contentInset = .zero
        let headerFrame = tableView.frame

        let label = UILabel()
        label.frame =  CGRect(x: 20, y: 40, width: headerFrame.size.width-20, height: 20) //width equals to parent view with 10 left and right margin
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        label.textColor = .gray

        let headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
        headerView.addSubview(label)
        
      

        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        ///print("sections[section]: ",sections[section])
        return sections[section]
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // menu[section].count
        return menu[section].count // set to value needed
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableCellSettings

        cell.backgroundColor = .clear
        let NavItems = menu[indexPath.section][indexPath.row]
        cell.textLabel?.text = NavItems.name
        
        if(indexPath.section == 2){
            cell.toggle_switch.isHidden = false
            cell.toggle_switch.tag = 400+indexPath.row
            cell.toggle_switch.addTarget(self, action: #selector(SettingsView.switchValueChanged(_:)), for: UIControlEvents.valueChanged)
            cell.toggle_switch.isOn = notificationDefaults[indexPath.row]
        }
        
        return cell
    }
    
    @objc func switchValueChanged(_ sender: AnyObject) {
      //dvice.isInProduction = sender.on
      print ("Switch Tag \(sender.tag)!")
        let defaults = UserDefaults.standard
        //defaults.array(forKey: "notificationDefaults")
        //GET - Incubation Length
        
        
        //GET - n_daily_info
        if let n_toggle = self.view.viewWithTag(400) as? UISwitch {
            n_daily_info = n_toggle.isOn
        }
        //GET - n_5x
        if let n_toggle = self.view.viewWithTag(401) as? UISwitch {
            n_5x_turning = n_toggle.isOn
        }
        //GET - n_candling
        if let n_toggle = self.view.viewWithTag(402) as? UISwitch {
            n_candling = n_toggle.isOn
        }
        //GET - n_weighing
        if let n_toggle = self.view.viewWithTag(403) as? UISwitch {
            n_weighing = n_toggle.isOn
        }
        //GET - n_air_cell
        if let n_toggle = self.view.viewWithTag(404) as? UISwitch {
            n_cell_check = n_toggle.isOn
        }
        //GET - n_lockdown
        if let n_toggle = self.view.viewWithTag(405) as? UISwitch {
            n_lockdown = n_toggle.isOn
        }
        //GET - n_hatch_day
        if let n_toggle = self.view.viewWithTag(406) as? UISwitch {
            n_hatch_day = n_toggle.isOn
        }
        notificationDefaults = [n_daily_info,n_5x_turning,n_candling,n_weighing,n_cell_check,n_lockdown,n_hatch_day]
        defaults.setValue(notificationDefaults, forKey: "notificationDefaults")
        defaults.synchronize()
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Properties
    let loadingIndicator: ProgressView = {
        let hatchtrackDarkBlue = UIColor(red: 64/255.0, green: 97/255.0, blue: 137/255.0, alpha: 1.0)
        let hatchtrackRed = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 1.0)
        let progress = ProgressView(colors: [hatchtrackRed,hatchtrackDarkBlue], lineWidth: 5)
        progress.isUserInteractionEnabled = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
}
