//
//  SettingViewController.swift
//  NapTimer
//
//  Created by maji on 2017/03/20.
//  Copyright © 2017年 2017 Misky. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var myPicker: UIDatePicker!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // varをletに変更（曽和）
        let timerCountMin = defaults.integer(forKey: "timerCountMin")
        
        let timeHour = timerCountMin / 60
        let timeMin = timerCountMin % 60
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        myPicker.setDate(formatter.date(from: NSString(format: "%02d:%02d", timeHour,timeMin) as String)!, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //データ変更時の呼び出しメソッド(46と52行目の変数の横に！を追加)
    @IBAction func changeTimer(_ sender: UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let dateHour = Int(formatter.string(from: sender.date))
        
        print(dateHour!)
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "mm"
        let dateMin = Int(formatter2.string(from: sender.date))
        
        print(dateMin!)
        
        print(dateHour! * 60 + dateMin!)
        
        defaults.set((dateHour! * 60 + dateMin!), forKey: "timerCountMin")
    }
    
    @IBAction func clickBackButton(_ sender: Any) {
        
        // viewを閉じる.
        //self.navigationController?.dismiss(animated: true, completion: nil)
    }
}


