//
//  ZZStart.swift
//  Common
//
//  Created by mutao iMac 1 on 15/1/21.
//  Copyright (c) 2015年 zhong zhang. All rights reserved.
//

import Foundation

private let sharedInstance = ZZStart()

class ZZStart {
    class var instance : ZZStart {
        return sharedInstance
    }
    
    //配置评分，友盟和版本设置
    func start(appID:String,umengAppKey:String){
        Appirater.setAppId(appID)
        Appirater.setDaysUntilPrompt(7)
        Appirater.setUsesUntilPrompt(5)
        Appirater.setSignificantEventsUntilPrompt(-1)
        Appirater.setTimeBeforeReminding(2)
        Appirater.setDebug(false)
        Appirater.appLaunched(true)
        
        MobClick.startWithAppkey(umengAppKey)
        iVersion.sharedInstance().appStoreID = UInt(Int(appID)!)
        iVersion.sharedInstance().checkIfNewVersion()
        
        ZZSetting.instance.appID = appID
    }
}