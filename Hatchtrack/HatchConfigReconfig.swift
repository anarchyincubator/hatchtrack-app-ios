import UIKit



class HatchConfigReconfig: UIViewController, UIScrollViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UITextViewDelegate {
    
    struct NavItems {
        var name: String
        var vc: String
    }
    let menu = [[
        NavItems(name: "Name your Hatch", vc: "")
    ],[
        NavItems(name: "eggs", vc: "")
    ],[
        NavItems(name: "species", vc: ""),
    ],[
        NavItems(name: "length", vc: ""),
    ],[
        NavItems(name:"Daily Informational", vc:""),
        NavItems(name: "5x Day Turning", vc: ""),
        NavItems(name: "Candling", vc: ""),
        NavItems(name: "Weighing", vc: ""),
        NavItems(name: "Air Cell Check", vc: ""),
        NavItems(name: "Lockdown", vc: ""),
        NavItems(name: "Hatch Day", vc: "")
    ]]
    //Daily Informational, 5x Day Turning, Candling, Weighing, Air Cell Check, Lockdown, Hatch Day
    let sections = [
        "Hatch Name",
        "# of Eggs",
        "Egg Type",
        "Incubation Length",
        "Notifications"
    ]
    
    var currentSpeciesUUID: String = String()
    var reconfigData = ["name",3,5,23,0,1,1,0,0,0,0,0] as [Any]
    var scrollView = UIScrollView()
    
    let menuOffsetX: CGFloat = ((UIScreen.main.bounds.size.width/2)/3)
    let menuSize = UIScreen.main.bounds.size.width*0.7
    
    var uuid:String = String()

    let inputHatchName:UITextField = UITextField()
    let inputEggCount:UITextField = UITextField()
    let labelEggCount:UILabel = UILabel()
    var buttonEggType:ButtonEggType = ButtonEggType()
    let inputDayCount:UITextField = UITextField()
    let labelDayCount:UILabel = UILabel()
    var labelSectionTitle:UILabel = UILabel()
    var notificationSwitch:UISwitch = UISwitch()
    var borderBottom:UIView = UIView()

    let buttonSave:UIButton = UIButton()
    
    var species_array:[String] = Array<String>()
    
    var species_uuid_array:[String] = Array<String>()
    var species_length:[Int] = Array<Int>()
    var development_info_array:[String] = Array<String>()
    
    var notificationDefaults:[Bool] = [true,false,true,false,false,true,true]
    
    var notif_info_json: [String:Any] = [:]
    var type_index_json: [String:Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        self.title = "Edit Hatch"
        let hatchtrackRed = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 1.0)

        //species_array = ["Chicken","Mascovey Duck","Duck","Quail","Goose","Turkey","Peafowl","Pheasant","Ostrich","Emu"]
        species_array = ["Chicken","Quail","Goose","Mascovey Duck","Duck","Peafowl","Pheasant","Ostrich","Turkey","Emu"]
        //species_uuid_array = ["90df88e3-5ed5-4a1f-a689-97dfc097ebf7","7d2051f5-6346-4d6b-ba9a-1f958a7d3db5","c0999080-7749-4c9b-ada1-947ec383a845","7ff48b3f-ee67-4668-a25d-dd9910fe0382","ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b","34dc8aac-3969-4676-a99a-d3406f5c235b","fd761813-f6b2-4e48-b019-bac88c992dc7","e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24","1afc182c-7c83-4ad0-9f8f-56dd0d375950","a3c24b92-8b2d-484e-94d3-825d3b57e1e5"]
        
        species_uuid_array = ["90df88e3-5ed5-4a1f-a689-97dfc097ebf7","7ff48b3f-ee67-4668-a25d-dd9910fe0382","ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b","7d2051f5-6346-4d6b-ba9a-1f958a7d3db5","c0999080-7749-4c9b-ada1-947ec383a845","fd761813-f6b2-4e48-b019-bac88c992dc7","e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24","1afc182c-7c83-4ad0-9f8f-56dd0d375950","34dc8aac-3969-4676-a99a-d3406f5c235b","a3c24b92-8b2d-484e-94d3-825d3b57e1e5"]
        
        //species_length = [21,35,28,17,30,28,28,25,42,56]
        species_length = [21,17,30,35,28,28,25,42,28,56]
        
        type_index_json = ["90df88e3-5ed5-4a1f-a689-97dfc097ebf7":[0,1,2,3,5,6,8,10,13,14,16,17,19,20,21],"7d2051f5-6346-4d6b-ba9a-1f958a7d3db5":[0,1,5,7,10,12,14,16,18,20,23,26,30,33],"c0999080-7749-4c9b-ada1-947ec383a845":[0,2,4,5,6,7,8,10,13,14,17,19,22,24,28],"7ff48b3f-ee67-4668-a25d-dd9910fe0382":[0,1,2,3,5,6,8,9,10,11,12,13,14,15,17],"ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b":[0,2,3,4,5,7,9,11,14,17,20,23,25,27,30],"34dc8aac-3969-4676-a99a-d3406f5c235b":[0,2,4,5,6,8,10,14,16,18,20,22,24,26,28],"fd761813-f6b2-4e48-b019-bac88c992dc7":[0,2,4,5,6,8,10,14,16,18,20,22,24,26,28],"e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24":[0,1,3,4,6,7,9,11,14,15,17,18,20,22,25],"1afc182c-7c83-4ad0-9f8f-56dd0d375950":[0,4,5,7,9,12,16,20,22,24,27,30,34,36,42],"a3c24b92-8b2d-484e-94d3-825d3b57e1e5":[0,1,6,8,10,15,18,23,28,32,36,40,44,48,56]]
        
