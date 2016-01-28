//
//  CustomColor.swift
//  TellTenMobile
//
//  Created by kbs on 1/19/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import UIKit

class CustomColor: UIColor {

    func customColorWithRed () -> UIColor
    {
        let customRedColor = UIColor(red: 255/255, green: 47/255, blue: 47/255, alpha: 1.0)
        return customRedColor
    }
    
    func customColorWithBlue() -> UIColor
    {
        let customblueColor = UIColor(red: 41/255, green: 61/255, blue: 124/255, alpha: 1.0)
        return customblueColor
    }
    
    func customColorWithLightGray() -> UIColor
    {
    
        let customgrayColor =  UIColor(red: 250/255, green: 250/255, blue: 251/255, alpha: 1.0)
        return customgrayColor
    }
    
}
