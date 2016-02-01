//
//  StoreRequest.swift
//  TellTenMobile
//
//  Created by kbs on 1/28/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import UIKit

class StoreRequest: NSObject,NSURLConnectionDataDelegate {

   
    func cryptoString() ->NSString
    {
        //get current date
        let currentDate = NSDate()
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "EST")
        let dateString = dateFormatter.stringFromDate(currentDate)
        let cryptoString = dateString + "TellTenMobile"
        print(cryptoString)
        
        //convert MD5 formate
        let digest = md5(string:cryptoString as String)
        return digest
        
    }
    
    func requestForStoreDataFromServer()
    {
        let urlString = "http://www.telltenmobile.com/web/ws/storelist.php?s=" + (cryptoString() as String)
        print(urlString)
        
        let urlStore = NSURL(string: urlString)
        let urlRequset = NSURLRequest(URL:urlStore!)
        
    
        NSURLConnection.sendAsynchronousRequest(urlRequset, queue: NSOperationQueue.mainQueue()) { (response : NSURLResponse?, data : NSData?, Error : NSError?) -> Void in
      
            do {
                let dictData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
              
               // print("data",dictData)
              //  print("Stores",dictData.valueForKey("stores"))
                let storesArray = dictData.valueForKey("stores") as? NSArray
                //print(storesArray)
                let imgArray = NSMutableArray()
                let storeIDArray = NSMutableArray()
                let storeNameArray = NSMutableArray()
                for (var i = 0 ; i < storesArray?.count; i++)
                {
                    let storeNameDict = storesArray?.objectAtIndex(i) as? NSDictionary
                    imgArray.addObject((storeNameDict?.valueForKey("imageURL"))!)
                    storeIDArray.addObject((storeNameDict?.valueForKey("storeID"))!)
                    storeNameArray.addObject((storeNameDict?.valueForKey("storeName"))!)
                    
                    
                }
                
                let storeDataArray = NSMutableArray()
                storeDataArray.addObject([imgArray,storeIDArray,storeNameArray])
                storeDataStruct.structStoreDataArray = storeDataArray
                // use anyObj here
            } catch {
                print("json error: \(error)")
                let alert = UIAlertView(title: "TellTenMobile", message: "There is a Problem in getting store list", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
                
            }

            
        }
        
    }  
  
    func requestForCouponFromServer(stroreID:NSString)
    {
       
        let urlString = "http://www.telltenmobile.com/web/ws/couponlist.php?s=" + (cryptoString() as String) + "&storeID=" + (stroreID as String)
        print(urlString)
        
        
        let urlStore = NSURL(string: urlString)
        let urlRequset = NSURLRequest(URL:urlStore!)
        
        
        NSURLConnection.sendAsynchronousRequest(urlRequset, queue: NSOperationQueue.mainQueue()) { (response : NSURLResponse?, data : NSData?, Error : NSError?) -> Void in
            
            do {
                let dictData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                
                 //print("Coupon data",dictData)
                
                let storesArray = dictData.valueForKey("coupons") as? NSArray
                //print(storesArray)
                let imgArray = NSMutableArray()
                let storeIDArray = NSMutableArray()
                let storeNameArray = NSMutableArray()
                for (var i = 0 ; i < storesArray?.count; i++)
                {
                    let storeNameDict = storesArray?.objectAtIndex(i) as? NSDictionary
                    imgArray.addObject("no image")
                    storeIDArray.addObject((storeNameDict?.valueForKey("couponID"))!)
                    storeNameArray.addObject((storeNameDict?.valueForKey("description"))!)
                    
                    
                }
                
                let storeDataArray = NSMutableArray()
                storeDataArray.addObject([imgArray,storeIDArray,storeNameArray])
                 storeDataStruct.structCouponsDataArray = storeDataArray
                print("Coupon data",storeDataStruct.structStoreDataArray)
                ChooseStoreViewController().getCouponsArry()
              
            } catch {
                print("json error: \(error)")
                let alert = UIAlertView(title: "TellTenMobile", message: "There is a Problem in getting store list", delegate: nil, cancelButtonTitle: "Ok")
                alert.show()
                
            }
            
            
        }

        
    }
}


struct storeDataStruct {
    static var structStoreDataArray = NSMutableArray()
    static var structCouponsDataArray = NSMutableArray()
}




