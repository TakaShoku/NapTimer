//
//  MinSecondInterfaceController.swift
//  NapTimer
//
//  Created by 曽和寛貴 on 2017/03/24.
//  Copyright © 2017年 2017 Misky. All rights reserved.
//

import WatchKit
import Foundation


class MinSecondInterfaceController: WKInterfaceController {

    
    @IBOutlet var myCountDownSecond: WKInterfaceTimer!
    @IBOutlet var myTimerButtonSecond: WKInterfaceButton!
    
    var myFlagSecond: Bool = false
    let defaultsSecond = UserDefaults.standard
    var startDateSecond: Date!
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let timeCountSecond = defaultsSecond.integer(forKey: "timeCountSecond")
        if(timeCountSecond == 0){
            defaultsSecond.set(6, forKey: "timeCountSecond")
        }
        stopCountSecond()
    }

    @IBAction func StartActionSecond() {
        if myFlagSecond {
            stopCountSecond()
        }else {
            startCountSecond()
        }
    }
    
    func startCountSecond() {
        startDateSecond = Date()
        
        let timeCountSecond = defaultsSecond.integer(forKey: "timeCountSecond")
        let cntSecond = timeCountSecond * 60
        
        myCountDownSecond.setDate(Date(timeIntervalSinceNow: TimeInterval(cntSecond)) as Date)
        
        myCountDownSecond.start()
        myFlagSecond = true
        myTimerButtonSecond.setTitle("リセット")
    }
    
    func stopCountSecond() {
        
        myCountDownSecond.stop()
        myFlagSecond = false
        myTimerButtonSecond.setTitle("お昼寝開始")
        
        let timeCountSecond = defaultsSecond.integer(forKey: "timeCountSecond")
        let cntSecond = timeCountSecond * 60 + 1
        
        myCountDownSecond.setDate(Date(timeIntervalSinceNow: TimeInterval(cntSecond)) as Date)
        

        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
