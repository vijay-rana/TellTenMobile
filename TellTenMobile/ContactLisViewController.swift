//
//  ViewController.swift
//  TellTenMobile
//
//  Created by kbs on 1/18/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import UIKit
import AddressBook
import MessageUI

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, MFMessageComposeViewControllerDelegate {

    
   var addressBookRef : ABAddressBook!

    
    var contactNmaePhonDic = NSMutableDictionary()
    var contactNmaePhonArray = NSMutableArray()
    
    let contactListTableView = UITableView()

    let customNavigationBartViewobj = UIView()
    
    let rowIndexNumberarr = NSMutableArray()
    let selectedIndexPath = NSMutableDictionary()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = CustomColor().customColorWithLightGray()
        // Do any additional setup after loading the view, typically from a nib.
       
        //ask user for permission ------------
       // createAddressBook()
         promptForAddressBookRequestAccess()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    //getting acces from adderss book------------------------##########################----------------
    func promptForAddressBookRequestAccess() {
    
        ABAddressBookRequestAccessWithCompletion(addressBookRef) {
            (granted: Bool, error: CFError!) in
            dispatch_async(dispatch_get_main_queue()) {
                if !granted {
                    print("Just denied")
                    self.checkAddressBookAuthorization()
                } else {
                    print("Just authorized")
                    self.checkAddressBookAuthorization()
                }
            }
        }
    }

    override func viewWillAppear(animated: Bool) {
         selectedIndexPath.removeAllObjects()
         rowIndexNumberarr.removeAllObjects()
         contactListTableView.reloadData()
    }
    
    
//        check address book authorization
    func checkAddressBookAuthorization ()
    {
        
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        
        switch authorizationStatus {
        case .Denied, .Restricted:
            //1
            print("Denied")
            //if Denied then create a view to display settings---------------
            customNavigationBartView()
            tellTenLabel()
            notAuthorizeAccessContact()
        case .Authorized:
            //2
            print("Authorized")
            
            self.addressBookRef = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
            self.contactNmaePhonArray =  self.getAllContactsFromAddresBook()
            customNavigationBartView()
            tellTenLabel()
            intializingContactListTableView()
            InntializingSubmitBuuton()
        case .NotDetermined:
            //3
            print("Not Determined")
            customNavigationBartView()
            tellTenLabel()
            notAuthorizeAccessContact()
        }
    }
    
    
    //custom NavigationBar View-------
    
    func customNavigationBartView ()
    {
         customNavigationBartViewobj.frame = CGRectMake(0, 0, self.view.frame.width, 64)
        customNavigationBartViewobj.backgroundColor = CustomColor().customColorWithBlue()
        self.view.addSubview(customNavigationBartViewobj)
        navigationBarLabel ()
        navBackButton()
    }
    
    func navigationBarLabel ()
    {
        let NavBarLbl = UILabel(frame: CGRectMake(customNavigationBartViewobj.frame.width / 2 - 75, customNavigationBartViewobj.frame.height / 2 - 20 + 5, 150, 40))
        NavBarLbl.text = "Select Friends"
        NavBarLbl.textAlignment = NSTextAlignment.Center
        NavBarLbl.textColor = UIColor.whiteColor()
        customNavigationBartViewobj.addSubview(NavBarLbl)
    }
    func tellTenLabel ()
    {
        let tenTenLbl = UILabel(frame: CGRectMake(0, 64, self.view.frame.width, 40))
        tenTenLbl.text = "Tell Ten"
        tenTenLbl.textAlignment = NSTextAlignment.Center
        tenTenLbl.backgroundColor = UIColor.whiteColor()
        tenTenLbl.layer.shadowOffset = CGSize(width: 3, height: 3)
        tenTenLbl.layer.shadowOpacity = 0.3
        tenTenLbl.layer.shadowRadius = 2
        
        self.view.addSubview(tenTenLbl)
    }
    
    //MARK: tableView delegate and datasource
//inntializationg tableview for displaying user contacts--------##########################----------------
    
    func intializingContactListTableView()
    {
        contactListTableView.frame = CGRectMake(0, 114, self.view.frame.width,  self.view.frame.height - 104 - 60)
        contactListTableView.registerClass(ContacListTableViewCell.self, forCellReuseIdentifier: "NameCell")
        contactListTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        contactListTableView.allowsMultipleSelection = true
        contactListTableView.backgroundColor = UIColor.clearColor()
       
        contactListTableView.delegate = self
        contactListTableView.dataSource = self
        self.view.addSubview(contactListTableView)
        
        
    }
    
 
//datasource of tableview---------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactNmaePhonArray.objectAtIndex(0).count
    }
    
