//
//  1minInterfaceController.swift
//  NapTimerWatch Extension
//
//  Created by 曽和寛貴 on 2017/03/23.
//  Copyright © 2017年 2017 Misky. All rights reserved.
//

import WatchKit
import Foundation


class MinInterfaceController: WKInterfaceController {
    
    @IBOutlet var myCountDownT: WKInterfaceTimer!
    @IBOutlet var napButton1: WKInterfaceButton!
    
    var myFlagA: Bool = false
    let dateSave1 = UserDefaults.standard
    var myStartDate1: Date!
    
    override func awake(withContext context: Any?) {
    super.awake(withContext: context)
        
        let timerMinA = dateSave1.integer(forKey: "timerMinA")
        
        if (timerMinA == 0){
            dateSave1.set(1, forKey: "timerMinA")
        }
        stopCountA()
    }
    
    @IBAction func StartActionFirst() {
        
        if myFlagA{
            stopCountA()
        }else {
            startCountA()
        }
    }
    
    func startCountA (){
        myStartDate1 = Date()
        
        let timerMinA = dateSave1.integer(forKey: "timerMinA")
        let countA = timerMinA * 60
        myCountDownT.setDate(Date(timeIntervalSinceNow: TimeInterval(countA)) as Date)
        
        myCountDownT.start()
        myFlagA = true
        napButton1.setTitle("リセット")
    }
    
    func stopCountA (){
        
        let timerMinA = dateSave1.integer(forKey: "timerMinA")
        let countA = timerMinA * 60 + 1
        myCountDownT.setDate(Date(timeIntervalSinceNow: TimeInterval(countA)) as Date)
        
        myCountDownT.stop()
        myFlagA = false
        napButton1.setTitle("お昼寝開始")
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