        development_info_array = ["Fertilized egg: The fertilized embryonic disc looks like a ring: it has a central area, lighter in color, which is to house the embryo.","First sign of resemblance to a chick embryo, appearance of alimentary tract, appearance of vertebral column, beginning of nervous system, beginning of head, beginning of eye.","Beginning of heart,  beginning of ear, heart beats.","Beginning of nose, beginning of legs, beginning of wings, beginning of tongue.","Formation of reproductive organs and differentiation of sex.","Beginning of beak.","Beginning of feathers.","Beginning of hardening of beak.","Appearance of scales and claws.","Embryo gets into position suitable for breaking shell.","Scales, claws and beak becoming firm.","Beak turns toward air cell.","Yolk sac begins to enter body cavity.","Yolk sac completely drawn into body cavity; embryo occupies practically all the space within the egg except the air cell.","Hatching of chick."]
        
        notif_info_json = ["90df88e3-5ed5-4a1f-a689-97dfc097ebf7":["candle_days":[ 7, 14, 18 ], "weigh_days":[ 0, 7, 13, 19 ], "air_cell_days":[ 7, 14, 18 ], "lockdown_day":16, "incubation_length":21 ], "7d2051f5-6346-4d6b-ba9a-1f958a7d3db5":[ "candle_days": [1, 18, 30], "weigh_days": [1, 18, 30], "air_cell_days": [1, 18, 30], "lockdown_day": 32, "incubation_length":35 ], "c0999080-7749-4c9b-ada1-947ec383a845":[ "candle_days": [1, 7, 13, 20, 27], "weigh_days": [1, 7, 13, 20, 27], "air_cell_days": [1, 7, 13, 20, 27], "lockdown_day": 26, "incubation_length":28 ], "7ff48b3f-ee67-4668-a25d-dd9910fe0382":[ "candle_days": [1, 7, 13, 16], "weigh_days": [1, 7, 13, 16], "air_cell_days": [1, 7, 13, 16], "lockdown_day": 14, "incubation_length":17 ], "ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b":[ "candle_days": [1, 7, 13, 20, 27, 29], "weigh_days": [1, 7, 13, 20, 27, 29], "air_cell_days": [1, 7, 13, 20, 27, 29], "lockdown_day": 28, "incubation_length":30 ], "34dc8aac-3969-4676-a99a-d3406f5c235b":[ "candle_days": [1, 7, 13, 20, 25, 27], "weigh_days": [1, 7, 13, 20, 25, 27], "air_cell_days": [1, 7, 13, 20, 25, 27], "lockdown_day": 26, "incubation_length":28 ], "fd761813-f6b2-4e48-b019-bac88c992dc7":[ "candle_days": [1, 7, 13, 20, 25, 27], "weigh_days": [1, 7, 13, 20, 25, 27], "air_cell_days": [1, 7, 13, 20, 25, 27], "lockdown_day": 26, "incubation_length":28 ], "e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24":[ "candle_days": [1, 7, 13, 20, 24], "weigh_days": [1, 7, 13, 20, 24], "air_cell_days": [1, 7, 13, 20, 24], "lockdown_day": 23, "incubation_length": 25 ], "1afc182c-7c83-4ad0-9f8f-56dd0d375950":[ "candle_days": [1, 13, 27, 41], "weigh_days": [1, 13, 27, 41], "air_cell_days": [1, 13, 27, 41], "lockdown_day": 40, "incubation_length":42 ], "a3c24b92-8b2d-484e-94d3-825d3b57e1e5":[ "candle_days": [1, 13, 27, 41, 55], "weigh_days": [1, 13, 27, 41, 55], "air_cell_days": [1, 13, 27, 41, 55], "lockdown_day": 49, "incubation_length":56 ] ];
        
        
        self.view.backgroundColor = UIColor(red: 240/255.0, green: 246/255.0, blue: 250/255.0, alpha: 1.0) 
        var screenWidth = self.view.frame.width
        if(screenWidth>=768){
            screenWidth = 705
        }
        print("self.view.frame.width: ",self.view.frame.width)
        print("self.view.bonds.width: ",self.view.bounds.width)
        cellWidth = screenWidth - padding2
        let screenHeight = UIScreen.main.bounds.height
        statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        topBarHeight = CGFloat(UIApplication.shared.statusBarFrame.size.height + (self.navigationController?.navigationBar.frame.height ?? 0.0))
        
        
        let defaults = UserDefaults.standard
        if(defaults.object(forKey: "notificationDefaults") != nil){
            notificationDefaults = defaults.array(forKey: "notificationDefaults")! as! [Bool]
        }
        print("viewdidload - self.notificationDefaults: ",notificationDefaults)
      
        var configSpacing:CGFloat = 0
        var configSpacing2:CGFloat = 0
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
                case 1136:
                    print("iPhone 5 or 5S or 5C")

                case 1334:
                    print("iPhone 6/6S/7/8")
                    configSpacing = padding
                    configSpacing2 = padding+5

                case 1920, 2208:
                    print("iPhone 6+/6S+/7+/8+")
                    configSpacing = padding
                    configSpacing2 = padding+5

                case 2436:
                    print("iPhone X/XS/11 Pro")
                    configSpacing = padding

                case 2688:
                    print("iPhone XS Max/11 Pro Max")
                    configSpacing = padding

                case 1792:
                    print("iPhone XR/ 11 ")
                    configSpacing = padding

