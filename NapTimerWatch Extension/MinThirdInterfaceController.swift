//
//  MinThirdInterfaceController.swift
//  NapTimer
//
//  Created by 曽和寛貴 on 2017/03/24.
//  Copyright © 2017年 2017 Misky. All rights reserved.
//

import WatchKit
import Foundation


class MinThirdInterfaceController: WKInterfaceController {
    
    @IBOutlet var myTimerThird: WKInterfaceTimer!
    @IBOutlet var myTimerButtonThird: WKInterfaceButton!
    
    var myFlagThird: Bool = false
    let defaultsThird = UserDefaults.standard
    var myTimerDateThird: Date!

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
       
        let timerCountThird = defaultsThird.integer(forKey: "timerCountThird")
        if(timerCountThird == 0){
            defaultsThird.set(12, forKey: "timerCountThird")
        }
        stopThird()
       
    }
    
    @IBAction func StartActionThird() {
        
        if myFlagThird {
            stopThird()
        }else {
            startThird()
        }
    }
    
    func startThird() {
        
        myTimerDateThird = Date()
        
        let timerCountThird = defaultsThird.integer(forKey: "timerCountThird")
        let cntThird = timerCountThird * 60
        myTimerThird.setDate(Date(timeIntervalSinceNow: TimeInterval(cntThird)) as Date)
        
        myTimerThird.start()
        myFlagThird = true
        myTimerButtonThird.setTitle("リセット")
        
    }
    
    func stopThird() {
        
        myTimerThird.stop()
        myFlagThird = false
        myTimerButtonThird.setTitle("お昼寝開始")
        
        let timerCountThird = defaultsThird.integer(forKey: "timerCountThird")
        let cntThird = timerCountThird * 60 + 1
        myTimerThird.setDate(Date(timeIntervalSinceNow: TimeInterval(cntThird)) as Date)
        
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
