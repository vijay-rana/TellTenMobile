//
//  ChooseStoreViewController.swift
//  TellTenMobile
//
//  Created by kbs on 1/20/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import UIKit

class ChooseStoreViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    let customNavigationBartViewobj = UIView()
    let storeSubView = UIView()
    var storeDataArray = NSMutableArray()
    var containStoreId = 0
    let telltenLblImgView = UIImageView()
    var checkButtonstr = NSString()
    
    var loaderView = LoaderView()
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

    
    override func viewDidLoad() {
       
        super.viewDidLoad()
       
        self.view.backgroundColor = CustomColor().customColorWithLightGray()
      
        //requesting store from server
        StoreRequest().requestForStoreDataFromServer()
        
        // Do any additional setup after loading the view.
        //customiz navigation bar
        customNavigationBartView()
       
        //innitializing store subview -------
        storeSubView.frame = CGRectMake(10, customNavigationBartViewobj.frame.height + 10, self.view.frame.width - 20, self.view.frame.height - customNavigationBartViewobj.frame.height - 20)
        storeSubView.layer.shadowOffset = CGSize(width: 3, height: 3)
        storeSubView.layer.shadowOpacity = 0.3
        storeSubView.layer.shadowRadius = 2
        storeSubView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(storeSubView)
        selectStoreViewInnitialization()
        
        //subit button innitialization
        InntializingSubmitBuuton()
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
       // navSaveButton()
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
       // customNavigationBartViewobj.addSubview(navBackBtn)
    }

    func navBackButtonAction ()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func navSaveButton ()
    {
        let navSaveButton = UIButton(frame: CGRectMake(customNavigationBartViewobj.frame.width - 90, customNavigationBartViewobj.frame.height / 2 - 12.5 + 5, 80, 25))
        navSaveButton.setTitle("Coupons", forState: UIControlState.Normal)
        // navBackBtn.backgroundColor = UIColor.yellowColor()
        navSaveButton.addTarget(self, action: "navSavedCouponsAction", forControlEvents: UIControlEvents.TouchUpInside)
        customNavigationBartViewobj.addSubview(navSaveButton)
    }
    
    func navSavedCouponsAction ()
    {
        let imageData = NSUserDefaults.standardUserDefaults().valueForKey("CouponImage") as? NSData
        
        if(imageData != nil)
        {
            self.navigationController?.pushViewController(ShowCouponsViewController(), animated: true)
        }
        else
        {
          let alert = UIAlertView(title: "TellTenMobile", message: "There is no Coupon Saved", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
        
        
    }
    
//-------------------------------################################################----------------------------------------------

    //MARK:select Store view Functions
    let selectStoreView = UIView()
    let SelectButton = UIButton()
    let selectCouponsView = UIView()
    let SelectCouponButton = UIButton()
    var selectConditionBool = true
    var arrowImageVIew = UIImageView()
    var couponArrowImageVIew = UIImageView()
    func selectStoreViewInnitialization ()
    {
         selectStoreView.frame = CGRectMake(10, 10, storeSubView.frame.width - 20, storeSubView.frame.height / 2 - 90)
       // selectStoreView.backgroundColor = UIColor(patternImage: UIImage(named: "telten_mobile")!)
        selectStoreView.layer.borderColor = UIColor(red: 240/255, green: 92/255, blue: 89/255, alpha: 1.0).CGColor
        selectStoreView.layer.borderWidth = 2
        storeSubView.addSubview(selectStoreView)
        
        let storeNmaeLabel = UILabel(frame: CGRectMake(0, selectStoreView.frame.height - 40, selectStoreView.frame.width, 40))
        storeNmaeLabel.text = "Store"
        storeNmaeLabel.textAlignment = NSTextAlignment.Center
        storeNmaeLabel.font = UIFont.systemFontOfSize(25.0)
        storeNmaeLabel.textColor = UIColor.whiteColor()
        storeNmaeLabel.backgroundColor = UIColor(red: 240/255, green: 92/255, blue: 89/255, alpha: 1.0)
        selectStoreView.addSubview(storeNmaeLabel)
        
        telltenLblImgView.frame = CGRectMake(0, 0, selectStoreView.frame.width, selectStoreView.frame.height - 40)
        
        telltenLblImgView.image = UIImage(named: "telten_mobile")
        selectStoreView.addSubview(telltenLblImgView)
        
         SelectButton.frame = CGRectMake(10, selectStoreView.frame.height + selectStoreView.frame.origin.y + 5, storeSubView.frame.width - 20, 40)
        SelectButton.setTitle("Select", forState: UIControlState.Normal)
       
     //   submitButton.addTarget(self, action: "submitButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        SelectButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        SelectButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        SelectButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 0.0)
        SelectButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        SelectButton.layer.shadowOpacity = 0.2
        SelectButton.layer.shadowColor = UIColor.blackColor().CGColor
        SelectButton.addTarget(self, action: "selectStoreButtonFunction", forControlEvents: UIControlEvents.TouchUpInside)
        SelectButton.layer.shadowRadius = 2
        SelectButton.backgroundColor = CustomColor().customColorWithLightGray()
        storeSubView.addSubview(SelectButton)
        
        //down up arrow image ----
        arrowImageVIew.frame = CGRectMake(SelectButton.frame.width - 30, SelectButton.frame.height / 2 - 10, 20, 20)
        arrowImageVIew.image = UIImage(named: "dropdown-arrow.png")
        SelectButton.addSubview(arrowImageVIew)
       
        
        //select coupons ------------------------------------
        
         selectCouponsView.frame = CGRectMake(10, SelectButton.frame.height + SelectButton.frame.origin.y + 20, storeSubView.frame.width - 20, storeSubView.frame.height / 2 - 90)
        selectCouponsView.backgroundColor = CustomColor().customColorWithLightGray()
        selectCouponsView.layer.borderColor = UIColor(red: 240/255, green: 92/255, blue: 89/255, alpha: 1.0).CGColor
        selectCouponsView.layer.borderWidth = 2
        storeSubView.addSubview(selectCouponsView)
        
        let couponsNmaeLabel = UILabel(frame: CGRectMake(0, selectStoreView.frame.height - 40, selectStoreView.frame.width, 40))
        couponsNmaeLabel.text = "Coupon"
        couponsNmaeLabel.backgroundColor = UIColor(red: 240/255, green: 92/255, blue: 89/255, alpha: 1.0)
        couponsNmaeLabel.textAlignment = NSTextAlignment.Center
        couponsNmaeLabel.textColor = UIColor.whiteColor()
        couponsNmaeLabel.font = UIFont.systemFontOfSize(25.0)
        selectCouponsView.addSubview(couponsNmaeLabel)
        
        SelectCouponButton.frame = CGRectMake(10, selectCouponsView.frame.height + selectCouponsView.frame.origin.y + 5, storeSubView.frame.width - 20, 40)
        SelectCouponButton.setTitle("Select", forState: UIControlState.Normal)
        //   submitButton.addTarget(self, action: "submitButtonAction", forControlEvents: UIControlEvents.TouchUpInside)//
        SelectCouponButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        SelectCouponButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        SelectCouponButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 0.0)
        SelectCouponButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        SelectCouponButton.layer.shadowOpacity = 0.2
        SelectCouponButton.addTarget(self, action: "selectCouponButtonFunction", forControlEvents: UIControlEvents.TouchUpInside)
        SelectCouponButton.layer.shadowRadius = 2
        SelectCouponButton.backgroundColor = CustomColor().customColorWithLightGray()
        storeSubView.addSubview(SelectCouponButton)
        
        let telltenLblImgViewcoup = UIImageView(frame: CGRectMake(0, 0, selectCouponsView.frame.width, selectCouponsView.frame.height - 40))
        telltenLblImgViewcoup.image = UIImage(named: "telten_mobile")
        selectCouponsView.addSubview(telltenLblImgViewcoup)
      //down up arrow image -------------------------
        couponArrowImageVIew.frame = CGRectMake(SelectCouponButton.frame.width - 30, SelectCouponButton.frame.height / 2 - 10, 20, 20)
        couponArrowImageVIew.image = UIImage(named: "dropdown-arrow.png")
        SelectCouponButton.addSubview(couponArrowImageVIew)
        
    }
    
    //button action function----------
    //list view table
    let selectListTableView = UITableView()
    
    func tableViewInnitialization ()
    {
        selectListTableView.backgroundColor = CustomColor().customColorWithLightGray()
        selectListTableView.registerClass(ContacListTableViewCell.self, forCellReuseIdentifier: "NameCell")
        selectListTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        selectListTableView.delegate = self
        selectListTableView.dataSource = self
      
    }
    
    func selectStoreButtonFunction()
    {
        storeDataArray = storeDataStruct.structStoreDataArray
      //  print("store",storeDataArray)
        if(storeDataStruct.structStoreDataArray.count > 0)
        {
            checkButtonstr = "selectStoreButtonFunction"
            
            tableViewInnitialization()
            storeDataArray = storeDataStruct.structStoreDataArray
            selectListTableView.reloadData()
          
            if(selectConditionBool == true)
            {
                self.selectListTableView.frame = CGRectMake(10, self.selectCouponsView.frame.origin.y, self.storeSubView.frame.width - 20, 0)
                
                storeSubView.addSubview(selectListTableView)
                
                //drop down image animation-------
                
                UIView.animateWithDuration(1, animations: {
                    self.arrowImageVIew.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / 180.0)
                    
                })
                
                //selctlistView animation-----------
                UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    self.selectListTableView.frame = CGRectMake(10, self.selectListTableView.frame.origin.y, self.selectListTableView.frame.width , self.selectCouponsView.frame.height + self.SelectCouponButton.frame.height)
                    self.selectCouponsView.frame = CGRectMake(self.selectCouponsView.frame.origin.x, self.view.frame.height , self.selectCouponsView.frame.width, self.selectCouponsView.frame.height)
                    self.SelectCouponButton.frame = CGRectMake(10, self.view.frame.height + self.selectCouponsView.frame.origin.y + 5, self.storeSubView.frame.width - 20, 40)
                    
                    }, completion:{ (finish: Bool) in
                        
                })
                
                selectConditionBool = false
            }
            else
            {
                
                //drop down image animation-------
                
                UIView.animateWithDuration(1, animations: {
                    self.arrowImageVIew.transform = CGAffineTransformMakeRotation(0)
                    
                })
                
                //selctlistView animation-----------
                
                
                UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                    
                    self.selectListTableView.frame = CGRectMake(10, self.selectListTableView.frame.origin.y, self.storeSubView.frame.width - 20, 0)
                    
                    self.selectCouponsView.frame = CGRectMake(10, self.SelectButton.frame.height + self.SelectButton.frame.origin.y + 20, self.storeSubView.frame.width - 20, self.storeSubView.frame.height / 2 - 90)
                    
                    self.SelectCouponButton.frame = CGRectMake(10, self.selectCouponsView.frame.height + self.selectCouponsView.frame.origin.y + 5, self.storeSubView.frame.width - 20, 40)
                    
                    }, completion:{ (finish: Bool) in
                        
                })
                
                selectConditionBool = true
                
            }

            
        }
        else
        {
          
            let buttonGetting = UILabel(frame: CGRectMake(0, 0, 0, self.SelectButton.frame.height))
            SelectButton.addSubview(buttonGetting)
            buttonGetting.textColor = UIColor.blackColor()
            self.SelectButton.setTitle("", forState: UIControlState.Normal)
            UIView.animateWithDuration(1.5, animations: {
                buttonGetting.frame = CGRectMake(0, 0, self.SelectButton.frame.width / 2, self.SelectButton.frame.height)
                buttonGetting.text = "getting Stores..."
                
                }, completion: { (finish:Bool) -> Void in
                    if(finish)
                    {
                        buttonGetting.removeFromSuperview()
                        self.SelectButton.setTitle("Select", forState: UIControlState.Normal)
                        
                    }
            })
            

        }
        
        
        
      
    }
    
    //select coupon action Button-----------
    
    func selectCouponButtonFunction()
    {
         storeDataArray = storeDataStruct.structCouponsDataArray
        //print("coupon",storeDataArray)
        if(SelectButton.titleLabel?.text == "Select")
        {
            let alert = UIAlertView(title: "TellTenMobile", message: "Please Select Store First", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
        else
        {
         // print("check String",storeDataArray.objectAtIndex(0).objectAtIndex(2).count)
          
            
            if(storeDataArray.objectAtIndex(0).count > 0)
            {
                if(storeDataArray.objectAtIndex(0).objectAtIndex(2).count != 0)
                {
                    checkButtonstr = "selectCouponButtonFunction"
                    
                    selectListTableView.reloadData()
                    
                    
                    
                    if(selectConditionBool == true)
                    {
                        selectListTableView.frame = CGRectMake(10, SelectCouponButton.frame.height + SelectCouponButton.frame.origin.y, storeSubView.frame.width - 20, 0)
                        
                        storeSubView.addSubview(selectListTableView)
                        
                        
                        //drop down image animation-------
                        
                        UIView.animateWithDuration(1, animations: {
                            self.couponArrowImageVIew.transform = CGAffineTransformMakeRotation((180.0 * CGFloat(M_PI)) / 180.0)
                            
                        })
                        
                        //selctlistView animation-----------
                        
                        
                        
                        UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                            
                            self.selectListTableView.frame = CGRectMake(10, self.selectCouponsView.frame.origin.y, self.storeSubView.frame.width - 20, self.selectCouponsView.frame.height + 40)
                            
                            self.selectCouponsView.frame = self.selectStoreView.frame
                            self.SelectCouponButton.frame = self.SelectButton.frame
                            
                            self.selectStoreView.frame = CGRectMake(self.selectStoreView.frame.origin.x, 0 - self.selectStoreView.frame.height - 90 , self.selectStoreView.frame.width, self.selectStoreView.frame.height)
                            self.SelectButton.frame = CGRectMake(10, 0 - self.SelectButton.frame.height - 80, self.storeSubView.frame.width - 20, 40)
                            
                            
                            }, completion:{ (finish: Bool) in
                                
                        })
                        selectConditionBool = false
                    }
                    else
                    {
                        //drop down image animation-------
                        UIView.animateWithDuration(1, animations: {
                            self.couponArrowImageVIew.transform = CGAffineTransformMakeRotation(0)
                            
                        })
                        
                        UIView.animateWithDuration(0.5, delay: 0.1, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                            
                            self.selectListTableView.frame = CGRectMake(10, self.storeSubView.frame.height - self.SelectCouponButton.frame.height, self.storeSubView.frame.width - 20, 0)
                            self.selectStoreView.frame = CGRectMake(10, 10, self.storeSubView.frame.width - 20, self.storeSubView.frame.height / 2 - 90)
                            
                            self.SelectButton.frame = CGRectMake(10, self.selectStoreView.frame.height + self.selectStoreView.frame.origin.y + 5, self.storeSubView.frame.width - 20, 40)
                            
                            self.selectCouponsView.frame = CGRectMake(10, self.SelectButton.frame.height + self.SelectButton.frame.origin.y + 20, self.storeSubView.frame.width - 20, self.storeSubView.frame.height / 2 - 90)
                            
                            self.SelectCouponButton.frame = CGRectMake(10, self.selectCouponsView.frame.height + self.selectCouponsView.frame.origin.y + 5, self.storeSubView.frame.width - 20, 40)
                            
                            
                            }, completion:{ (finish: Bool) in
                                
                        })
                        
                        selectConditionBool = true
                        
                    }

                }
                else{
                    
                    let alrt = UIAlertView(title: "TellTenMobile", message: "There is no Coupons Avalable For Selected Store", delegate: nil, cancelButtonTitle: "Ok")
                    alrt.show()
                }
                
            }
            else
            {
                
                
                let buttonGetting = UILabel(frame: CGRectMake(0, 0, 0, self.SelectCouponButton.frame.height))
                SelectCouponButton.addSubview(buttonGetting)
                buttonGetting.textColor = UIColor.blackColor()
                self.SelectCouponButton.setTitle("", forState: UIControlState.Normal)
                UIView.animateWithDuration(1.5, animations: {
                    buttonGetting.frame = CGRectMake(0, 0, self.SelectCouponButton.frame.width / 2, self.SelectCouponButton.frame.height)
                    buttonGetting.text = "Getting Coupons..."
                    
                    
                    }, completion: { (finish:Bool) -> Void in
                        if(finish)
                        {
                            buttonGetting.removeFromSuperview()
                            self.SelectCouponButton.setTitle("Select", forState: UIControlState.Normal)
                            
                        }
                })
                
            }
            
            
            
            

            
        }
        
        
    }
    //MARK: tableView Delegate
    

    //datasource of tableview---------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return storeDataArray.objectAtIndex(0).objectAtIndex(2).count
    }
    
    //delegate of table view--------------
    var cellImageView = UIImageView()
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let tableViewCells = tableView.dequeueReusableCellWithIdentifier("NameCell", forIndexPath: indexPath) as! ContacListTableViewCell
        
        tableViewCells.layer.shadowOffset = CGSize(width: 3, height: 3)
        tableViewCells.layer.shadowOpacity = 0.3
        tableViewCells.layer.shadowRadius = 2
        
        tableViewCells.selectionStyle = UITableViewCellSelectionStyle.None
        tableViewCells.backgroundColor = UIColor.clearColor()
        //creating subview-----
        tableViewCells.creatingSubviewForCell()
        tableViewCells.contactImageView()
        
        let contactName = storeDataArray.objectAtIndex(0).objectAtIndex(2).objectAtIndex(indexPath.row) as! String
        tableViewCells.contactNameLabel(contactName)
        
        return tableViewCells
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        if(checkButtonstr.isEqualToString("selectStoreButtonFunction"))
        {
             SelectCouponButton.setTitle("Select", forState: UIControlState.Normal)
             SelectButton.setTitle(storeDataArray.objectAtIndex(0).objectAtIndex(2).objectAtIndex(indexPath.row) as? String, forState: UIControlState.Normal)
            loadingDataWithUrl(storeDataArray.objectAtIndex(0).objectAtIndex(0).objectAtIndex(indexPath.row) as! String)
            StoreRequest().requestForCouponFromServer(NSString(format: "%d", indexPath.row))
              selectStoreButtonFunction()
//            loaderView.frame = self.view.frame
//            loaderView.startLoading()
//            self.view.addSubview(loaderView)
        }
        else if(checkButtonstr.isEqualToString("selectCouponButtonFunction"))
        {
            SelectCouponButton.setTitle(storeDataArray.objectAtIndex(0).objectAtIndex(2).objectAtIndex(indexPath.row) as? String, forState: UIControlState.Normal)
            selectCouponButtonFunction()
        }
        
        
    }
   
    func loadingDataWithUrl (urlString:NSString)
    {
        //print(urlString)
        let urlStore = NSURL(string: urlString as String)
        let urlRequset = NSURLRequest(URL:urlStore!)
        
        
        NSURLConnection.sendAsynchronousRequest(urlRequset, queue: NSOperationQueue.mainQueue()) { (response : NSURLResponse?, data : NSData?, Error : NSError?) -> Void in
            if (data == nil)
            {
                print("nil")
            }
            else
            {
                print("not nil")
                 self.telltenLblImgView.image = UIImage(data: data!)
            }
       
            
        }
        
        
    }
  
    //coupons arry---
    func getCouponsArry()
    {
        storeDataArray = storeDataStruct.structCouponsDataArray
       loaderView.removeFromSuperview()
    
        
    }
    
        
    //---------------------------------#################################################################################_________________________________

    
    
    
    
    //MARK: Innitializing Submit Button----------
    
    func InntializingSubmitBuuton()
    {
        let submitButton = UIButton(frame: CGRectMake(10, storeSubView.frame.height - 45, storeSubView.frame.width - 20, 40))
        submitButton.setTitle("Submit", forState: UIControlState.Normal)
        submitButton.addTarget(self, action: "submitButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        submitButton.backgroundColor = CustomColor().customColorWithBlue()
        storeSubView.addSubview(submitButton)
    }
    
    // submit Button Action
    func submitButtonAction ()
    {
         if(SelectButton.titleLabel?.text == "Select")
        {
            let alert = UIAlertView(title: "TellTenMobile", message: "Please Select Store", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
        else if(SelectCouponButton.titleLabel?.text == "Select")
        {
            let alert = UIAlertView(title: "TellTenMobile", message: "Please Select Coupon", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
        else
        {
            self.navigationController?.pushViewController(ViewController(), animated: true)
        }
        
    }
    
    
    
    
    
    
//-----------------------------------------#################################################---------------------------------------------------------------
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
