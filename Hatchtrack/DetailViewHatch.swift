//
//  ViewController.swift
//  Blank App
//
//  Created by DBOI on 10/29/18.
//  Copyright © 2018 ios100. All rights reserved.
//

import UIKit

class DetailViewHatch: UIViewController {

    let screenSize = UIScreen.main.bounds.size
    var statusBarHeight:CGFloat = 0
    var topBarHeight:CGFloat = 0.0
    var screenWidth:CGFloat = 0.0
    var screenHeight:CGFloat = 0.0
    let textLabelEggsCount:UILabel = UILabel()
    let textLabelHatchTitle:UILabel = UILabel()
    let textLabelDaysNumber:UILabel = UILabel()
    let eggTypeImage:UIImageView = UIImageView()
    let imageViewTemp:UIImageView = UIImageView()
    let imageViewHumid:UIImageView = UIImageView()
    let textLabelTemp:UILabel = UILabel()
    let textLabelHumid:UILabel = UILabel()
    let textLabelCurrentDevTitle:UILabel = UILabel()
    let textViewCurrentDevBody:UITextView = UITextView()
    let textLabelTodayTitle:UILabel = UILabel()
    let textViewTodayBody:UITextView = UITextView()
    let textLabelNextStepsTitle:UILabel = UILabel()
    let textViewNextStepsBody:UITextView = UITextView()
    
    let scrollView:UIScrollView = UIScrollView()
    var hatchtrackBlue:UIColor = UIColor()
    var hatchtrackDarkBlue:UIColor = UIColor()
    
    let holderCardView: UIView = UIView()
    let holderTempHumid: UIView = UIView()
    
    var species_array:[String] = Array<String>()
    var species_uuid_array:[String] = Array<String>()
    var species_length:[Int] = Array<Int>()
    var development_info_array:[String] = Array<String>()
    
    let notificationDefaults:[Bool] = [true,false,true,false,false,true,true]
    
