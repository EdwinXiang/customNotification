//
//  AppDelegate.swift
//  customNotifcaiton
//
//  Created by bene on 2019/1/23.
//  Copyright © 2019 bene. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        // 定义消息内容
        let content = UNMutableNotificationContent()
        content.title = "爸爸给你来电话啦"
        content.body = "今天吃什么呢？"
        content.userInfo = ["MEETING_ID" : "meetingID",
                            "USER_ID" : "userID" ]
        
        // 设置声音
        let sound = UNNotificationSound.init(named: UNNotificationSoundName.init("video_alert.caf"))
        content.sound = sound
        
        content.categoryIdentifier = "customNotification"
        //创建触发时间
        var datecomponents = DateComponents()
        datecomponents.calendar = Calendar.current
        
        // 一周的第几天 触发模式
//        datecomponents.weekday = 4
//        datecomponents.hour = 11
//        let trigger = UNCalendarNotificationTrigger(dateMatching: datecomponents, repeats: true)
        
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 10, repeats: false)
        // 注册通知请求
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // 注册可操作的通知类型
        let acceptAction = UNNotificationAction(identifier: "aceept_action", title: "接受", options: UNNotificationActionOptions.init(rawValue: 0))
        let declineAction = UNNotificationAction.init(identifier: "decline_action", title: "拒绝", options: UNNotificationActionOptions.init(rawValue: 0))
        let notificationCenter = UNUserNotificationCenter.current()
        
        // 请求授权
        notificationCenter.requestAuthorization(options: [.alert,.sound,.badge]) { (granted, error) in
            if error == nil {
                print("授权成功")
            }
        }
        notificationCenter.delegate = self
        if #available(iOS 11.0, *) {
            let meetingInviteCategory = UNNotificationCategory(identifier: "customNotification", actions: [acceptAction,declineAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "", options: .customDismissAction)
            notificationCenter.setNotificationCategories([meetingInviteCategory])
        } else {
            // Fallback on earlier versions
        }
        
        // 发送
        notificationCenter.add(request) { (error) in
            if error == nil {
                print("消息发送成功")
            } else {
                print("消息发送失败")
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        let meetingID = userInfo["MEETING_ID"] as! String
        let userID = userInfo["USER_ID"] as! String
        
        switch response.actionIdentifier {
        case "aceept_action":
            print("执行了接受按钮")
        case "decline_action":
            print("执行了拒绝按钮")
        default:
            break
        }
        completionHandler()
    }
}


