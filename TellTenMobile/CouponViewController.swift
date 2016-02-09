//
//  CouponViewController.swift
//  TellTenMobile
//
//  Created by kbs on 1/20/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import UIKit
import Photos

class CouponViewController: UIViewController {

    let customNavigationBartViewobj = UIView()
    let storeSubView = UIView()
    var codeSaved = true
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = CustomColor().customColorWithLightGray()
        
        // Do any additional setup after loading the view.
        customNavigationBartView()
        
        //innitializing store subview -------
        storeSubView.frame = CGRectMake(10, customNavigationBartViewobj.frame.height + 10, self.view.frame.width - 20, self.view.frame.height - customNavigationBartViewobj.frame.height - 20)
        storeSubView.layer.shadowOffset = CGSize(width: 3, height: 3)
        storeSubView.layer.shadowOpacity = 0.3
        storeSubView.layer.shadowRadius = 2
        storeSubView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(storeSubView)
        
        thankYouLbl ()
        
        showCouponView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        navSaveButton()
    }
    
    func navigationBarLabel ()
    {
        let NavBarLbl = UILabel(frame: CGRectMake(customNavigationBartViewobj.frame.width / 2 - 75, customNavigationBartViewobj.frame.height / 2 - 20 + 5, 150, 40))
        NavBarLbl.text = "Choose Your Store"
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
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    //save coupon Funtion
    func navSaveButton ()
    {
        let navSaveButton = UIButton(frame: CGRectMake(customNavigationBartViewobj.frame.width - 60, customNavigationBartViewobj.frame.height / 2 - 12.5 + 5, 50, 25))
        navSaveButton.setTitle("Save", forState: UIControlState.Normal)
        // navBackBtn.backgroundColor = UIColor.yellowColor()
        navSaveButton.addTarget(self, action: "screenShotMethod", forControlEvents: UIControlEvents.TouchUpInside)
        customNavigationBartViewobj.addSubview(navSaveButton)
    }
    
 
    
    func screenShotMethod() {
        
        if(codeSaved == true)
        {
            //Create the UIImage
            UIGraphicsBeginImageContext(view.frame.size)
            view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            if #available(iOS 8.0, *) {
              
                PHPhotoLibrary.requestAuthorization({ (status:PHAuthorizationStatus) -> Void in
                    switch status{
                        case .Authorized:
                        dispatch_async(dispatch_get_main_queue(), {
                        print("Authorized")
                            //Save it to the camera roll
                            let sceenShotImageView = UIImageView(frame: self.view.frame)
                            self.view.addSubview(sceenShotImageView)
                            
                            
                            UIView.animateWithDuration(0.7, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                                sceenShotImageView.frame = CGRectMake(50, 100, sceenShotImageView.frame.width - 100,  sceenShotImageView.frame.height - 200)
                                sceenShotImageView.image = image
                                }) { (Finish:Bool) -> Void in
                                    UIView.animateWithDuration(0.4, delay: 0.8, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                                        sceenShotImageView.removeFromSuperview()
                                        }) { (Finish:Bool) -> Void in
                                            let alrt = UIAlertView(title: "TellTenMobile", message: "Save Coupon Successfully.", delegate: nil, cancelButtonTitle: "OK")
                                            alrt.show()
                                    }
                            }
                            
                            
                            self.codeSaved = false
                        
                        })
                        break
                        case .Denied:
                        dispatch_async(dispatch_get_main_queue(), {
                        print("Denied")
                            let alrt = UIAlertView(title: "TellTenMobile", message: "Can't Save Coupon. Please Authorize Photos to save this Copoun in Settings.", delegate: nil, cancelButtonTitle: "OK")
                            alrt.show()
                        })
                        break
                        default:
                        dispatch_async(dispatch_get_main_queue(), {
                        print("Default")
                            let alrt = UIAlertView(title: "TellTenMobile", message: "Can't Save Coupon. Something Went Wrong! Please Try Again.", delegate: nil, cancelButtonTitle: "OK")
                            alrt.show()
                        })
                        break
                    }
                })
            } else {
                // Fallback on earlier versions
            }
       
        }
        else
        {
            let alrt = UIAlertView(title: "TellTenMobile", message: "You Already Saved This Coupon", delegate: nil, cancelButtonTitle: "OK")
            alrt.show()
        }
        
    }
    
    
// thank you label---------
    func thankYouLbl ()
    {
        let thankYouLbl = UILabel(frame: CGRectMake(0, 40, storeSubView.frame.width, 50))
        let underlineAttribute = [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue]
        let underlineAttributedString = NSMutableAttributedString(string: "Thank You", attributes: underlineAttribute)
        underlineAttributedString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(24)], range: NSRange(location:0, length: 1))
        underlineAttributedString.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(24)], range: NSRange(location: 6, length: 1))
        thankYouLbl.attributedText = underlineAttributedString
        thankYouLbl.textColor =  CustomColor().customColorWithBlue()
        //thankYouLbl.font = UIFont.systemFontOfSize(20.0)
        thankYouLbl.textAlignment = NSTextAlignment.Center
        storeSubView.addSubview(thankYouLbl)
    }
    //show Coupon view------
//    var text: NSString = "This is my string"
//    var attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text)
//    
//    attributedText.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(14)], range: NSRange(location: 5, length: 2))
//    attributedText.addAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(14)], range: NSRange(location: 11, length: 6))
    
    func showCouponView()
    {
        let showCouponView = UIView(frame: CGRectMake(10, 100, storeSubView.frame.width - 20, 200))
        showCouponView.layer.borderWidth = 1
        storeSubView.addSubview(showCouponView)
        
        let couponImageView = UIImageView(frame: CGRectMake(showCouponView.frame.width / 4, showCouponView.frame.height / 4, showCouponView.frame.width / 2, showCouponView.frame.height / 2))
        couponImageView.image = UIImage(named: "coupon-bg")
        showCouponView.addSubview(couponImageView)
        
        let couponCodeLbl = UILabel(frame: CGRectMake(0, couponImageView.frame.height / 4, couponImageView.frame.width, couponImageView.frame.height / 2))
        couponCodeLbl.textColor =  UIColor.blackColor()
        couponCodeLbl.text = "AJY!@*#"
        couponCodeLbl.font = UIFont.systemFontOfSize(18.0)
        couponCodeLbl.textAlignment = NSTextAlignment.Center
        couponImageView.addSubview(couponCodeLbl)
        
        let hereLbl = UILabel(frame: CGRectMake(0, showCouponView.frame.origin.y + showCouponView.frame.height , storeSubView.frame.width, 40))
        hereLbl.textColor =  UIColor.blackColor()
        hereLbl.text = "Here Is Your Coupon"
        hereLbl.font = UIFont.systemFontOfSize(20.0)
        hereLbl.textAlignment = NSTextAlignment.Center
        storeSubView.addSubview(hereLbl)
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