    var notif_info_json: [String:Any] = [:]
    var type_index_json: [String:Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hatchtrackBlue = UIColor(red: 240/255.0, green: 246/255.0, blue: 250/255.0, alpha: 1.0) //Light Blue
        hatchtrackDarkBlue = UIColor(red: 64/255.0, green: 97/255.0, blue: 137/255.0, alpha: 1.0)
        view.backgroundColor = hatchtrackBlue
        
        
        species_array = ["Chicken","Mascovey Duck","Duck","Quail","Goose","Turkey","Peafowl","Pheasant","Ostrich","Emu"]
        species_uuid_array = ["90df88e3-5ed5-4a1f-a689-97dfc097ebf7","7d2051f5-6346-4d6b-ba9a-1f958a7d3db5","c0999080-7749-4c9b-ada1-947ec383a845","7ff48b3f-ee67-4668-a25d-dd9910fe0382","ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b","34dc8aac-3969-4676-a99a-d3406f5c235b","fd761813-f6b2-4e48-b019-bac88c992dc7","e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24","1afc182c-7c83-4ad0-9f8f-56dd0d375950","a3c24b92-8b2d-484e-94d3-825d3b57e1e5"]
        species_length = [21,35,28,17,30,28,28,25,42,56]
        
        type_index_json = ["90df88e3-5ed5-4a1f-a689-97dfc097ebf7":[0,1,2,3,5,6,8,10,13,14,16,17,19,20,21],"7d2051f5-6346-4d6b-ba9a-1f958a7d3db5":[0,1,5,7,10,12,14,16,18,20,23,26,30,33],"c0999080-7749-4c9b-ada1-947ec383a845":[0,2,4,5,6,7,8,10,13,14,17,19,22,24,28],"7ff48b3f-ee67-4668-a25d-dd9910fe0382":[0,1,2,3,5,6,8,9,10,11,12,13,14,15,17],"ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b":[0,2,3,4,5,7,9,11,14,17,20,23,25,27,30],"34dc8aac-3969-4676-a99a-d3406f5c235b":[0,2,4,5,6,8,10,14,16,18,20,22,24,26,28],"fd761813-f6b2-4e48-b019-bac88c992dc7":[0,2,4,5,6,8,10,14,16,18,20,22,24,26,28],"e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24":[0,1,3,4,6,7,9,11,14,15,17,18,20,22,25],"1afc182c-7c83-4ad0-9f8f-56dd0d375950":[0,4,5,7,9,12,16,20,22,24,27,30,34,36,42],"a3c24b92-8b2d-484e-94d3-825d3b57e1e5":[0,1,6,8,10,15,18,23,28,32,36,40,44,48,56]]
        
        development_info_array = ["Fertilized egg: The fertilized embryonic disc looks like a ring: it has a central area, lighter in color, which is to house the embryo.","First sign of resemblance to a chick embryo, appearance of alimentary tract, appearance of vertebral column, beginning of nervous system, beginning of head, beginning of eye.","Beginning of heart,  beginning of ear, heart beats.","Beginning of nose, beginning of legs, beginning of wings, beginning of tongue.","Formation of reproductive organs and differentiation of sex.","Beginning of beak.","Beginning of feathers.","Beginning of hardening of beak.","Appearance of scales and claws.","Embryo gets into position suitable for breaking shell.","Scales, claws and beak becoming firm.","Beak turns toward air cell.","Yolk sac begins to enter body cavity.","Yolk sac completely drawn into body cavity; embryo occupies practically all the space within the egg except the air cell.","Hatching of chick."]
        
        notif_info_json = ["90df88e3-5ed5-4a1f-a689-97dfc097ebf7":["candle_days":[ 7, 14, 18 ], "weigh_days":[ 0, 7, 13, 19 ], "air_cell_days":[ 7, 14, 18 ], "lockdown_day":16, "incubation_length":21 ], "7d2051f5-6346-4d6b-ba9a-1f958a7d3db5":[ "candle_days": [1, 18, 30], "weigh_days": [1, 18, 30], "air_cell_days": [1, 18, 30], "lockdown_day": 32, "incubation_length":35 ], "c0999080-7749-4c9b-ada1-947ec383a845":[ "candle_days": [1, 7, 13, 20, 27], "weigh_days": [1, 7, 13, 20, 27], "air_cell_days": [1, 7, 13, 20, 27], "lockdown_day": 26, "incubation_length":28 ], "7ff48b3f-ee67-4668-a25d-dd9910fe0382":[ "candle_days": [1, 7, 13, 16], "weigh_days": [1, 7, 13, 16], "air_cell_days": [1, 7, 13, 16], "lockdown_day": 14, "incubation_length":17 ], "ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b":[ "candle_days": [1, 7, 13, 20, 27, 29], "weigh_days": [1, 7, 13, 20, 27, 29], "air_cell_days": [1, 7, 13, 20, 27, 29], "lockdown_day": 28, "incubation_length":30 ], "34dc8aac-3969-4676-a99a-d3406f5c235b":[ "candle_days": [1, 7, 13, 20, 25, 27], "weigh_days": [1, 7, 13, 20, 25, 27], "air_cell_days": [1, 7, 13, 20, 25, 27], "lockdown_day": 26, "incubation_length":28 ], "fd761813-f6b2-4e48-b019-bac88c992dc7":[ "candle_days": [1, 7, 13, 20, 25, 27], "weigh_days": [1, 7, 13, 20, 25, 27], "air_cell_days": [1, 7, 13, 20, 25, 27], "lockdown_day": 26, "incubation_length":28 ], "e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24":[ "candle_days": [1, 7, 13, 20, 24], "weigh_days": [1, 7, 13, 20, 24], "air_cell_days": [1, 7, 13, 20, 24], "lockdown_day": 23, "incubation_length": 25 ], "1afc182c-7c83-4ad0-9f8f-56dd0d375950":[ "candle_days": [1, 13, 27, 41], "weigh_days": [1, 13, 27, 41], "air_cell_days": [1, 13, 27, 41], "lockdown_day": 40, "incubation_length":42 ], "a3c24b92-8b2d-484e-94d3-825d3b57e1e5":[ "candle_days": [1, 13, 27, 41, 55], "weigh_days": [1, 13, 27, 41, 55], "air_cell_days": [1, 13, 27, 41, 55], "lockdown_day": 49, "incubation_length":56 ] ];
        
        
        //Global vars
        statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        topBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0))
        screenWidth = UIScreen.main.bounds.width
        screenHeight = UIScreen.main.bounds.height - topBarHeight
        
        scrollView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        scrollView.isUserInteractionEnabled = true
        scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 800)
        scrollView.alpha = 0.0
        self.view.addSubview(scrollView)
        
        let spacing: CGFloat = 20.0
        let titleLabelHeight:CGFloat = 30.0
        
        let hatchtrackGray = UIColor(red: 203/255.0, green: 209/255.0, blue: 215/255.0, alpha: 1.0);
        let hatchtrackNavy = UIColor(red: 60/255.0, green: 70/255.0, blue: 92/255.0, alpha: 1.0);
        
        holderTempHumid.frame = CGRect(x: 0, y: spacing, width: screenWidth-spacing*2, height: 200.0)
        scrollView.addSubview(holderTempHumid)
        
        
        //Image View [Temperature]
        let imageSize = (screenWidth/4)
        imageViewTemp.frame = CGRect(x: screenWidth/2 - imageSize - imageSize/2, y: textLabelDaysNumber.frame.origin.y+textLabelDaysNumber.frame.size.height+spacing, width: imageSize, height: imageSize)
        imageViewTemp.image = #imageLiteral(resourceName: "Icon_Temperature")
        holderTempHumid.addSubview(imageViewTemp)
        
        //Image View  [Humidity]
        imageViewHumid.frame = CGRect(x: (screenWidth/2 + imageSize) - imageSize/2, y: textLabelDaysNumber.frame.origin.y+textLabelDaysNumber.frame.size.height+spacing, width: imageSize, height: imageSize)
        imageViewHumid.image = #imageLiteral(resourceName: "Icon_Humidity")
        holderTempHumid.addSubview(imageViewHumid)
        
        //textLabelTemp
        textLabelTemp.frame = CGRect(x: 0, y: imageViewTemp.frame.origin.y+imageViewTemp.frame.size.height+spacing, width: screenWidth/2, height: titleLabelHeight)
        textLabelTemp.textColor = hatchtrackGray
        textLabelTemp.textAlignment = .center
        textLabelTemp.font = UIFont(name:"HelveticaNeue-Bold", size: 26.0)
        textLabelTemp.text = "99.5°F"
        holderTempHumid.addSubview(textLabelTemp)
        
        //textLabelHumid
        textLabelHumid.frame = CGRect(x: screenWidth/2, y: imageViewTemp.frame.origin.y+imageViewTemp.frame.size.height+spacing, width: screenWidth/2, height: titleLabelHeight)
        textLabelHumid.textColor = hatchtrackGray
        textLabelHumid.textAlignment = .center
        textLabelHumid.font = UIFont(name:"HelveticaNeue-Bold", size: 26.0)
        textLabelHumid.text = "40.0%"
        holderTempHumid.addSubview(textLabelHumid)

        let hatchtrackRed = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 1.0)
        
        // HOLDER VIEW //
        holderCardView.frame = CGRect(x: 0, y: textLabelTemp.frame.origin.y+textLabelTemp.frame.size.height+spacing*2, width: screenWidth, height: 700)
        holderCardView.backgroundColor = .white
        holderCardView.layer.cornerRadius = 60.0;
        scrollView.addSubview(holderCardView)

        let imageViewSpeciesHeight:CGFloat = 90.0
        let imageViewSpeciesWidth:CGFloat = imageViewSpeciesHeight*0.75
        let imgSize:CGFloat = 90
        eggTypeImage.frame = CGRect(x: spacing, y: 40, width: imageViewSpeciesWidth, height: imageViewSpeciesHeight)
        holderCardView.addSubview(eggTypeImage)
        
        //Text Label [Hatch Name]
        textLabelHatchTitle.frame = CGRect(x: imageViewSpeciesWidth+spacing+spacing/2, y: 30, width: screenWidth, height: 60)
        textLabelHatchTitle.textColor = hatchtrackRed
        textLabelHatchTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 36.0)
        textLabelHatchTitle.text = ""
        holderCardView.addSubview(textLabelHatchTitle)
        
        //Text Label [Day # of #]
        textLabelDaysNumber.frame = CGRect(x: imageViewSpeciesWidth+spacing+spacing/2, y: textLabelHatchTitle.frame.size.height+spacing, width: screenWidth, height: 28)
        textLabelDaysNumber.textColor = hatchtrackNavy
        textLabelDaysNumber.font = UIFont(name:"HelveticaNeue", size: 24.0)
        textLabelDaysNumber.text = ""
        holderCardView.addSubview(textLabelDaysNumber)
        
        textLabelEggsCount.frame = CGRect(x: screenWidth-80-spacing, y: textLabelHatchTitle.frame.size.height+spacing, width: 80, height: 28)
        textLabelEggsCount.textColor = hatchtrackRed
        textLabelEggsCount.textAlignment = .center
        textLabelEggsCount.layer.borderWidth = 1.0
        textLabelEggsCount.layer.borderColor = hatchtrackRed.cgColor
        textLabelEggsCount.layer.cornerRadius = 14.0
        textLabelEggsCount.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
        holderCardView.addSubview(textLabelEggsCount)
    
        let titleFontSize:CGFloat = 26.0
        //Text Label [Current Development]
        textLabelCurrentDevTitle.frame = CGRect(x: spacing+5, y: eggTypeImage.frame.size.height+spacing*3, width: screenWidth-spacing*2, height: titleLabelHeight)
        textLabelCurrentDevTitle.textColor = hatchtrackGray
        textLabelCurrentDevTitle.font = UIFont(name:"HelveticaNeue-Bold", size: titleFontSize)
        textLabelCurrentDevTitle.text = "Current Development"
        holderCardView.addSubview(textLabelCurrentDevTitle)
        
        //Text View [Current Development, Description]
        textViewCurrentDevBody.frame = CGRect(x: spacing, y: textLabelCurrentDevTitle.frame.origin.y+textLabelCurrentDevTitle.frame.size.height, width: screenWidth-spacing*2, height: 100)
        textViewCurrentDevBody.textColor = hatchtrackNavy
        textViewCurrentDevBody.backgroundColor = .clear
        textViewCurrentDevBody.isEditable = false
        textViewCurrentDevBody.isUserInteractionEnabled = false
        textViewCurrentDevBody.font = UIFont.systemFont(ofSize: 16)
        textViewCurrentDevBody.text = ""
        holderCardView.addSubview(textViewCurrentDevBody)
        
        //Text Label [Today Title]
        textLabelTodayTitle.frame = CGRect(x: spacing+5, y: textViewCurrentDevBody.frame.origin.y+textViewCurrentDevBody.frame.size.height, width: screenWidth-spacing*2, height: titleLabelHeight)
        textLabelTodayTitle.textColor = hatchtrackGray
        textLabelTodayTitle.font = UIFont(name:"HelveticaNeue-Bold", size: titleFontSize)
        textLabelTodayTitle.text = "Today"
        holderCardView.addSubview(textLabelTodayTitle)
        
        //Text View [Today, Description]
        textViewTodayBody.frame = CGRect(x: spacing, y: textLabelTodayTitle.frame.origin.y+textLabelTodayTitle.frame.size.height, width: screenWidth-spacing*2, height: 60)
        textViewTodayBody.textColor = hatchtrackNavy
        textViewTodayBody.backgroundColor = .clear
        textViewTodayBody.font = UIFont.systemFont(ofSize: 16)
        textViewTodayBody.isEditable = false
        textViewTodayBody.text = ""
        textViewTodayBody.isUserInteractionEnabled = false
        holderCardView.addSubview(textViewTodayBody)
        
        //Text Label [Current Development]
        textLabelNextStepsTitle.frame = CGRect(x: spacing+5, y: textViewTodayBody.frame.origin.y+textViewTodayBody.frame.size.height, width: screenWidth-spacing*2, height: titleLabelHeight)
        textLabelNextStepsTitle.textColor = hatchtrackGray
        textLabelNextStepsTitle.font = UIFont(name:"HelveticaNeue-Bold", size: titleFontSize)
        textLabelNextStepsTitle.text = "Next Steps"
        holderCardView.addSubview(textLabelNextStepsTitle)
        
        //Text View [Current Development, Description]
        textViewNextStepsBody.frame = CGRect(x: spacing, y: textLabelNextStepsTitle.frame.origin.y+textLabelNextStepsTitle.frame.size.height, width: screenWidth-spacing*2, height: 60)
        textViewNextStepsBody.textColor = hatchtrackNavy
        textViewNextStepsBody.isEditable = false
        textViewNextStepsBody.backgroundColor = .clear
        textViewNextStepsBody.font = UIFont.systemFont(ofSize: 16)
        textViewNextStepsBody.text = ""
        textViewNextStepsBody.isUserInteractionEnabled = false
        holderCardView.addSubview(textViewNextStepsBody)
        
        
        
        
        self.setupUI()
        
        let button = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editHatch))
        navigationItem.rightBarButtonItem = button
        
        loadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadData), name: NSNotification.Name(rawValue: "loadData"), object: nil)
        
        //Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(hideIndicator), userInfo: nil, repeats: false)
    }
    
    @objc func loadData(){
        let defaults = UserDefaults.standard
        let accessToken = defaults.string(forKey: "accessToken")
        let uuid = defaults.string(forKey: "currentHatchUUID")
        let data:[String:String] = ["hatchUUID":uuid!,"accessToken":accessToken!]
//        getAPICalling(mainUrl: "/api/v1/hatch", type: "hatch", tokenString: accessToken!, data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
        let hatchData = Utility.getHatchDataByUUID(uuid ?? "")
        self.parseHatch(hatchData)
       
    }

    @objc func editHatch(_ sender:UIButton) {
       let reconfigView = HatchConfigReconfig()
        //self.navigationController?.pushViewController(reconfigView, animated: true)
        // Modal - Slide up (Useage: WebView)
        self.navigationController!.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.navigationController!.present(reconfigView, animated: true, completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showView(){
        
        print("showView")
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.scrollView.alpha = 1.0
                       }, completion: nil)
    }
    
    @objc func hideIndicator(){
        loadingIndicator.isAnimating = false
        showView()
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
        // loadingIndicator.isAnimating = true
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
        print("getAPICalling ",type)
        
        guard let url = URL(string: mainUrl) else {
          print("Error: cannot create URL")
          return
        }
        
        
        var urlRequest = URLRequest(url: url)
        //print("data",data)
        print("data - hatchUUID ",data["accessToken"])
        urlRequest.addValue(data["accessToken"]!, forHTTPHeaderField: "Access-Token")

        var components = URLComponents()
        components.scheme = "https"
        components.host = hostUrl
        components.path = mainUrl
        components.port = portUrl
        components.queryItems = [
            URLQueryItem(name: "hatchUUID", value: data["hatchUUID"]!)
        ]
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "/", with: "%2F")
        

        //urlRequest = URLRequest(url:components.url!)
        
        urlRequest = URLRequest(url: (components.url)!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(data["accessToken"]!, forHTTPHeaderField: "Access-Token")
        
        /*
        for (key, value) in headers {
            urlRequest.setValue(data["accessToken"]!, forHTTPHeaderField: "Access-Token")
        }*/
        
        
        
        print("components: ",urlRequest)
        print("URL->",components.url)
        
        
        
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
            print("responseString: ",responseString)
            
            
            
            switch type {
           
            case "hatch":
               
                
                do {
                  guard let object = try JSONSerialization.jsonObject(with: responseData, options: [])
                    as? [String: Any] else {
                      return
                  }
                    self.parseHatch(object)
                    
                    
                    //self.textLabelDaysNumber.text = object["hatchName"] as! String
                    
                    //self.getAPICalling(mainUrl:"",type:"hatches",accessToken:accessToken)
                } catch  {
                  print("error trying to convert data to JSON")
                  return
                }
      
            default:
                print("N/A")
            }
            
        }
        task.resume()
    }
    
    func parseHatch(_ object: [String: Any]) {
        var hatchName = ""
        if ((object["hatchName"] as? String) != nil){
            hatchName = object["hatchName"] as! String
        }else{
            hatchName = "HATCH"
        }
        
        
        var species = ""
        var speciesName = ""
        if ((object["speciesUUID"] as? String) != nil){
            species = object["speciesUUID"] as! String
        }else{
            species = ""
        }
        
        var eggCount = 0
        if ((object["eggCount"] as? Int) != nil){
            eggCount = object["eggCount"] as! Int
        }else{
            eggCount = 0
        }
        
        var incubationLength = 0
        if ((object["incubationLength"] as? Int) != nil){
            incubationLength = object["incubationLength"] as! Int
        }else{
            incubationLength = 0
        }
        
        var startUnixTimestamp = 0
        if ((object["startUnixTimestamp"] as? Int) != nil){
            startUnixTimestamp = object["startUnixTimestamp"] as! Int
        }else{
            startUnixTimestamp = 0
        }
       
        DispatchQueue.main.async { [self] in
            
            self.title = hatchName
            var speciesIconString:String = "species_chicken"
            
            if(species == "90df88e3-5ed5-4a1f-a689-97dfc097ebf7"){
                speciesIconString = "species_chicken"
            }else if(species == "7d2051f5-6346-4d6b-ba9a-1f958a7d3db5"){
                speciesIconString = "species_muscovy"
            }else if(species == "c0999080-7749-4c9b-ada1-947ec383a845"){
                speciesIconString = "species_duck"
            }else if(species == "7ff48b3f-ee67-4668-a25d-dd9910fe0382"){
                speciesIconString = "species_quail"
            }else if(species == "ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b"){
                speciesIconString = "species_goose"
            }else if(species == "34dc8aac-3969-4676-a99a-d3406f5c235b"){
                speciesIconString = "species_turkey"
            }else if(species == "fd761813-f6b2-4e48-b019-bac88c992dc7"){
                speciesIconString = "species_peafowl"
            }else if(species == "e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24"){
                speciesIconString = "species_pheasant"
            }else if(species == "1afc182c-7c83-4ad0-9f8f-56dd0d375950"){
                speciesIconString = "species_ostrich"
            }else if(species == "a3c24b92-8b2d-484e-94d3-825d3b57e1e5"){
                speciesIconString = "species_emu"
            }
            
            
            let imgSize = 90
           
            self.eggTypeImage.image = UIImage(named: speciesIconString)
            
            self.textLabelHatchTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 36.0)
            if(species == "90df88e3-5ed5-4a1f-a689-97dfc097ebf7"){
                speciesName = "Chicken";
            }else if(species == "7d2051f5-6346-4d6b-ba9a-1f958a7d3db5"){
                speciesName = "Mascovey Duck";
                self.textLabelHatchTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 28.0)
            }else if(species == "c0999080-7749-4c9b-ada1-947ec383a845"){
                speciesName = "Duck";
            }else if(species == "7ff48b3f-ee67-4668-a25d-dd9910fe0382"){
                speciesName = "Quail";
            }else if(species == "ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b"){
                speciesName = "Goose";
            }else if(species == "34dc8aac-3969-4676-a99a-d3406f5c235b"){
                speciesName = "Turkey";
            }else if(species == "fd761813-f6b2-4e48-b019-bac88c992dc7"){
                speciesName = "Peafowl";
            }else if(species == "e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24"){
                speciesName = "Pheasant";
            }else if(species == "1afc182c-7c83-4ad0-9f8f-56dd0d375950"){
                speciesName = "Ostrich";
            }else if(species == "a3c24b92-8b2d-484e-94d3-825d3b57e1e5"){
                speciesName = "Emu";
            }
            
            self.loadingIndicator.isAnimating = false
            self.showView()
            self.textLabelHatchTitle.text = speciesName
            //self.textLabelHatchTitle.text = String(eggCount)+" "+speciesName+" eggs"
            
            
            print("startUnixTimestamp: ",startUnixTimestamp)
            let days:Int = Int(NSDate().timeIntervalSince1970-Double(startUnixTimestamp))/86400
            let diff:CGFloat = CGFloat(NSDate().timeIntervalSince1970)-CGFloat(startUnixTimestamp)
            print("Timestamp: ",CGFloat(NSDate().timeIntervalSince1970))
            print(" - ",days)
            print(" diff: ",diff/86400)
            
            
            self.textLabelDaysNumber.text = "Day "+String(days)+" of "+String(incubationLength)
            if(days>=(incubationLength)){
                self.textLabelDaysNumber.text = "Hatch Complete"
                self.textLabelDaysNumber.textColor = hatchtrackGreen
                self.textLabelDaysNumber.font = UIFont(name:"HelveticaNeue-Bold", size: 22.0)
            }
            
            self.textLabelEggsCount.text = String(eggCount)+" Eggs"
            var devIndex:[Int]
            var currentDev = self.development_info_array[0] as! String
            var nextDev = self.development_info_array[1] as! String
            for n in 0...self.type_index_json.count{
                devIndex = self.type_index_json[species] as! [Int]
                if(days>=devIndex[n]){
                    currentDev = self.development_info_array[n] as! String
                    nextDev = self.development_info_array[n+1] as! String
                }
            }
            
            var todayText:[String] = Array<String>()
            let notifObject:[String:Any] = self.notif_info_json[species] as! [String:Any]
            
            //let notifObject:[[String:[String:Int]]] = self.notif_info_json[species] as! [[String : [String:Int]]]
            print("notifObject: ",notifObject)
            
            var candleArray = notifObject["candle_days"] as! [Int]
            var weighArray = notifObject["weigh_days"] as! [Int]
            var airCellArray = notifObject["air_cell_days"] as! [Int]
            var lockdownDay:Int = notifObject["lockdown_day"] as! Int
            
            print("candleArray ",candleArray)
            print("weighArray ",weighArray)
            print("airCellArray ",airCellArray)
            print("lockdownArray ",lockdownDay)
            
            
            if(days<lockdownDay){
                todayText.append("Turn Eggs 5x")
            }
            if(candleArray.contains(days)){
                todayText.append("Candle")
            }
            if(weighArray.contains(days)){
                todayText.append("Weigh")
            }
            if(airCellArray.contains(days)){
                todayText.append("Air Cell Check")
            }
            if(days>=lockdownDay){
                todayText.append("Lockdown")
            }
            if(todayText.count == 0){
                todayText.append("Nothing today !")
            }
            
            self.textViewCurrentDevBody.text = currentDev
            self.textViewTodayBody.text = todayText.joined(separator: ", ")
            self.textViewNextStepsBody.text = nextDev
            
            self.updateLayout()
            
            if let path = Bundle.main.path(forResource: "test", ofType: "json") {
                do {
                      let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                      let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                      if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
                                // do stuff
                      }
                  } catch {
                       // handle error
                  }
            }
            
            
        }
    }
    
    func updateLayout(){
        print("updateLayout: ",updateLayout)
        self.textViewCurrentDevBody.sizeToFit()
        
        self.textLabelTodayTitle.frame = CGRect(x: padding, y: textViewCurrentDevBody.frame.origin.y+textViewCurrentDevBody.frame.size.height+5, width: screenWidth-padding2, height: 35)
        
        self.textViewTodayBody.frame = CGRect(x: padding, y: textLabelTodayTitle.frame.origin.y+textLabelTodayTitle.frame.size.height, width: screenWidth-padding2, height: 0)
        self.textViewTodayBody.sizeToFit()
        
        textLabelNextStepsTitle.frame = CGRect(x: padding, y: textViewTodayBody.frame.origin.y+textViewTodayBody.frame.size.height+5, width: screenWidth-padding2, height: 35)
        
        self.textViewNextStepsBody.frame = CGRect(x: padding, y: textLabelNextStepsTitle.frame.origin.y+textLabelNextStepsTitle.frame.size.height, width: screenWidth-padding2, height: 0)
        self.textViewNextStepsBody.sizeToFit()
        
        
        
        
    }
    
    // MARK: - Properties
    let loadingIndicator: ProgressView = {
        let hatchtrackRed = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 1.0)
        let hatchtrackDarkBlue = UIColor(red: 64/255.0, green: 97/255.0, blue: 137/255.0, alpha: 1.0)
        let progress = ProgressView(colors: [hatchtrackRed,hatchtrackDarkBlue], lineWidth: 5)
        progress.isUserInteractionEnabled = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
}