//delegate of table view--------------
    var cellImageView = UIImageView()
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        
        
        var customTableViewCells = ContacListTableViewCell()
        
        
        if(selectedIndexPath.count > 0)
        {
            
            
            if(selectedIndexPath.objectForKey(indexPath.row) != nil)
            {
                
                if(indexPath == selectedIndexPath.objectForKey(indexPath.row) as! NSIndexPath)
                {
                    customTableViewCells = tableView.dequeueReusableCellWithIdentifier("NameCell", forIndexPath: selectedIndexPath.objectForKey(indexPath.row) as! NSIndexPath) as! ContacListTableViewCell
                    customTableViewCells.imageViewTick.image = UIImage(named: "checkArrow")
                    customTableViewCells.layer.shadowOffset = CGSize(width: 3, height: 3)
                    customTableViewCells.layer.shadowOpacity = 0.3
                    customTableViewCells.layer.shadowRadius = 2
                    
                    customTableViewCells.selectionStyle = UITableViewCellSelectionStyle.None
                    customTableViewCells.backgroundColor = UIColor.clearColor()
                    
                    customTableViewCells.creatingSubviewForCell()
                    customTableViewCells.contactImageView()
                    
                    
                    
                    let contactName = contactNmaePhonArray.objectAtIndex(0).objectAtIndex(indexPath.row) as! String
                    customTableViewCells.contactNameLabel(contactName)
                    
                   
                    print("same",indexPath.row)
                }
                else
                {
                 customTableViewCells = tableView.dequeueReusableCellWithIdentifier("NameCell", forIndexPath: indexPath) as! ContacListTableViewCell
                   
                    customTableViewCells.layer.shadowOffset = CGSize(width: 3, height: 3)
                    customTableViewCells.layer.shadowOpacity = 0.3
                    customTableViewCells.layer.shadowRadius = 2
                    
                    customTableViewCells.selectionStyle = UITableViewCellSelectionStyle.None
                    customTableViewCells.backgroundColor = UIColor.clearColor()
                    
                    customTableViewCells.creatingSubviewForCell()
                    customTableViewCells.contactImageView()
                    customTableViewCells.imageViewTick.image = UIImage(named: "UncheckArrow")
                    
                    
                    let contactName = contactNmaePhonArray.objectAtIndex(0).objectAtIndex(indexPath.row) as! String
                    customTableViewCells.contactNameLabel(contactName)
                  
                }
                
           
        
            }
            else
            {
                
                customTableViewCells = tableView.dequeueReusableCellWithIdentifier("NameCell", forIndexPath: indexPath) as! ContacListTableViewCell
                customTableViewCells.imageViewTick.image = UIImage(named: "UncheckArrow")
                
                customTableViewCells.layer.shadowOffset = CGSize(width: 3, height: 3)
                customTableViewCells.layer.shadowOpacity = 0.3
                customTableViewCells.layer.shadowRadius = 2
                
                customTableViewCells.selectionStyle = UITableViewCellSelectionStyle.None
                customTableViewCells.backgroundColor = UIColor.clearColor()
                
                customTableViewCells.creatingSubviewForCell()
                customTableViewCells.contactImageView()
                customTableViewCells.imageViewTick.image = UIImage(named: "UncheckArrow")
                
                
                let contactName = contactNmaePhonArray.objectAtIndex(0).objectAtIndex(indexPath.row) as! String
                customTableViewCells.contactNameLabel(contactName)

                
            }
      
        }
        else
        {
            
             customTableViewCells = tableView.dequeueReusableCellWithIdentifier("NameCell", forIndexPath: indexPath) as! ContacListTableViewCell
            customTableViewCells.imageViewTick.image = UIImage(named: "UncheckArrow")
            
            customTableViewCells.layer.shadowOffset = CGSize(width: 3, height: 3)
            customTableViewCells.layer.shadowOpacity = 0.3
            customTableViewCells.layer.shadowRadius = 2
            
            customTableViewCells.selectionStyle = UITableViewCellSelectionStyle.None
            customTableViewCells.backgroundColor = UIColor.clearColor()
            
            customTableViewCells.creatingSubviewForCell()
            customTableViewCells.contactImageView()
            customTableViewCells.imageViewTick.image = UIImage(named: "UncheckArrow")
            
            
            let contactName = contactNmaePhonArray.objectAtIndex(0).objectAtIndex(indexPath.row) as! String
            customTableViewCells.contactNameLabel(contactName)
            

            
        }

        customTableViewCells.layer.shadowOffset = CGSize(width: 3, height: 3)
        customTableViewCells.layer.shadowOpacity = 0.3
        customTableViewCells.layer.shadowRadius = 2
        
        customTableViewCells.selectionStyle = UITableViewCellSelectionStyle.None
        customTableViewCells.backgroundColor = UIColor.clearColor()
        
        customTableViewCells.creatingSubviewForCell()
        customTableViewCells.contactImageView()
        
        
        
        let contactName = contactNmaePhonArray.objectAtIndex(0).objectAtIndex(indexPath.row) as! String
        customTableViewCells.contactNameLabel(contactName)
        
        
        
        return customTableViewCells
    }
    
  
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         addIndexNumber(indexPath)
        let cellObj = tableView.cellForRowAtIndexPath(indexPath) as! ContacListTableViewCell
        cellObj.imageViewTick.image = UIImage(named: "checkArrow")
        
       
        
   
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        removeIndexPath(indexPath)
        let cellObj = tableView.cellForRowAtIndexPath(indexPath) as! ContacListTableViewCell
          cellObj.imageViewTick.image = UIImage(named: "UncheckArrow")
        
    }
    
   
    func addIndexNumber (rowIndexPath: NSIndexPath)
    {
        
        rowIndexNumberarr.addObject(rowIndexPath.row)
        selectedIndexPath.setObject(rowIndexPath, forKey: rowIndexPath.row)
       
    }
    func removeIndexPath (rowIndexPath: NSIndexPath)
    {
        
        if(rowIndexNumberarr.containsObject(rowIndexPath.row))
        {
            let indexCell = rowIndexNumberarr.indexOfObject(rowIndexPath.row)
            rowIndexNumberarr.removeObjectAtIndex(indexCell)
            
        }
      
         selectedIndexPath.removeObjectForKey(rowIndexPath.row)
        
        
    }
    
