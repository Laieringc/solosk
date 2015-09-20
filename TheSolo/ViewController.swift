//
//  ViewController.swift
//  TheSolo
//
//  Created by TheSolo on 15/9/4.
//  Copyright (c) 2015年 TheSolo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var db:SQLiteDB!
    @IBOutlet weak var textName: UITextField!
    @IBOutlet weak var textPass: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        textName.text = "TTTTTT";
        //获取数据库实例
        db = SQLiteDB.sharedInstance()
        //如果表还不存在则创建表
        db.execute(
            "create table if not exists t_user(uid integer primary key,uname varchar(20),mobile varchar(20))"
        )
        //如果有数据则加载
        initUser()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //从SQLite加载数据
    func initUser() {
        let data = db.query("select * from users")
        if data.count > 0 {
            //获取最后一行数据显示
            let user = data[data.count - 1] as SQLRow
            textName.text = user["user_name"]?.asString()
            textPass.text = user["user_pass"]?.asString()
        }
    }
    
}

