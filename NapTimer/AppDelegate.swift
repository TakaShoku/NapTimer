//
//  AppDelegate.swift
//  NapTimer
//
//  Created by maji on 2017/03/20.
//  Copyright © 2017年 2017 Misky. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 登録する
        let settings = UIUserNotificationSettings(types: [.alert, .sound], categories: nil)
        application.registerUserNotificationSettings(settings);
        application.registerForRemoteNotifications()
        
        // バックグラウンドでの音の再生を許可
        let audioSession : AVAudioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryAmbient)
        } catch let error {
            print("\(error)")
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
    
    //ファアグランド　ここに来る
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        print("通知　ここに来る")
        if(application.applicationState == .inactive || application.applicationState == .active){
            // アプリがバックグラウンドにいる状態で、Push通知から起動したとき
            // アプリ起動時にPush通知を受信したとき
            // print("アプリ起動時にPush通知を受信したとき")
            
            // UIAlertControllerを作成する.
            // let myAlert: UIAlertController = UIAlertController(title: "お昼寝終わり", message: "起きてください。", preferredStyle: .alert)
            
            // OKのアクションを作成する.
            // let myOkAction = UIAlertAction(title: "音楽を止める", style: .default) { action in
            //     print("Action OK!!")
            // }
            
            // OKのActionを追加する.
            // myAlert.addAction(myOkAction)
            
            // UIAlertを発動する.
            // self.window?.rootViewController?.present(myAlert, animated: true, completion: nil)
            
            
        }else if(application.applicationState == .background){
            // アプリがバックグラウンドにいる状態でPush通知を受信したとき
            print("アプリがバックグラウンドにいる状態でPush通知を受信したとき②")
            
        }else{
            print("アプリがバックグラウンドにいる状態でPush通知を受信したとき③")
        
        }
        
    }
}

class DateUtils {
    class func dateFromString(string: String, format: String) -> NSDate {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: string)! as NSDate
    }
    
    class func stringFromDate(date: NSDate, format: String) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date as Date)
    }
}


