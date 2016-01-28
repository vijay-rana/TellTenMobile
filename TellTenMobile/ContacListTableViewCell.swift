//
//  ContacListTableViewCell.swift
//  TellTenMobile
//
//  Created by kbs on 1/19/16.
//  Copyright © 2016 kbs. All rights reserved.
//

import UIKit

class ContacListTableViewCell: UITableViewCell {

    //let contactNameLbl = UILabel()
    let contactImgView = UIView()
    let cellBaseView = UIView()
    
    let imageViewTick = UIImageView()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
     
    }
    

   
    
    func creatingSubviewForCell()
    {
         cellBaseView.frame = CGRectMake(10, 5, self.frame.width - 20 , self.frame.height - 10)
        cellBaseView.backgroundColor = UIColor.whiteColor()
        self.contentView.addSubview(cellBaseView)
        
    }
    
    func contactImageView()
    {
        contactImgView.frame =  CGRectMake(10,5, 60, cellBaseView.frame.height)
        contactImgView.backgroundColor = CustomColor().customColorWithRed()
        self.contentView.addSubview(contactImgView)
        
        //imageView
         imageViewTick.frame = CGRectMake(contactImgView.frame.width / 2 - 15, contactImgView.frame.height / 2 - 15, 30, 30)
        imageViewTick.image = UIImage(named: "UncheckArrow")
        contactImgView.addSubview(imageViewTick)
    }
    
    func changeImageFromSelction (Selection:Bool)
    {
        if(Selection == true)
        {
            self.imageViewTick.image = UIImage(named: "checkArrow")
          
        }
        else
        {
            imageViewTick.image = UIImage(named: "UncheckArrow")
        }
        
    }
 
    func contactNameLabel (contactName: NSString)
    {
         //label
         let contactNameLbl = UILabel(frame: CGRectMake(contactImgView.frame.width + 20, 5, self.frame.width - contactImgView.frame.width - 50,  cellBaseView.frame.height ))
        contactNameLbl.text = contactName as String
        self.contentView.addSubview(contactNameLbl)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
