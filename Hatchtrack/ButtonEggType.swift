//
//  ButtonEggType.swift
//  Hatchtrack
//
//  Created by Devin Sewell on 11/22/20.
//  Copyright © 2020 ios100. All rights reserved.
//

import UIKit


class ButtonEggType: UIButton {

    //self.frame = CGRect(x: padding, y: currY, width: cellWidth/3-padding, height: standardHeight)
    //self.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
    //self.setTitle(species_array[0], for: .normal)
   
    
    var buttonTitle: String

        override init(frame: CGRect) {
            // set myValue before super.init is called
            self.buttonTitle = ""

            super.init(frame: frame)
            
            self.setTitleColor(hatchtrackRed, for: .normal)
            self.layer.borderWidth = 2.0
            self.layer.borderColor = hatchtrackRed.cgColor
            self.layer.cornerRadius = standardHeight/2
            self.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 16.0)
            // set other operations after super.init, if required
            //backgroundColor = .red
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
     


}
