//
//   WeatherViewController.swift
//  TheSolo
//
//  Created by TheSolo on 15/9/9.
//  Copyright (c) 2015年 TheSolo. All rights reserved.
//
import Foundation
import UIKit

class WeatherViewController: UIViewController {
    
    var url = "http://apis.baidu.com/apistore/weatherservice/cityid"
    var httpArg = "cityid=101200101"
    
    @IBOutlet var labMsg: UILabel!
    @IBOutlet weak var labCity: UILabel!
    @IBOutlet weak var labDatetime: UILabel!
    @IBOutlet weak var labWeather: UILabel!
    @IBOutlet weak var labTemp: UILabel!
    @IBOutlet weak var labWS: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //自动折行设置
       // labMsg.lineBreakMode = UILineBreakModeWordWrap;
        labMsg.numberOfLines = 0;
        var msg = request(url, httpArg: httpArg)
        viewWeather(msg)
            }
    

    //获取天气信息
    func  request(httpUrl: String, httpArg: String)->NSData{
        var rel :String
        var re:NSData?
        var req = NSMutableURLRequest(URL: NSURL(string: httpUrl + "?" + httpArg)!)
        req.timeoutInterval = 6
        req.HTTPMethod = "GET"
        req.addValue("a1f50d8864b5d71169a053dde7483f24", forHTTPHeaderField: "apikey")
        //响应对象
        var response:NSURLResponse?
        //错误对象
        var error:NSError?
        //发出请求
        var data:NSData? = NSURLConnection.sendSynchronousRequest(req, returningResponse: &response, error: &error)
        if(error != nil){
            rel="请求失败"
        }else{
            //var jsonString = NSString(data:data!,encoding:NSUTF8StringEncoding)
            //let json = JSON(data: data!)
            re = data!
            //rel = jsonString as String?
            //rel =json["retData"]["city"].stringValue!
        }
        return re!
    }
    
    func viewWeather(josn:NSData){
        let json = JSON(data:josn)
        self.labCity.text = json["retData"]["city"].stringValue
        let date = json["retData"]["date"].stringValue
        let time = json["retData"]["time"].stringValue
        var datetime = date + "  "
        datetime += time
        self.labDatetime.text = datetime
        self.labWeather.text = json["retData"]["weather"].stringValue
        self.labTemp.text = json["retData"]["temp"].stringValue
        self.labWS.text = json["retData"]["WS"].stringValue
        var jsonString = NSString(data:josn,encoding:NSUTF8StringEncoding)
        self.labMsg.text = jsonString as String?
 
    }
}