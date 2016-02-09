//
//  ShowCouponsViewController.swift
//  TellTenMobile
//
//  Created by kbs on 2/1/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import UIKit

class ShowCouponsViewController: UIViewController {

    
    let customNavigationBartViewobj = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = CustomColor().customColorWithLightGray()
        // Do any additional setup after loading the view.
        customNavigationBartView()
        
        let imageData = NSUserDefaults.standardUserDefaults().valueForKey("CouponImage") as? NSData
        
        if(imageData != nil)
        {
            let showCouponsImageView = UIImageView(frame: CGRectMake(10, customNavigationBartViewobj.frame.height + 20, self.view.frame.width - 20, self.view.frame.height - customNavigationBartViewobj.frame.height - 20))
            showCouponsImageView.image = UIImage(data: imageData!)
            
            self.view.addSubview(showCouponsImageView)

            
        }
     
        
          }

    //MARK:custom NavigationBar
    ////-------------------------------######################--custom NavigationBar--##########################------------------------
    func customNavigationBartView ()
    {
        customNavigationBartViewobj.frame = CGRectMake(0, 0, self.view.frame.width, 64)
        customNavigationBartViewobj.backgroundColor = CustomColor().customColorWithBlue()
        customNavigationBartViewobj.layer.shadowOffset = CGSize(width: 3, height: 4)
        customNavigationBartViewobj.layer.shadowOpacity = 0.4
        customNavigationBartViewobj.layer.shadowRadius = 2
        self.view.addSubview(customNavigationBartViewobj)
        navBackButton()
        navigationBarLabel ()
       
    }
    
    func navigationBarLabel ()
    {
        let NavBarLbl = UILabel(frame: CGRectMake(customNavigationBartViewobj.frame.width / 2 - 75, customNavigationBartViewobj.frame.height / 2 - 20 + 5, 150, 40))
        NavBarLbl.text = "Showing Saved Coupons"
        NavBarLbl.textAlignment = NSTextAlignment.Center
        NavBarLbl.textColor = UIColor.whiteColor()
        customNavigationBartViewobj.addSubview(NavBarLbl)
        
    }
    func navBackButton ()
    {
        let navBackBtn = UIButton(frame: CGRectMake(10, customNavigationBartViewobj.frame.height / 2 - 12.5 + 5, 50, 25))
        navBackBtn.setTitle("Back", forState: UIControlState.Normal)
        // navBackBtn.backgroundColor = UIColor.yellowColor()
        navBackBtn.addTarget(self, action: "navBackButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
         customNavigationBartViewobj.addSubview(navBackBtn)
    }
    
    func navBackButtonAction ()
    {
        if #available(iOS 8.0, *) {
            self.navigationController?.popViewControllerAnimated(true)

        } else {
            // Fallback on earlier versions
            self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
