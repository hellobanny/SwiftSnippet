//
//  UserGuide.swift
//  MapMeasurePro
//
//  Created by mutao iMac 1 on 14/10/23.
//  Copyright (c) 2014年 zhong zhang. All rights reserved.
//

import Foundation

private let _SingletonInstanceUserGuide = ZZUserGuide()

class Guide{
    var key:String
    var value:String
    
    init(k:String,v:String){
        key = k
        value = v
    }
}

class ZZUserGuide {
    
    var allGuides = [Guide]()
    
    class var instance:ZZUserGuide{
        return _SingletonInstanceUserGuide
    }
    
    //显示一个提示，如果必要的话
    func showIfRequireGuide(key:String,turnOffNow:Bool){
        if !self.isGuideFinish(key) {
            for gd in allGuides{
                if gd.key == key {
                    SweetAlert().showAlert(NSLocalizedString("Tips",tableName:"ZZCommonLocalizable",comment:"Tips"), subTitle: gd.value, style: AlertStyle.Warning)
                    if turnOffNow {
                        self.turnOffGuild(key)
                    }
                }
            }
        }
    }
    
    func isGuideFinish(key:String)-> Bool{
        return NSUserDefaults.standardUserDefaults().boolForKey(key)
    }
    
    func turnOffGuild(key:String){
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setBool(true, forKey: key)
        ud.synchronize()
    }
    
    func resetGuide(key:String){
        let ud = NSUserDefaults.standardUserDefaults()
        ud.setBool(false, forKey: key)
        ud.synchronize()
    }
    
    func resetGuides(){
        let ud = NSUserDefaults.standardUserDefaults()
        for guide in allGuides{
            ud.setBool(false, forKey: guide.key)
        }
        ud.synchronize()
    }
}