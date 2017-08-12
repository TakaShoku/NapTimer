//
//  ViewController.swift
//  NapTimer
//
//  Created by maji on 2017/03/20.
//  Copyright © 2017年 2017 Misky. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController,AVAudioPlayerDelegate {
    
    //時間計測用の変数.
    var cnt : Int = 5
    
    var audioPlayer : AVAudioPlayer!
    
    //タイマー.
    var timer : Timer!
    
    //タイマーフラグ
    var timerFlg = false
    
    @IBOutlet weak var startstopButton: UIButton!
    
    @IBOutlet weak var timerLabel: UILabel!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var timerCountMin = defaults.integer(forKey: "timerCountMin")
        
        //初期設定できてなければここでする
        if(timerCountMin == 0){
            defaults.set(18, forKey: "timerCountMin")
            timerCountMin = 18
        }
        cnt = timerCountMin * 60
        
        // 再生する audio ファイルのパスを取得
        let audioPath = Bundle.main.path(forResource: "alarm", ofType:"mp3")!
        let audioUrl = URL(fileURLWithPath: audioPath)
        
        
        // auido を再生するプレイヤーを作成する
        var audioError:NSError?
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioUrl)
        } catch let error as NSError {
            audioError = error
            audioPlayer = nil
        }
        
        // エラーが起きたとき
        if let error = audioError {
            print("Error \(error.localizedDescription)")
        }
        
        initTimerLabelDisplay()
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pushStartStop(_ sender: Any) {
        
        //timerが動いてるなら.
        if (timerFlg) {
            print("停止ボタン")
            
            startstopButton.setTitle("タイマー開始", for: UIControlState.normal)
            
            initTimerLabelDisplay()
            audioPlayer.stop()
            
            //中止処理
            timerFlg = false
            
            //timerを破棄する.
            timer.invalidate()
            
            //ボタンのタイトル変更.
            //sender.setTitle("Start Timer", for: UIControlState.normal)
            
            
            //罹患したので、罹患関係のリマインダーを削除する
            for notification:UILocalNotification in UIApplication.shared.scheduledLocalNotifications!{
                //全部消す
                UIApplication.shared.cancelLocalNotification(notification)
            }
            
        } else {
            print("開始ボタン")
            
            startstopButton.setTitle("タイマー停止", for: UIControlState.normal)
            
            //タイマーをスタート
            timerFlg = true
            
            //timerを生成する.
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.onUpdate(timer:)), userInfo: nil, repeats: true)
            
            //ボタンのタイトル変更.
            //sender.setTitle("Stop Timer", for: UIControlState.normal)
            
            //ローカル通知
            let notification = UILocalNotification()
            notification.alertAction = "時間です！" //ロック中にスライドで〜〜のところの文字
            notification.alertBody = "時間になりました！"
            notification.soundName = UILocalNotificationDefaultSoundName;
            
            //決められた秒後
            let thirtydaysAfterDate = NSDate(timeInterval: TimeInterval(cnt), since: NSDate() as Date) // XX秒後
            notification.fireDate = thirtydaysAfterDate as Date //通知される時間（とりあえず30秒後に設定）
            notification.timeZone = NSTimeZone.default
            
            //重複が無いように登録されていれば一旦削除
            for notification:UILocalNotification in UIApplication.shared.scheduledLocalNotifications!{
                UIApplication.shared.cancelLocalNotification(notification)
            }
            UIApplication.shared.scheduleLocalNotification(notification)//通知をスケジューリング

        }

    }
    
    //NSTimerIntervalで指定された秒数毎に呼び出されるメソッド.
    func onUpdate(timer : Timer){
        
        cnt -= 1
        
        let timeHour = cnt / 3600
        let timeMin = (cnt - (3600 * timeHour)) / 60
        let timeSec = (cnt - (3600 * timeHour) - (60 * timeMin))
        
        timerLabel.text = NSString(format: "%02d:%02d:%02d", timeHour,timeMin,timeSec) as String

        // 00になったら止める
        if(cnt <= 0){
            
            //timerを破棄する.
            timer.invalidate()
            
            audioPlayer.play()
            
            return
        }
    }
    
    // 音楽再生が成功した時に呼ばれるメソッド
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Music Finish")
        
        // 再度myButtonを"▶︎"に設定
        //button.setTitle("▶︎", for: .normal)
    }
    
    // デコード中にエラーが起きた時に呼ばれるメソッド
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Error")
    }
    
    @IBAction func clickSettingButton(_ sender: Any) {
        
        performSegue(withIdentifier: "setting",sender: nil)
    }
    
    
    // Segue 準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    @IBAction func returnToMe(segue: UIStoryboardSegue) {
        //戻ってきた時の処理、カウントダウンしていなければ設定値から画面表示
        if(!timerFlg){
            initTimerLabelDisplay()
        }
    }
    
    //設定からタイマーラベルを初期設定するための関数
    func initTimerLabelDisplay(){
        
        //設定された分数を取得（時間も分数に換算されている）
        let timerCountMin = defaults.integer(forKey: "timerCountMin")
        cnt = timerCountMin * 60
        
        let timeHour = cnt / 3600
        let timeMin = (cnt - (3600 * timeHour)) / 60
        let timeSec = (cnt - (3600 * timeHour) - (60 * timeMin))
        
        timerLabel.text = NSString(format: "%02d:%02d:%02d", timeHour,timeMin,timeSec) as String

    }
    
    
}


