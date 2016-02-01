//
//  ViewController.swift
//  TellTenMobile
//
//  Created by kbs on 1/18/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import UIKit
import AddressBook

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
   var addressBookRef : ABAddressBook!

    

    var contactNmaePhonArray = NSMutableArray()
    
    let contactListTableView = UITableView()

    let customNavigationBartViewobj = UIView()
    
    let rowIndexNumberarr = NSMutableArray()
    
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
        var err: Unmanaged<CFError>? = nil
        
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
        contactListTableView.reloadData()
         rowIndexNumberarr.removeAllObjects()
    }
    
    
//        check address book authorization
    func checkAddressBookAuthorization ()
    {
        
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        
        switch authorizationStatus {
        case .Denied, .Restricted:
            //1
            print("Denied")
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
        let tableViewCells = tableView.dequeueReusableCellWithIdentifier("NameCell", forIndexPath: indexPath) as! ContacListTableViewCell
       
        tableViewCells.layer.shadowOffset = CGSize(width: 3, height: 3)
        tableViewCells.layer.shadowOpacity = 0.3
        tableViewCells.layer.shadowRadius = 2
        
        tableViewCells.selectionStyle = UITableViewCellSelectionStyle.None
        tableViewCells.backgroundColor = UIColor.clearColor()
        
        tableViewCells.creatingSubviewForCell()
       tableViewCells.contactImageView()
        
        let contactName = contactNmaePhonArray.objectAtIndex(0).objectAtIndex(indexPath.row) as! String
        tableViewCells.contactNameLabel(contactName)
        
        return tableViewCells
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         addIndexNumber(indexPath)
        let cellObj = tableView.cellForRowAtIndexPath(indexPath) as! ContacListTableViewCell
        cellObj.changeImageFromSelction(true)
    
    
    }
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        removeIndexPath(indexPath)
        let cellObj = tableView.cellForRowAtIndexPath(indexPath) as! ContacListTableViewCell
        cellObj.changeImageFromSelction(false)
        
    }
    
   
    func addIndexNumber (rowIndexPath: NSIndexPath)
    {
        
        rowIndexNumberarr.addObject(rowIndexPath.row)
       
    }
    func removeIndexPath (rowIndexPath: NSIndexPath)
    {
        
        if(rowIndexNumberarr.containsObject(rowIndexPath.row))
        {
            let indexCell = rowIndexNumberarr.indexOfObject(rowIndexPath.row)
            rowIndexNumberarr.removeObjectAtIndex(indexCell)
        }
        
        
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
        if(rowIndexNumberarr.count > 9)
        {
            self.navigationController?.pushViewController(CouponViewController(), animated: true)
        }
        else
        {
            let alertView = UIAlertView(title: "Tell Ten ", message: "Please select atleast ten Contacts", delegate: nil, cancelButtonTitle: "Ok")
                alertView.show()
        }
        
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
//
            if let firstName: NSString = ABRecordCopyValue(contactPerson, kABPersonFirstNameProperty)?.takeRetainedValue() as? NSString  {
             nameArr.addObject(firstName)
            }

            
           
            //let lastName: String? = ABRecordCopyValue(contactPerson, kABPersonLastNameProperty).takeRetainedValue()as NSString as String
           
         
//fetch all phone number from contact list ------
//            let phonesRef: ABMultiValueRef = ABRecordCopyValue(contactPerson, kABPersonPhoneProperty).takeRetainedValue() as ABMultiValueRef
//           // var phonesArray  = Array<Dictionary<String,String>>()
//            for var i:Int = 0; i < ABMultiValueGetCount(phonesRef); i++ {
//                let label: NSString = ABMultiValueCopyLabelAtIndex(phonesRef, i).takeRetainedValue() as NSString
//                let value: String = ABMultiValueCopyValueAtIndex(phonesRef, i).takeRetainedValue() as! NSString as String
//                
//                
//                
//                if #available(iOS 8.0, *) {
//                    if(label.containsString("Mobile") == true)
//                    {
//                        // print(firstName,"==>",value)
//                        phoNumbArr.addObject(value)
//                    }
//                } else {
//                    // Fallback on earlier versions
//                    
//                     phoNumbArr.addObject(value)
//                }
//            }
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
            let alert = UIAlertView(title: "TellTen", message: "Can't open Setting Please upgrade your iOS version", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}