//---------------------------------#################################################################################_________________________________
    
    //MARK: Innitializing Submit Button----------
    
    func InntializingSubmitBuuton()
    {
        let submitButton = UIButton(frame: CGRectMake(10, self.view.frame.height - 45, self.view.frame.width - 20, 40))
        submitButton.setTitle("Submit", forState: UIControlState.Normal)
        submitButton.addTarget(self, action: "submitButtonAction", forControlEvents: UIControlEvents.TouchUpInside)
        submitButton.backgroundColor = CustomColor().customColorWithBlue()
        self.view.addSubview(submitButton)
    }

    // submit Button Action
    func submitButtonAction ()
    {
        print(rowIndexNumberarr)
       // self.navigationController?.pushViewController(CouponViewController(), animated: true)
        
        //if(rowIndexNumberarr.count > 9)
       if(true)
        {
            let ActivityLoaderView = UIActivityIndicatorView(frame: CGRectMake(self.view.frame.size.width / 2 - 37.5, self.view.frame.size.height / 2 - 37.5, 75, 75 ))
            
            ActivityLoaderView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.8)
            ActivityLoaderView.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
            ActivityLoaderView.layer.cornerRadius = 10.0
            ActivityLoaderView.startAnimating()
            self.view.addSubview(ActivityLoaderView)
            
            UIView.animateWithDuration(0.6, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                ActivityLoaderView.frame = CGRectMake(self.view.frame.size.width / 2 - 50, self.view.frame.size.height / 2 - 50, 100, 100)
                
                }) { (Bool) -> Void in
                    
            }

            var SelectedNumberList: NSMutableArray = []
            
            var NumberJSON:String =  "{\"numberList\":["
            for count in rowIndexNumberarr {
                
                NumberJSON = NumberJSON + "{\"name\": \"" + String(contactNmaePhonArray.objectAtIndex(0).objectAtIndex(Int(count as! NSNumber))) + "\","
                NumberJSON = NumberJSON +  "phoneNumber\": \""  + String(contactNmaePhonDic[String(contactNmaePhonArray.objectAtIndex(0).objectAtIndex(Int(count as! NSNumber)))]!) + "\"},"
                
                SelectedNumberList.addObject(String(contactNmaePhonDic[String(contactNmaePhonArray.objectAtIndex(0).objectAtIndex(Int(count as! NSNumber)))]!))
                
            }
            
            NumberJSON = String(NumberJSON.characters.dropLast())
            NumberJSON =  NumberJSON + "]}"
            
            
            print(SelectedNumberList as NSArray as! [String])
            
            if (MFMessageComposeViewController.canSendText()) {
                let controller = MFMessageComposeViewController()
                controller.body =  CreateBody()
                controller.recipients = SelectedNumberList as NSArray as! [String]
                controller.messageComposeDelegate = self
                self.presentViewController(controller, animated: true, completion: nil)
            }
            
            
            
            //getting data from server
         
             StoreRequest().requestNetwork("http://www.telltenmobile.com/web/ws/contactHandler.php", httpBody: NumberJSON, completions: { (result) -> Void in
                
                if(result.count != 0)
                {
                    ActivityLoaderView.stopAnimating()
                    ActivityLoaderView.removeFromSuperview()
                    print("this is a =>",result)
                    storeDataStruct.couponCode = result.valueForKey("coupons") as! NSString
                    
                    dispatch_async(dispatch_get_main_queue()) { // 2
                        self.navigationController?.pushViewController(CouponViewController(), animated: true)// 3
                    }
                    // self.navigationController?.pushViewController(CouponViewController(), animated: true)
                    
                }
                
                }, failure: { (errorMassege) -> Void in
                     ActivityLoaderView.stopAnimating()
                    ActivityLoaderView.removeFromSuperview()
                    
                    let alrt = UIAlertView(title: "TellTenMobile", message: errorMassege as String, delegate: nil, cancelButtonTitle: "Ok")
                    alrt.show()
             })
            
        }
        else
        {
            let alertView = UIAlertView(title: "Tell Ten ", message: "Please select atleast ten Contacts", delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()
            
        }
        
    }
    
    
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        //... handle sms screen actions
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    func CreateBody() -> String
    {
        return "Hey, I just got " + DTO.CouponDescription + " @" + DTO.Store + ". Download TellTenMobile app and tell your friends to receive the coupon!"
    }
    
    //MARK: getting data from address book
