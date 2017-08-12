//
//  InterfaceController.swift
//  NapTimerWatch Extension
//
//  Created by maji on 2017/03/20.
//  Copyright © 2017年 2017 Misky. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var myCountDownTimer: WKInterfaceTimer!
    @IBOutlet weak var myTimerButton: WKInterfaceButton!

    
    var myCountFlag = false
    
    let defaults = UserDefaults.standard
    
    var myTimerStartDate: NSDate!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let timerCountMin = defaults.integer(forKey: "timerCountMin")
        //初期設定できてなければここでする
        if timerCountMin == 0 {
            defaults.set(18, forKey: "timerCountMin")
        }
        
        stopCountDown()
    }
    
    
    @IBAction func StartAction() {
        
        // カウントのフラグがtrueであれば停止し、falseであれば開始する.
        if myCountFlag {
            stopCountDown()
        } else {
            startCountDown()
        }
    }
    
    func startCountDown() {
        
        // カウントダウンを開始した時間を記録しておく.
        myTimerStartDate = NSDate()
        
        // 保存されている経過時間分だけタイマーを進めた状態で時間を設定し直す.
        let timerCountMin = defaults.integer(forKey: "timerCountMin")
        let cnt = timerCountMin * 60
        myCountDownTimer.setDate(NSDate(timeIntervalSinceNow: TimeInterval(cnt)) as Date)
        
        // タイマーの開始処理を行う.
        myCountDownTimer.start()
        myCountFlag = true
        myTimerButton.setTitle("キャンセル")
        
    }
    
    func stopCountDown() {
        
        // タイマーの停止処理を行う.
        myCountDownTimer.stop()
        myTimerButton.setTitle("お昼寝開始")
        myCountFlag = false
        
        // タイマーをセットし直す.
        let timerCountMin = defaults.integer(forKey: "timerCountMin")
        let cnt = timerCountMin * 60 + 1
        
        myCountDownTimer.setDate(NSDate(timeIntervalSinceNow: TimeInterval(cnt)) as Date)
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
