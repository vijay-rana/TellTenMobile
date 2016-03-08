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
    
    
    //-----------------------cryptoString--------------end
    
    func requestForStoreDataFromServer()
    {
        
        //check network connection----------------
        
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            
            
            let urlString = "http://www.telltenmobile.com/web/ws/storelist.php?s=" + (cryptoString() as String)
            print(urlString)
            
            let urlStore = NSURL(string: urlString)
            let urlRequset = NSURLRequest(URL:urlStore!)
            
            
            NSURLConnection.sendAsynchronousRequest(urlRequset, queue: NSOperationQueue.mainQueue()) { (response : NSURLResponse?, data : NSData?, Error : NSError?) -> Void in
                
                do {
                    let dictData = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
                    
                    // print("data",dictData)
                    //print("Stores",dictData.valueForKey("stores"))
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
                    print("dict stors",storeDataArray)
                    storeDataStruct.structStoreDataArray = storeDataArray
                    // use anyObj here
                } catch {
                    print("json error: \(error)")
                    let alert = UIAlertView(title: "TellTenMobile", message: "There is a Problem in getting store list", delegate: nil, cancelButtonTitle: "Ok")
                    alert.show()
                    
                }
                
                
            }

            
            
        } else {
            print("Not reachable")
            
            let alrt = UIAlertView(title: "No Internet Connection", message: "Please check your Internet Connection", delegate: nil, cancelButtonTitle: "Ok")
            alrt.show()
           
        }
        
        
        
    }
    //---------------------------requestForStoreDataFromServer----------- end------------
  
    func requestForCouponFromServer(stroreID:NSString)
    {
        
        
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        if reachability.isReachable() {
            
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
                    
                    ChooseStoreViewController().getCouponsArry()
                    
                } catch {
                    print("json error: \(error)")
                    let alert = UIAlertView(title: "TellTenMobile", message: "There is a Problem in getting store list", delegate: nil, cancelButtonTitle: "Ok")
                    alert.show()
                    
                }
                
                
            }

            
        }
        else{
            let alert = UIAlertView(title: "No Internet Connection", message: "Please check your Internet Connection ", delegate: nil, cancelButtonTitle: "Ok")
            alert.show()
            
        }
        
       
        
        
    }
    
//---------------------------requestForCouponFromServer----------- end------------
    
    //creating block function---------------
    
   
    func requestNetwork(urlStringGet:NSString,httpBody: NSString, completions: (result : NSDictionary) -> Void , failure: (errorMassege : NSString) -> Void)
    {
      
        let reachability: Reachability
        do {
            reachability = try Reachability.reachabilityForInternetConnection()
        } catch {
            print("Unable to create Reachability")
            return
        }
        
        
        if reachability.isReachable() {
            if reachability.isReachableViaWiFi() {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
            
            let urlString = (urlStringGet as String) //+ "?s=" + (cryptoString() as String)
            print("this url",urlString)
            
            let urlStore = NSURL(string: urlString)
            let urlRequset = NSMutableURLRequest(URL:urlStore!)
            urlRequset.HTTPMethod = "POST"
            let httpBodyCoupon : NSString = "&s=" + (cryptoString() as String) + "&numberlist=" + (httpBody as String)  +  "&couponID=" + (storeDataStruct.couponId as String)
            print(httpBodyCoupon)
            
            // PostDataAsyc(urlStringGet as String, data:httpBodyCoupon as String)
            
            
            let postString = httpBodyCoupon as String
            urlRequset.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
            
            
            
            
            
            let task = NSURLSession.sharedSession().dataTaskWithRequest(urlRequset) {
                responseData, response, error in
                
                
                
                if error != nil {
                    
                    return
                }
                
                do {
                    if(responseData != nil)
                    {
                        let dictData = try NSJSONSerialization.JSONObjectWithData(responseData!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
                        //  print(dictData)
                        completions(result: dictData)
                        
                    }
                    
                    
                }
                catch {
                    print("json error: \(error)")
                    let alert = UIAlertView(title: "TellTenMobile", message:"json error: \(error)", delegate: nil, cancelButtonTitle: "Ok")
                    alert.show()
                    
                    failure(errorMassege: "json error: \(error)")
                    
                }
                
                
            }
            task.resume()
  
        } else {
            print("Not reachable")
             failure(errorMassege: "No Internet Connection")
        }
        
        
    
}




}






struct storeDataStruct {
    static var structStoreDataArray = NSMutableArray()
    static var structCouponsDataArray = NSMutableArray()
    static var couponId = NSString()
    static var couponCode = NSString()
    
}




