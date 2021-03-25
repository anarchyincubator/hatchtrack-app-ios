import UIKit

protocol RemoteDelegate: AnyObject {
    func closeMenu()
}

class MenuView: UITableViewController {
    weak var delegate:RemoteDelegate?
    struct NavItems {
        var imageName: String
        var name: String
        var vc: String
    }
    let menu = [[
        NavItems(imageName: "menu_logo", name: "Hatches", vc: "hatches"),
        //NavItems(imageName: "menu_icon_peeps", name: "Peeps", vc: "peeps"),
        NavItems(imageName: "menu_settings", name: "App Settings", vc: "settings"),
        NavItems(imageName: "menu_logout", name: "Log Out", vc: "logout"),
    ],[
        NavItems(imageName: "menu_web_guide", name: "Incubation Guide", vc: "web_guide"),
        NavItems(imageName: "menu_web_forum", name: "Community Forum", vc: "web_forum"),
        NavItems(imageName: "menu_web_buy_eggs", name: "Buy Eggs", vc: "web_buy_eggs"),
        NavItems(imageName: "menu_logo", name: "Hatchtrack Store", vc: "web_store")
    ]]
    let sections = [
        "Menu",
        "Links"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let returnedView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 80))
        returnedView.backgroundColor = .clear
        if(section>0){
            let borderView = UIView(frame: CGRect(x: 0, y: 8, width: tableView.frame.size.width, height: 1.0))
            borderView.backgroundColor = UIColor(red: 188/255.0, green: 213/255.0, blue: 224/255.0, alpha: 1.0) //Light Blue
            returnedView.addSubview(borderView)
        }
        let label = UILabel(frame: CGRect(x: 20, y: 20, width: tableView.frame.size.width, height: 30))
        label.textColor = .gray
        label.text = self.sections[section]
        label.font = UIFont.systemFont(ofSize: 14)
        returnedView.addSubview(label)

        return returnedView
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuDrawerViewTableCell", for: indexPath) as! MenuDrawerViewTableCell

        cell.backgroundColor = .clear
        let NavItems = menu[indexPath.section][indexPath.row]
        //cell.textLabel?.text = NavItems.name
        //cell.textLabel?.frame.origin.x = 100
        cell.menuTitleView.text = NavItems.name
        cell.menuIconImageView.image = UIImage(imageLiteralResourceName: NavItems.imageName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){

        print("MENU You selected cell #\(indexPath.row)!")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dismissMenu"), object: nil)
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loading_true"), object: nil)
        
        let defaults = UserDefaults.standard
        
        var vc = UIViewController()
        let VcName = menu[indexPath.section][indexPath.row].vc
        if(VcName == "hatches"){
            vc = ListViewHatches()
        }else if(VcName == "settings"){
            vc = SettingsView()
        }else if(VcName == "logout"){
            //defaults.set("", forKey: "email")
            //defaults.set("", forKey: "password")
            defaults.set("", forKey: "accessToken")
            vc = SignInView()
        }else if(VcName == "web_guide"){
            vc = WebView()
            defaults.set("http://chickens.wangahrah.com/incubation-101", forKey: "currentWebView")
            defaults.set("Incubation Guide", forKey: "viewTitle")
        }else if(VcName == "web_forum"){
            vc = WebView()
            defaults.set("https://community.hatchtrack.com", forKey: "currentWebView")
            defaults.set("Community Forum", forKey: "viewTitle")
        }else if(VcName == "web_buy_eggs"){
            vc = WebView()
            defaults.set("http://classifieds.hatchtrack.com", forKey: "currentWebView")
            defaults.set("Buy Eggs", forKey: "viewTitle")
        }else if(VcName == "web_store"){
            vc = WebView()
            defaults.set("http://shop.hatchtrack.com", forKey: "currentWebView")
            defaults.set("Hatchtrack Store", forKey: "viewTitle")
        }
        defaults.synchronize()
        let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!
        if let navigationController = appDelegate.window?.rootViewController as? UINavigationController{
            print("->>Goto ->> ",VcName)
            
            if(type(of:vc) != WebView.self){
                navigationController.pushViewController(vc, animated: false)
            }else{
                // Modal - Slide up (Useage: WebView)
                navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                navigationController.present(vc, animated: true, completion: nil)
            }
            
            
          
            
            
        }else{
           print("Navigation Controller not Found")
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
   

}
