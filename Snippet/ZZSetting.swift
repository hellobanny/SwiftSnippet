//
//  ZZSetting.swift
//  Common
//  设置页面，提供反馈问题，打分，分享，和其他推广的App列表
//  Created by mutao iMac 1 on 15/1/21.
//  Copyright (c) 2015年 zhong zhang. All rights reserved.
//

import UIKit
import MessageUI

private let sharedInstance = ZZSetting()

class ZZSetting: NSObject,  MFMailComposeViewControllerDelegate,UINavigationControllerDelegate {
    class var instance : ZZSetting {
        return sharedInstance
    }
    
    //let db = NSLocalizedStringFromTableInBundle("Feedback", "ZZCommonLocalizable", NSBundle.mainBundle, nil)
    let names = [NSLocalizedString("Feedback",tableName:"ZZCommonLocalizable",comment:"Feedback"),NSLocalizedString("Rate App",tableName:"ZZCommonLocalizable",comment:"Rate App"),NSLocalizedString("Share App",tableName:"ZZCommonLocalizable",comment:"Share App")]
   
    var appID = "" //设置该应用的AppID
    
    //设置的数量,这里有3个，反馈问题，打分，分享App
    func getFRSCount() -> Int {
        return 3
    }
    
    //设置的Cell
    func getFRSCell(index:Int,cell:UITableViewCell) -> UITableViewCell {
        cell.textLabel?.text = names[index]
        return cell
    }
    
    //设置cell被点击时的事件
    func clickFRSCell(index:Int,vc:UIViewController) {
        if index == 0 {//report bug
            if MFMailComposeViewController.canSendMail(){
                let mvc = MFMailComposeViewController()
                mvc.mailComposeDelegate = self
                mvc.setSubject(NSLocalizedString("Feedback",comment:"Feedback"))
                mvc.setToRecipients(["hellobanny@gmail.com"])
                var prodName = ""
                let obj: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleName"]
                if let name = obj as? String {
                    prodName = name
                }
                var version = ""
                let vobj: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleShortVersionString"]
                if let ver = vobj as? String{
                    version = ver
                }
                let device = UIDevice.currentDevice()
                mvc.setMessageBody("\n\n\n-----------------------------\n Name: \(prodName)\n Device: \(device.localizedModel) \n OS Version:\(device.systemVersion)\n App Version:\(version)\n", isHTML: false)
                mvc.popoverPresentationController?.sourceView = vc.view
                mvc.popoverPresentationController?.sourceRect = vc.view.bounds
                vc.presentViewController(mvc, animated: true, completion: nil)
            }
            else {
                let alertController = UIAlertController(title: "Notice!", message: "Your device doesn't support send email.", preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "OK", style: .Cancel) { (action) in
                    print(action)
                }
                alertController.addAction(cancelAction)
                vc.presentViewController(alertController, animated: true, completion: nil)
            }
        }
        else if index == 1 {//rate app
            Appirater.rateApp()
        }
        else if index == 2 {//tell friend
            var prodName = ""
            let obj: AnyObject? = NSBundle.mainBundle().infoDictionary!["CFBundleName"]
            if let name = obj as? String {
                prodName = name
            }
            let text = "\(prodName) https://itunes.apple.com/app/id\(appID)"
            let items = [text]
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            activityVC.excludedActivityTypes = [UIActivityTypeAssignToContact]
            activityVC.popoverPresentationController?.sourceView = vc.view
            activityVC.popoverPresentationController?.sourceRect = vc.view.bounds
            vc.presentViewController(activityVC, animated: true, completion: nil)
        }

    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?){
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
}