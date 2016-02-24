//
//  LoaderView.swift
//  TellTenMobile
//
//  Created by kbs on 2/10/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import UIKit

class LoaderView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    required override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
       
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startLoading()
    {
        let activityIndicator = UIActivityIndicatorView(frame:CGRectMake(frame.size.width/2 - 62.5,frame.size.height/2 - 62.5,75,75))
        activityIndicator.startAnimating()
        self.addSubview(activityIndicator)
        
    }
  

}
