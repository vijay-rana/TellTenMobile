//
//  ActivityLoaderView.swift
//  TellTenMobile
//
//  Created by kbs on 2/29/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import UIKit

class ActivityLoaderView: UIActivityIndicatorView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    func startWithSize(activitySize:CGRect)
    {
        self.frame = CGRectMake(activitySize.size.width / 2 - 50, activitySize.size.height / 2 - 50, 100, 100 )
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.startAnimating()
    
    }
    
    
}
