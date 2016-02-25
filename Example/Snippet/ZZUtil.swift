//
//  ZZUtil.swift
//  Common
//
//  Created by 张忠 on 15/6/24.
//  Copyright (c) 2015年 zhong zhang. All rights reserved.
//

import UIKit

class ZZUtil: NSObject {
    // 700 -> 11:40  3661 -> 1:01:01
    static func remainTimeToString(rt:Int) -> String {
        let ss = rt % 60
        let mm = rt / 60 % 60
        let hh = rt / 3600
        var re = ""
        if hh > 0 {
            re += "\(hh):"
        }
        func intToTwo(v:Int) -> String {
            if v < 10 {
                return "0\(v)"
            }
            return "\(v)"
        }
        re += "\(intToTwo(mm)):\(intToTwo(ss))"
        return re
    }
    
    // 111 -> 111B  9999 -> 9.9K
    static func fileSizeToString(size:Int) -> String {
        var double = Double(size)
        let array = ["B","K","M","G","T"]
        for var i = 0 ; i < array.count ; i++ {
            if double / 1024 < 1 {
                if i == 0 {
                    return String(format: "%.0f%@", double,array[i])
                }
                return String(format: "%.1f%@", double,array[i])
            }
            double = double / 1024
        }
        return String(format: "%.1fT", double)
    }
    
    //将一个图片的颜色替换为另一个颜色
    static func imageWithColor(image:UIImage,color:UIColor) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(image.size,false, image.scale)
        let ref = UIGraphicsGetCurrentContext()
        CGContextTranslateCTM(ref, 0, image.size.height)
        CGContextScaleCTM(ref, 1.0, -1.0)
        CGContextSetBlendMode(ref, CGBlendMode.Normal)
        let rect = CGRectMake(0, 0, image.size.width, image.size.height)
        CGContextClipToMask(ref, rect, image.CGImage)
        color.setFill()
        CGContextFillRect(ref, rect)
        let re = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return re
    }
}

struct RegexHelper {
    let regex: NSRegularExpression?
    init(_ pattern: String) {
        do {
            regex = try NSRegularExpression(pattern: pattern,
                options: .CaseInsensitive)
        } catch  {
            regex = nil
        }
    }
    func match(input: String) -> Bool {
        if let matches = regex?.matchesInString(input,
            options: [],
            range: NSMakeRange(0, input.characters.count)) {
                return matches.count > 0
        } else {
            return false
        }
    }
}