                default:
                    print("Unknown")
                }
            }
        //configSpacing = configSpacing + padding
        let configLabel:UILabel = UILabel()
        configLabel.frame = CGRect(x: padding, y: configSpacing, width: screenWidth-padding2, height: standardHeight);
        //configLabel.textColor = UIColor(red: 203/255.0, green: 209/255.0, blue: 215/255.0, alpha: 1.0)
        configLabel.textColor = UIColor(hue: 0.0, saturation: 0.0, brightness: 0.86, alpha: 1.0)
        configLabel.text = "New Hatch"
        //configLabel.textAlignment = .center
        configLabel.font = UIFont(name:"HelveticaNeue-Bold", size: 33.0)
        self.view.addSubview(configLabel)
        
        borderBottom.frame = CGRect(x: 0, y: (configSpacing)+standardHeight, width: screenWidth, height: 1)
        borderBottom.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
        self.view.addSubview(borderBottom)
        
        
        scrollView.frame = CGRect(x: 0, y: topBarHeight+padding+configSpacing2, width: screenWidth, height: screenHeight - topBarHeight*2 - configSpacing);
        scrollView.backgroundColor = UIColor.clear
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.tag = 1000
        scrollView.alpha = 0.0
        scrollView.isUserInteractionEnabled = false
        

        self.view.addSubview(scrollView)
        
        setupUI()
        
        //CONFIG REBUILD
        
        let buttonSize1Half:CGFloat = cellWidth/2 - (padding2/2)
        let buttonSize1Third:CGFloat = cellWidth/3 - (padding2/3)
        let buttonSize1Quarter:CGFloat = cellWidth/4 - (padding2/4)
        var buttonIndex:CGFloat = 0
        
        var currY = padding
        inputHatchName.frame = CGRect(x: padding, y: currY, width: cellWidth, height: standardHeight)
        inputHatchName.textColor = hatchtrackRed
        inputHatchName.delegate = self
        inputHatchName.placeholder = "Enter Hatch name..."
        //inputHatchName.textAlignment = .center
        inputHatchName.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        scrollView.addSubview(inputHatchName)
        
        borderBottom = UIView()
        borderBottom.frame = CGRect(x: padding, y: currY+standardHeight, width: cellWidth, height: 1)
        borderBottom.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
        scrollView.addSubview(borderBottom)
        
        currY = currY + padding + standardHeight
        inputEggCount.frame = CGRect(x: padding, y: currY, width: buttonSize1Half, height: eggCountHeight)
        inputEggCount.delegate = self
        inputEggCount.textColor = hatchtrackRed
        inputEggCount.textAlignment = .center
        //inputEggCount.layer.borderColor = UIColor.lightGray.cgColor
        //inputEggCount.layer.borderWidth = 1.0
        //inputEggCount.layer.cornerRadius = 10.0
        inputEggCount.font = UIFont(name:"HelveticaNeue-Bold", size: largeTextSize)
        inputEggCount.placeholder = "0"
        inputEggCount.text = "10"
        inputEggCount.keyboardType = .numberPad
        scrollView.addSubview(inputEggCount)
        
        borderBottom = UIView()
        borderBottom.frame = CGRect(x: padding, y: currY+eggCountHeight, width: buttonSize1Half, height: 1)
        borderBottom.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
        scrollView.addSubview(borderBottom)
                
        labelEggCount.frame = CGRect(x: padding+buttonSize1Half, y: currY, width: buttonSize1Half, height: eggCountHeight)
        labelEggCount.font = UIFont(name:"HelveticaNeue-Bold", size: largeTextSize)
        labelEggCount.textColor = hatchtrackRed
        labelEggCount.text = "Eggs"
        labelEggCount.textAlignment = .center
        scrollView.addSubview(labelEggCount)
        
        
        
        // START EGG TYPE
        // EGG TYPE ROW 1
        currY = currY+padding+eggCountHeight
        
        // 'CHICKEN' BUTTON
        buttonEggType = ButtonEggType()
        buttonEggType.frame = CGRect(x: padding, y: currY, width: buttonSize1Third, height: standardHeight)
        buttonEggType.tag = 700+Int(buttonIndex)
        buttonEggType.setTitle("Chicken", for: .normal)
        buttonEggType.addTarget(self, action: #selector(setEggType(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonEggType)
        buttonIndex = buttonIndex+1
        
        // 'QUAIL' BUTTON
        buttonEggType = ButtonEggType()
        buttonEggType.frame = CGRect(x: padding+((buttonSize1Third+padding)*buttonIndex), y: currY, width: buttonSize1Third, height: standardHeight)
        buttonEggType.tag = 700+Int(buttonIndex)
        buttonEggType.setTitle("Quail", for: .normal)
        buttonEggType.addTarget(self, action: #selector(setEggType(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonEggType)
        buttonIndex = buttonIndex+1
        
        // 'GOOSE' BUTTON
        buttonEggType = ButtonEggType()
        buttonEggType.frame = CGRect(x: padding+((buttonSize1Third+padding)*buttonIndex), y: currY, width: buttonSize1Third, height: standardHeight)
        buttonEggType.tag = 700+Int(buttonIndex)
        buttonEggType.setTitle("Goose", for: .normal)
        buttonEggType.addTarget(self, action: #selector(setEggType(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonEggType)
        buttonIndex = buttonIndex+1
        
        // EGG TYPE ROW 2
        currY = currY+(padding/2)+standardHeight
        
        
        // 'Muscovey Duck' BUTTON
        buttonEggType = ButtonEggType()
        buttonEggType.frame = CGRect(x: padding, y: currY, width: buttonSize1Quarter*3, height: standardHeight)
        buttonEggType.tag = 700+Int(buttonIndex)
        buttonEggType.setTitle("Muscovey Duck", for: .normal)
        buttonEggType.addTarget(self, action: #selector(setEggType(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonEggType)
        buttonIndex = buttonIndex+1
        
        
        // 'Duck' BUTTON
        buttonEggType = ButtonEggType()
        buttonEggType.frame = CGRect(x: padding+(buttonSize1Quarter*3)+padding, y: currY, width: buttonSize1Quarter+padding, height: standardHeight)
        buttonEggType.tag = 700+Int(buttonIndex)
        buttonEggType.setTitle("Duck", for: .normal)
        buttonEggType.addTarget(self, action: #selector(setEggType(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonEggType)
        buttonIndex = buttonIndex+1
        
        
        
        // EGG TYPE ROW 3
        currY = currY+(padding/2)+standardHeight
        
        // 'CHICKEN' BUTTON
        buttonEggType = ButtonEggType()
        buttonEggType.frame = CGRect(x: padding, y: currY, width: buttonSize1Third, height: standardHeight)
        buttonEggType.tag = 700+Int(buttonIndex)
        buttonEggType.setTitle("Peafowl", for: .normal)
        buttonEggType.addTarget(self, action: #selector(setEggType(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonEggType)
        buttonIndex = buttonIndex+1
        
        // 'QUAIL' BUTTON
        buttonEggType = ButtonEggType()
        buttonEggType.frame = CGRect(x: padding+((buttonSize1Third+padding)*1), y: currY, width: buttonSize1Third, height: standardHeight)
        buttonEggType.tag = 700+Int(buttonIndex)
        buttonEggType.setTitle("Pheasant", for: .normal)
        buttonEggType.addTarget(self, action: #selector(setEggType(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonEggType)
        buttonIndex = buttonIndex+1
        
        // 'GOOSE' BUTTON
        buttonEggType = ButtonEggType()
        buttonEggType.frame = CGRect(x: padding+((buttonSize1Third+padding)*2), y: currY, width: buttonSize1Third, height: standardHeight)
        buttonEggType.tag = 700+Int(buttonIndex)
        buttonEggType.setTitle("Ostrich", for: .normal)
        buttonEggType.addTarget(self, action: #selector(setEggType(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonEggType)
        buttonIndex = buttonIndex+1
        
        // EGG TYPE ROW 4
        currY = currY+(padding/2)+standardHeight
        
        // 'CHICKEN' BUTTON
        buttonEggType = ButtonEggType()
        buttonEggType.frame = CGRect(x: padding, y: currY, width: buttonSize1Third, height: standardHeight)
        buttonEggType.tag = 700+Int(buttonIndex)
        buttonEggType.setTitle("Turkey", for: .normal)
        buttonEggType.addTarget(self, action: #selector(setEggType(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonEggType)
        buttonIndex = buttonIndex+1
        
        // 'QUAIL' BUTTON
        buttonEggType = ButtonEggType()
        buttonEggType.frame = CGRect(x: padding+buttonSize1Third+padding, y: currY, width: buttonSize1Quarter, height: standardHeight)
        buttonEggType.tag = 700+Int(buttonIndex)
        buttonEggType.setTitle("Emu", for: .normal)
        buttonEggType.addTarget(self, action: #selector(setEggType(_:)), for: .touchUpInside)
        scrollView.addSubview(buttonEggType)
        buttonIndex = buttonIndex+1
        
        // END EGG TYPE
        
        
        currY = currY + padding + standardHeight
        inputDayCount.frame = CGRect(x: padding, y: currY, width: buttonSize1Half, height: eggCountHeight)
        inputDayCount.delegate = self
        inputDayCount.textColor = hatchtrackRed
        inputDayCount.textAlignment = .center
        //inputDayCount.layer.borderColor = UIColor.lightGray.cgColor
        //inputDayCount.layer.borderWidth = 1.0
        //inputDayCount.layer.cornerRadius = 10.0
        inputDayCount.font = UIFont(name:"HelveticaNeue-Bold", size: largeTextSize)
        inputDayCount.placeholder = "0"
        inputDayCount.text = "28"
        inputDayCount.keyboardType = .numberPad
        scrollView.addSubview(inputDayCount)
        
        borderBottom = UIView()
        borderBottom.frame = CGRect(x: padding, y: currY+eggCountHeight, width: buttonSize1Half, height: 1)
        borderBottom.backgroundColor = UIColor(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
        scrollView.addSubview(borderBottom)
        
        labelDayCount.frame = CGRect(x: padding+buttonSize1Half, y: currY, width: buttonSize1Half, height: eggCountHeight)
        labelDayCount.font = UIFont(name:"HelveticaNeue-Bold", size: largeTextSize)
        labelDayCount.textColor = hatchtrackRed
        labelDayCount.text = "Days"
        labelDayCount.textAlignment = .center
        scrollView.addSubview(labelDayCount)
        
        currY = currY + padding + eggCountHeight
        
        labelSectionTitle.frame = CGRect(x: padding, y: currY, width: cellWidth, height: 31)
        labelSectionTitle.font = UIFont(name:"HelveticaNeue", size: 16.0)
        labelSectionTitle.text = "Notification Settings"
        labelSectionTitle.textColor = .lightGray
        scrollView.addSubview(labelSectionTitle)
        
        currY = currY + padding + 31
        
        labelSectionTitle = UILabel()
        labelSectionTitle.frame = CGRect(x: padding, y: currY, width: cellWidth, height: 31)
        labelSectionTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        labelSectionTitle.text = "Daily Informational"
        labelSectionTitle.textColor = .gray
        scrollView.addSubview(labelSectionTitle)
        
        
        var switchCount = 0
        notificationSwitch = UISwitch()
        notificationSwitch.tag = 400+switchCount
        notificationSwitch.frame = CGRect(x: cellWidth-padding2+10, y: currY, width: 51, height: 31)
        notificationSwitch.isOn = notificationDefaults[0]
        scrollView.addSubview(notificationSwitch)
        switchCount+=1
        
        currY = currY + padding + 31
        
        labelSectionTitle = UILabel()
        labelSectionTitle.frame = CGRect(x: padding, y: currY, width: cellWidth, height: 31)
        labelSectionTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        labelSectionTitle.text = "5x Day Turn Reminders"
        labelSectionTitle.textColor = .gray
        scrollView.addSubview(labelSectionTitle)
        
        notificationSwitch = UISwitch()
        notificationSwitch.tag = 400+switchCount
        notificationSwitch.frame = CGRect(x: cellWidth-padding2+10, y: currY, width: 51, height: 31)
        notificationSwitch.isOn = notificationDefaults[1]
        scrollView.addSubview(notificationSwitch)
        switchCount+=1
        
        currY = currY + padding + 31
        
        labelSectionTitle = UILabel()
        labelSectionTitle.frame = CGRect(x: padding, y: currY, width: cellWidth, height: 31)
        labelSectionTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        labelSectionTitle.text = "Candling"
        labelSectionTitle.textColor = .gray
        scrollView.addSubview(labelSectionTitle)
        
        notificationSwitch = UISwitch()
        notificationSwitch.tag = 400+switchCount
        notificationSwitch.frame = CGRect(x: cellWidth-padding2+10, y: currY, width: 51, height: 31)
        notificationSwitch.isOn = notificationDefaults[2]
        scrollView.addSubview(notificationSwitch)
        switchCount+=1
        
        currY = currY + padding + 31
        
        labelSectionTitle = UILabel()
        labelSectionTitle.frame = CGRect(x: padding, y: currY, width: cellWidth, height: 31)
        labelSectionTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        labelSectionTitle.text = "Weighing"
        labelSectionTitle.textColor = .gray
        scrollView.addSubview(labelSectionTitle)
        
        notificationSwitch = UISwitch()
        notificationSwitch.tag = 400+switchCount
        notificationSwitch.frame = CGRect(x: cellWidth-padding2+10, y: currY, width: 51, height: 31)
        notificationSwitch.isOn = notificationDefaults[3]
        scrollView.addSubview(notificationSwitch)
        switchCount+=1
        
        currY = currY + padding + 31
        
        labelSectionTitle = UILabel()
        labelSectionTitle.frame = CGRect(x: padding, y: currY, width: cellWidth, height: 31)
        labelSectionTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        labelSectionTitle.text = "Air Cell Check"
        labelSectionTitle.textColor = .gray
        scrollView.addSubview(labelSectionTitle)
        
        notificationSwitch = UISwitch()
        notificationSwitch.tag = 400+switchCount
        notificationSwitch.frame = CGRect(x: cellWidth-padding2+10, y: currY, width: 51, height: 31)
        notificationSwitch.isOn = notificationDefaults[4]
        scrollView.addSubview(notificationSwitch)
        switchCount+=1
        
        currY = currY + padding + 31
        
        labelSectionTitle = UILabel()
        labelSectionTitle.frame = CGRect(x: padding, y: currY, width: cellWidth, height: 31)
        labelSectionTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        labelSectionTitle.text = "Lockdown"
        labelSectionTitle.textColor = .gray
        scrollView.addSubview(labelSectionTitle)
        
        notificationSwitch = UISwitch()
        notificationSwitch.tag = 400+switchCount
        notificationSwitch.frame = CGRect(x: cellWidth-padding2+10, y: currY, width: 51, height: 31)
        notificationSwitch.isOn = notificationDefaults[5]
        scrollView.addSubview(notificationSwitch)
        switchCount+=1
        
        currY = currY + padding + 31
        
        labelSectionTitle = UILabel()
        labelSectionTitle.frame = CGRect(x: padding, y: currY, width: cellWidth, height: 31)
        labelSectionTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 20.0)
        labelSectionTitle.text = "Hatch Day"
        labelSectionTitle.textColor = .gray
        scrollView.addSubview(labelSectionTitle)
        
        notificationSwitch = UISwitch()
        notificationSwitch.tag = 400+switchCount
        notificationSwitch.frame = CGRect(x: cellWidth-padding2+10, y: currY, width: 51, height: 31)
        notificationSwitch.isOn = notificationDefaults[6]
        scrollView.addSubview(notificationSwitch)
        switchCount+=1
        
        currY = currY + padding + standardHeight
        
        buttonSave.frame = CGRect(x: padding, y: currY, width: cellWidth, height: buttonHeight)
        buttonSave.layer.cornerRadius = buttonHeight/2
        buttonSave.setTitle("Save", for: .normal)
        buttonSave.backgroundColor = hatchtrackRed
        buttonSave.addTarget(self, action: #selector(SignInView.selected(_:)), for: .touchUpInside)

        scrollView.addSubview(buttonSave)
        scrollView.updateContentView()
        
        /*
        //labelSectionTitle
        
        inputHatchName.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - 44)
        inputHatchName.delegate = self
        inputHatchName.placeholder = "Name your Hatch"
        scrollView.addSubview(inputHatchName)
        
        inputHatchName.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - 44)
        inputHatchName.delegate = self
        inputHatchName.placeholder = "Name your Hatch"
        scrollView.addSubview(inputHatchName)
        
        inputHatchName.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - 44)
        inputHatchName.delegate = self
        inputHatchName.placeholder = "Name your Hatch"
        scrollView.addSubview(inputHatchName)
        
        let labelEggCount:UILabel = UILabel()
        let buttonEggType:UIButton = UIButton()
        let notificationSwitch:UISwitch = UISwitch()
 */
        
        //END - CONFIG REBUILD
        
       
        let accessToken = defaults.string(forKey: "accessToken")
        uuid = defaults.string(forKey: "currentHatchUUID")!
        
        
        
        if(!uuid.isEmpty){
//            let data:[String:String] = ["hatchUUID":uuid,"accessToken":accessToken!]
//            getAPICalling(mainUrl: "/api/v1/hatch", type: "hatch", tokenString: accessToken!, data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
            let data = Utility.getHatchDataByUUID(uuid)
            self.parseHatch(data)
            configLabel.text = "Edit Hatch"
        }else{
            setSelectedEggButton(index:700)
            showTable()
        }
        
    }
    
    func setSelectedEggButton(index: Int){
        if let button = self.view.viewWithTag(index) as? UIButton {
            button.backgroundColor = hatchtrackRed
            button.setTitleColor(.white, for: .normal)
            inputDayCount.text = String(species_length[index-700])
            currentSpeciesUUID = String(species_uuid_array[index-700])
            print("currentSpeciesUUID: ",currentSpeciesUUID)
        }
    }
    
    func clearEggButtons(){
        for n in 0...species_uuid_array.count {
            if let button = self.view.viewWithTag(700+n) as? UIButton {
                button.backgroundColor = .clear
                button.setTitleColor(hatchtrackRed, for: .normal)
            }
        }
    }
    
    @objc func setEggType(_ sender: UIButton){
        clearEggButtons()
        setSelectedEggButton(index:sender.tag)
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
    func hideView(){
        print("hideView")
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.scrollView.alpha = 0.0
                       }, completion: nil)
    }
    
    @objc func saveHatch(_ sender:UIButton) {
        print("Save hatch - API CALL")
    }
    
    @objc func selected(_ sender: AnyObject) {
        print("Save")
        
        var species_uuid:String = ""
        var hatch_name:String = ""
        var egg_count:Int = 0
        var incubation_length:Int = 0
        var n_daily_info = true
        var n_5x_turning = true
        var n_candling = true
        var n_weighing = true
        var n_cell_check = true
        var n_lockdown = true
        var n_hatch_day = true
        
        //GET - Hatch Name
        hatch_name = inputHatchName.text!
        
        //GET - Egg Count
        egg_count = Int(inputEggCount.text!)!
        
        //GET - Species UUID
        species_uuid = currentSpeciesUUID
        
        //GET - Incubation Length
        incubation_length = Int(inputDayCount.text!)!
        
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
        
       // let cellIndex:IndexPath = IndexPath(row: 0, section: 0)

        //let cell:TableCellSettings = tableView(scrollView, cellForRowAt: cellIndex) as! TableCellSettings
        //print (cell.settings_input.text)
        
        if(egg_count == 0 || hatch_name.isEmpty){
            let alert = UIAlertController(title: "Warning", message: "Form contained errors", preferredStyle: .alert)

            //alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))

            self.present(alert, animated: true)
            return
        }
        loadingIndicator.isAnimating = true
        print(" - hatch_name: ",hatch_name)
        
        print(" - egg_count: ",egg_count)
        
        print(" - species_uuid: ",species_uuid)
        
        print(" - incubation_length: ",incubation_length)
        
        let date = Date()
        let timezone = Double(TimeZone.current.secondsFromGMT(for: date))
        let tz = Int(timezone/3600) //UTC timezone offset (hours)
        
        let defaults = UserDefaults.standard
        let fcmToken = defaults.string(forKey: "fcmToken")
        
        var data:[String:Any] = ["peepUUID":"00000000-0000-0000-0000-000000000000","endUnixTimestamp":2147483647,"measureIntervalMin":0,"temperatureOffsetCelsius":0.0,"speciesUUID":species_uuid,"eggCount":egg_count,"hatchName":hatch_name,"timezone":tz,"push_notif_token":fcmToken,"platform":"ios","n_daily_info":n_daily_info,"n_5x_turning":n_5x_turning,"n_candling":n_candling,"n_weighing":n_weighing,"n_cell_check":n_cell_check,"n_lockdown":n_lockdown,"n_hatch_day":n_hatch_day,"incubationLength":incubation_length,"hatchUUID":uuid];
        
        //let data:[String:Any] = ["peepUUID":"00000000-0000-0000-0000-000000000000","endUnixTimestamp":2147483647,"measureIntervalMin":0,"temperatureOffsetCelsius":0.0,"speciesUUID":"e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24","eggCount":13,"hatchName":"TEST","timezone":-5,"push_notif_token":"","platform":"ios","n_daily_info":true,"n_5x_turning":true,"n_candling":true,"n_weighing":true,"n_cell_check":true,"n_lockdown":true,"n_hatch_day":true,"incubation_length":21];
        
        
        print("newHatchDictionary->peepUUID",data["peepUUID"])
        print("data",data)
        //return
        //et dictionary = ["aKey": "aValue", "anotherKey": "anotherValue"]
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: data,
            options: []) {
            let theJSONText = String(data: theJSONData, encoding: .ascii)
            print("JSON string = \(theJSONText!)")
            
          
            let accessToken = defaults.string(forKey: "accessToken")
            let tokenTimestamp = defaults.double(forKey: "tokenTimestamp")
            print("accessToken: ",accessToken)
            print("tokenTimestamp: ",tokenTimestamp)
            //getAPICalling(mainUrl:"https://db.hatchtrack.com:18888/api/v1/peep/hatch",type:"new_hatch",tokenString:accessToken!,jsonString: theJSONText!)
            
            if(uuid != ""){
//                getAPICalling(mainUrl:"/api/v1/hatch/reconfig",type:"update_hatch", tokenString: accessToken!, data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
                Utility.addHatchData(data)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_hatch_list"), object: nil)
                }
            }else{
//                getAPICalling(mainUrl:"/api/v1/peep/hatch",type:"new_hatch", tokenString: accessToken!, data:data,hostUrl:"db.hatchtrack.com",portUrl:18888)
                data["hatchUUID"] = Utility.generateUUID(10)
                Utility.addHatchData(data)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_hatch_list"), object: nil)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadData"), object: nil)
                }
            }
            

            
        }

    }
    
  
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    private func setupUI() {
        
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
        
    }
   
    @objc func showTable(){
        print("[HatchConfigReconfig] - showTable")
        UIView.animate(withDuration: 0.5,
                       delay: 0, usingSpringWithDamping: 1.0,
                       initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.scrollView.alpha = 1.0
                       }, completion: {_ in self.scrollView.isUserInteractionEnabled = true;let insets = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 0);self.scrollView.contentInset = insets})
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loading_false"), object: nil)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        tableView.contentInset = .zero
        let headerFrame = tableView.frame

        let label = UILabel()
        label.frame =  CGRect(x: 20, y: 20, width: headerFrame.size.width-20, height: 20)
        label.font = UIFont.systemFont(ofSize: 14)
        if(section>0){
            label.text = self.tableView(tableView, titleForHeaderInSection: section)
        }
        label.textColor = .gray
        
        let label_right = UILabel()
        label_right.frame =  CGRect(x: headerFrame.size.width-80, y: 20, width: 60, height: 20)
        label_right.font = UIFont.systemFont(ofSize: 14)
        label_right.textAlignment = .center
        label_right.text = self.tableView(tableView, titleForHeaderInSection: section)
        label_right.textColor = .gray
        label_right.isHidden = true

        let headerView:UIView = UIView(frame: CGRect(x: 0, y: 0, width: headerFrame.size.width, height: headerFrame.size.height))
        
        
        headerView.backgroundColor = UIColor(red: 240/255.0, green: 246/255.0, blue: 250/255.0, alpha: 1.0)
        headerView.addSubview(label)
        headerView.addSubview(label_right)
        

        return headerView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if(section>0){
            return 50.0
        }
        return 10.0
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
        //cell.toggle_switch.delegate = self
        cell.settings_input.delegate = self
        cell.eggPicker.delegate = self
        cell.eggPicker.dataSource = self
        
        cell.eggPicker.isHidden = true
        cell.settings_input.isHidden = false
        cell.titleLabel.isHidden = true
        cell.toggle_switch.isHidden = true
        cell.backgroundColor = .clear
        let NavItems = menu[indexPath.section][indexPath.row]
        cell.settings_input.placeholder = NavItems.name
        
        
        if(indexPath.row == 0 && indexPath.section == 0){
            //cell.settings_input.text = reconfigData[0] as! String
        }
        if(indexPath.row == 0 && indexPath.section == 1){
            //cell.eggPicker.selectRow(reconfigData[1] as! Int, inComponent: 0, animated: true)
        }
        if(indexPath.row == 0 && indexPath.section == 2){
            //cell.eggPicker.selectRow(reconfigData[2] as! Int, inComponent: 0, animated: true)
        }
        if(indexPath.row == 0 && indexPath.section == 3){
            //cell.eggPicker.selectRow(3, inComponent: 0, animated: false)
        }

        
       
        
        
        cell.toggle_switch.isOn = notificationDefaults[indexPath.row]
        cell.toggle_switch.tag = 400+indexPath.section+indexPath.row
       
        
        cell.settings_input.tag = 300+indexPath.section+indexPath.row
        
        
        

        
        //print("cell.settings_input.tag - ",  cell.settings_input.tag)
        
        if(indexPath.section > 0 && indexPath.section <= 3){
            
            cell.eggPicker.tag = indexPath.section+indexPath.row
            
            if( cell.eggPicker.tag == 1){
                
            }
            
            if( cell.eggPicker.tag == 3){
                cell.eggPicker.isUserInteractionEnabled = false
                cell.eggPicker.selectRow(21, inComponent: 0, animated: false)
            }
            cell.eggPicker.isHidden = false
            
            print("cell.eggPicker.tag: ",cell.eggPicker.tag)
            cell.settings_input.isHidden = true
            
            
            
            
        }
        // Switch
        if(indexPath.section == 4){
            print("cell.toggle_switch.tag: ",cell.toggle_switch.tag)
            cell.titleLabel.text = NavItems.name
            cell.titleLabel.isHidden = false
            cell.settings_input.isHidden = true
            cell.toggle_switch.isHidden = false
        }
        // [END] - Switch
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getAPICalling(mainUrl:String,type:String,tokenString:String,data:Dictionary<String,Any>,hostUrl:String,portUrl:Int) {
        print("getAPICalling: ",type)
        print("URL: ",hostUrl,mainUrl,portUrl)
        print("Data: ",data)
        guard let url = URL(string: mainUrl) else {
          print("Error: cannot create URL")
          return
        }
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = hostUrl
        components.path = mainUrl
        components.port = portUrl
        
        if(type == "hatch"){
            components.queryItems = [
                URLQueryItem(name: "hatchUUID", value: data["hatchUUID"] as! String)
            ]
        }
        
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "/", with: "%2F")
        
        print("URL->",components.url)
        
        var urlRequest = URLRequest(url: (components.url)!)
        urlRequest.addValue(tokenString, forHTTPHeaderField: "Access-Token")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        if(type == "new_hatch" || type == "update_hatch"){
            urlRequest.httpMethod = "POST"
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted) // pass dictionary to data object and set it as request body
            } catch let error {
                print(error.localizedDescription)
                //completion(nil, error)
            }
        }
       
        //print("jsonData: ",String(decoding: data, as: UTF8.self))

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
            DispatchQueue.main.async {
                self.loadingIndicator.isAnimating = false
            }
            
            
        switch type {
            
            case "new_hatch":
                print("new hatch",responseString)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_hatch_list"), object: nil)
                }
                
        case "update_hatch":
            print("new hatch",responseString)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
                self.dismiss(animated: true, completion: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reload_hatch_list"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loadData"), object: nil)
            }

        case "hatch":
           
            do {
              guard let object = try JSONSerialization.jsonObject(with: responseData, options: [])
                as? [String: Any] else {
                  return
              }
                self.parseHatch(object)
                
                    //END "do"
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
    
    func parseHatch(_ object:[String: Any]) {
        var hatch_name = ""
        if ((object["hatchName"] as? String) != nil){
            hatch_name = object["hatchName"] as! String
        }else{
            hatch_name = ""
        }
        
        var species = ""
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
        
        var incubation_length = 0
        if ((object["incubationLength"] as? Int) != nil){
            incubation_length = object["incubationLength"] as! Int
        }else{
            incubation_length = 0
        }
        
        var n_daily:Bool = false
        if ((object["n_daily"] as? Bool) != nil){
            n_daily = object["n_daily"] as! Bool
        }else{
            //n_daily = true
        }
        
        var n_5x:Bool = false
        if ((object["n_5x"] as? Bool) != nil){
            n_5x = object["n_5x"] as! Bool
        }else{
            //n_5x = true
        }
        
        var n_candeling:Bool = false
        if ((object["n_candeling"] as? Bool) != nil){
            n_candeling = object["n_candeling"] as! Bool
        }else{
            //n_candeling = true
        }
        
        var n_weighing:Bool = false
        if ((object["n_weighing"] as? Bool) != nil){
            n_weighing = object["n_weighing"] as! Bool
        }else{
            //n_weighing = true
        }
        
        var n_aircell:Bool = false
        if ((object["n_aircell"] as? Bool) != nil){
            n_aircell = object["n_aircell"] as! Bool
        }else{
            //n_aircell = true
        }
        
        var n_lockdown:Bool = false
        if ((object["n_lockdown"] as? Bool) != nil){
            n_lockdown = object["n_lockdown"] as! Bool
        }else{
            //n_lockdown = true
        }
        
        var n_hatchday:Bool = false
        if ((object["n_hatchday"] as? Bool) != nil){
            n_hatchday = object["n_hatchday"] as! Bool
        }else{
            //n_hatchday = true
        }
        print("object: ",object)
        print("object['n_hatchday']",object["n_hatchday"])
        self.notificationDefaults = [n_daily,n_5x,n_candeling,n_weighing,n_aircell,n_lockdown,n_hatchday]
        
        print("self.notificationDefaults: ",self.notificationDefaults)
        
        var species_index = 0
        if(species == "90df88e3-5ed5-4a1f-a689-97dfc097ebf7"){
            species_index = 1;
        }else if(species == "7ff48b3f-ee67-4668-a25d-dd9910fe0382"){
            species_index = 2;
        }else if(species == "ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b"){
            species_index = 3;
        }else if(species == "7d2051f5-6346-4d6b-ba9a-1f958a7d3db5"){
            species_index = 4;
        }else if(species == "c0999080-7749-4c9b-ada1-947ec383a845"){
            species_index = 5
        }else if(species == "fd761813-f6b2-4e48-b019-bac88c992dc7"){
            species_index = 6;
        }else if(species == "e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24"){
            species_index = 7;
        }else if(species == "1afc182c-7c83-4ad0-9f8f-56dd0d375950"){
            species_index = 8;
        }else if(species == "34dc8aac-3969-4676-a99a-d3406f5c235b"){
            species_index = 9;
        }else if(species == "a3c24b92-8b2d-484e-94d3-825d3b57e1e5"){
            species_index = 10;
        }
        
        //species_uuid_array = ["90df88e3-5ed5-4a1f-a689-97dfc097ebf7","7ff48b3f-ee67-4668-a25d-dd9910fe0382","ecc14ee9-0f6f-408b-a2d7-5fb1f1c5688b","7d2051f5-6346-4d6b-ba9a-1f958a7d3db5","c0999080-7749-4c9b-ada1-947ec383a845","fd761813-f6b2-4e48-b019-bac88c992dc7","e85e4e09-0b6f-43e2-9c3e-cbfc8ce76f24","1afc182c-7c83-4ad0-9f8f-56dd0d375950","34dc8aac-3969-4676-a99a-d3406f5c235b","a3c24b92-8b2d-484e-94d3-825d3b57e1e5"]
        
        
        
        self.reconfigData = [hatch_name,eggCount,species_index,incubation_length,n_daily,n_5x,n_candeling,n_weighing,n_aircell,n_lockdown,n_hatchday]
            print("API - self.reconfigData:", self.reconfigData)
        
        DispatchQueue.main.async { [self] in
            currentSpeciesUUID = species
            setSelectedEggButton(index:700+(species_index-1))
            
            //UPDATE UI
            //GET - n_daily_info
            if let n_toggle = self.view.viewWithTag(400) as? UISwitch {
                n_toggle.isOn = n_daily
                print("n_toggle = self.view.viewWithTag(400) as? UISwitch: ",n_daily)
            }
            //GET - n_5x
            if let n_toggle = self.view.viewWithTag(401) as? UISwitch {
                n_toggle.isOn = n_5x
            }
            //GET - n_candling
            if let n_toggle = self.view.viewWithTag(402) as? UISwitch {
                n_toggle.isOn = n_candeling
            }
            //GET - n_weighing
            if let n_toggle = self.view.viewWithTag(403) as? UISwitch {
                n_toggle.isOn = n_weighing
            }
            //GET - n_air_cell
            if let n_toggle = self.view.viewWithTag(404) as? UISwitch {
                n_toggle.isOn = n_aircell
            }
            //GET - n_lockdown
            if let n_toggle = self.view.viewWithTag(405) as? UISwitch {
                n_toggle.isOn = n_lockdown
            }
            //GET - n_hatch_day
            if let n_toggle = self.view.viewWithTag(406) as? UISwitch {
                n_toggle.isOn = n_hatchday
            }
            inputHatchName.text = String(hatch_name)
            inputEggCount.text = String(eggCount)
            inputDayCount.text = String(incubation_length)
       
            //self.scrollView.reloadData()
            self.showTable()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(pickerView.tag == 1){
            return 100
        }
        if(pickerView.tag == 2){
            return species_array.count
        }
        if(pickerView.tag == 3){
            return 100
        }
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(pickerView.tag == 1){
            return "\(row) Eggs"
        }
        if(pickerView.tag == 2){
            
            let speciesString = species_array[row]
           
            
            
            return "\(speciesString) "
        }
        if(pickerView.tag == 3){
            return "\(row) Days"
        }
        return "\(row) "
        //print("pickerView ID: ",pickerView.tag)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
     {
       //print("\(courseCatalog[row])")
        print("pickerView.tag: ",pickerView.tag)
        if(pickerView.tag == 2){
            var species_uuid:String = species_uuid_array[pickerView.selectedRow(inComponent: 0)]
           
           // let index = species_length.firstIndex(of:species_uuid)!
            let index:Int = species_uuid_array.index(of: species_uuid)! // 0
            if let pv = self.view.viewWithTag(3) as? UIPickerView {
                pv.selectRow(species_length[index], inComponent: 0, animated: true)
            }
        }

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
