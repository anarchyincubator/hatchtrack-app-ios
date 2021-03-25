//
//  Global.swift
//  Hatchtrack
//
//  Created by Devin Sewell on 11/15/20.
//  Copyright © 2020 ios100. All rights reserved.
//

import UIKit

class Global: NSObject {

}

let largeTextSize:CGFloat = 55.0

let screenSize = UIScreen.main.bounds.size
var statusBarHeight:CGFloat = 0
var topBarHeight:CGFloat = 0.0

let hatchtrackDarkBlue = UIColor(red: 64/255.0, green: 97/255.0, blue: 137/255.0, alpha: 1.0)
let hatchtrackRed = UIColor(red: 208/255.0, green: 105/255.0, blue: 80/255.0, alpha: 1.0)
let hatchtrackGreen = UIColor(red: 109/255.0, green: 169/255.0, blue: 44/255.0, alpha: 1.0)

let appDelegate: AppDelegate = (UIApplication.shared.delegate as? AppDelegate)!

let standardHeight:CGFloat = 44.0
let eggCountHeight:CGFloat = 100.0
var cellWidth:CGFloat = screenSize.width-padding2

let buttonHeight:CGFloat = standardHeight
let padding:CGFloat = 20.0
let padding2:CGFloat = padding*2

let iphone11Spacing:CGFloat = padding2

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}

extension UIScrollView {
    func updateContentView() {
        contentSize.height = subviews.sorted(by: { $0.frame.maxY < $1.frame.maxY }).last?.frame.maxY ?? contentSize.height
    }
}
