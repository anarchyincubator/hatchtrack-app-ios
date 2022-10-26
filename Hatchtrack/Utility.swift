//
//  Utility.swift
//  Hatchtrack
//
//  Created by Bryson on 2022/10/25
//  Copyright © 2022 ios100. All rights reserved.
//

import Foundation

class Utility: NSObject {
    struct UserDefaultKey {
        static let hatch = "hatch"
    }
    class func addHatchData(_ data: [String: Any]) {
        var hatchList = getHatchData()
        let uuid = data["hatchUUID"] as? String ?? ""
        var isExist = false
        for i in 0..<hatchList.count {
            let hatchUUID = hatchList[i]["hatchUUID"] as? String ?? ""
            if uuid == hatchUUID {
                isExist = true
                hatchList[i] = data
            }
        }
        if !isExist {
            hatchList.append(data)
        }
        UserDefaults.standard.set(hatchList, forKey: UserDefaultKey.hatch)
        UserDefaults.standard.synchronize()
    }
    
    class func deleteHatchByUUID(_ uuid: String) {
        var hatchList = getHatchData()
        
        for i in 0..<hatchList.count {
            let hatchUUID = hatchList[i]["hatchUUID"] as? String ?? ""
            if uuid == hatchUUID {
                hatchList.remove(at: i)
                break
            }
        }
        UserDefaults.standard.set(hatchList, forKey: UserDefaultKey.hatch)
        UserDefaults.standard.synchronize()
        
    }
    
    class func getHatchData() -> [[String:Any]] {
        return UserDefaults.standard.array(forKey: UserDefaultKey.hatch) as? [[String: Any]] ?? [[String:Any]]()
    }
    
    class func getHatchDataByUUID(_ uuid: String) -> [String:Any] {
        let hatchList = getHatchData()
        
        for i in 0..<hatchList.count {
            let hatchUUID = hatchList[i]["hatchUUID"] as? String ?? ""
            if uuid == hatchUUID {
                return hatchList[i]
            }
        }
        return [String:Any]()
    }
    
    class func generateUUID(_ n: Int) -> String {
        let digits = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        return String(Array(0..<n).map { _ in digits.randomElement()! })
    }
}