//function for getting user contacts from contact book--------------##########################----------------
    func getAllContactsFromAddresBook () -> NSMutableArray
    {
        let phoNumbArr = NSMutableArray()
        let nameArr = NSMutableArray()
        
        //get all contacts in array-----------------------------------
        let allContacts = ABAddressBookCopyArrayOfAllPeople(addressBookRef).takeRetainedValue() as Array
        
        //fetch all name from array-------------------
        for record:ABRecordRef in allContacts
        {
            let contactPerson: ABRecordRef = record
            
            //let lastName: String? = ABRecordCopyValue(contactPerson, kABPersonLastNameProperty).takeRetainedValue()as NSString as String
            
            //fetch all phone number from contact list ------
            let phonesRef: ABMultiValueRef = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef
            for var i:Int = 0; i < ABMultiValueGetCount(phonesRef); i++
            {
                print(phonesRef,[i])
                
                if (ABMultiValueCopyLabelAtIndex(phonesRef, i) != nil)
                {
                    let label: NSString = ABMultiValueCopyLabelAtIndex(phonesRef, i).takeRetainedValue() as NSString
                    let value: NSString? = ABMultiValueCopyValueAtIndex(phonesRef, i).takeRetainedValue() as? NSString
                    
                    if #available(iOS 8.0, *)
                    {
                        if(label.length > 0 && value?.length > 0)
                        {
                            print(phonesRef)
                            
                            
                            
                            phoNumbArr.addObject(value!)
                            if let firstName: NSString = ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty)?.takeRetainedValue() as? NSString
                            {
                                print(firstName)
                                contactNmaePhonDic[firstName] = value
                                nameArr.addObject(firstName)
                            }
                            break
                        }
                    }
                    else
                    {
                        phoNumbArr.addObject(value!)
                        print(phoNumbArr)
                    }
                    
                    
                }
                
            }
        }
        
        //sort array alphabatically---------
        nameArr.sortUsingSelector("localizedCaseInsensitiveCompare:")
        
        //add phone book to array -----
        let contactNmaeArr = NSMutableArray()
        contactNmaeArr.addObjectsFromArray([nameArr,phoNumbArr])
        print(contactNmaeArr)
        return contactNmaeArr
    }
    
    //navBackButtton
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
    
    
    //not authorize to acces phone book 
    func notAuthorizeAccessContact ()
    {
        let authLbl = UILabel(frame: CGRectMake(10, customNavigationBartViewobj.frame.height + 100, self.view.frame.width - 20, 100))
        authLbl.text  = "Please go to Setting and find TellTen App.\n\n Tap on it and Enable Contact "
        authLbl.numberOfLines = 5
        authLbl.textAlignment = NSTextAlignment.Center
        self.view.addSubview(authLbl)
        
        let SeettingButoon = UIButton(frame: CGRectMake(100, authLbl.frame.origin.y + authLbl.frame.height + 20, self.view.frame.width - 200, 40))
        SeettingButoon.setTitle("Setting", forState: UIControlState.Normal)
        SeettingButoon.backgroundColor = CustomColor().customColorWithBlue()
        SeettingButoon.addTarget(self, action: "openSettingFunction", forControlEvents: UIControlEvents.TouchUpInside)
        SeettingButoon.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.view.addSubview(SeettingButoon)
    }
    
    func openSettingFunction ()
    {
        if #available(iOS 8.0, *) {
            UIApplication.sharedApplication().openURL((NSURL(string:UIApplicationOpenSettingsURLString)!))
        } else {
            let alert = UIAlertView(title: "TellTen", message: " Settings >> TellTenMobile >> Enable Contact", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





