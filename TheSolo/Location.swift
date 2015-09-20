//
//  Location.swift
//  TheSolo
//
//  Created by TheSolo on 15/9/12.
//  Copyright (c) 2015年 TheSolo. All rights reserved.
//
import Foundation
import UIKit
import CoreLocation 

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var longitudeTxt: UITextField!
    @IBOutlet weak var latitudeTxt: UITextField!
    @IBOutlet weak var HeightTxt: UITextField!
    @IBOutlet weak var addressTxt: UILabel!
    var currLocation : CLLocation!
    
    //地址反编译出错误，不清楚什么问题，我是在模拟器上模拟的
    @IBAction func reverseGeocode(sender: AnyObject) {
        var geocoder = CLGeocoder()
        var p:CLPlacemark?
        geocoder.reverseGeocodeLocation(currLocation, completionHandler: { (placemarks, error) -> Void in
            if error != nil {
                println("reverse geodcode fail: \(error.localizedDescription)")
                return
            }
            let pm = placemarks as! [CLPlacemark]
            if (pm.count > 0){
                p = placemarks[0] as? CLPlacemark
                println(p)
            }else{
                println("No Placemarks!")
            }
        })
    }
    //用于定位服务管理类，它能够给我们提供位置信息和高度信息，也可以监控设备进入或离开某个区域，还可以获得设备的运行方向
    let locationManager : CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        //设备使用电池供电时最高的精度
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //精确到1000米,距离过滤器，定义了设备移动后获得位置信息的最小距离
        locationManager.distanceFilter = kCLLocationAccuracyKilometer
        
    }
    
    override func viewWillAppear(animated: Bool) {
        locationManager.startUpdatingLocation()
        println("定位开始")
    }
    
    override func viewWillDisappear(animated: Bool) {
        locationManager.stopUpdatingLocation()
        println("定位结束")
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!){
        currLocation = locations.last as! CLLocation
        longitudeTxt.text = "\(currLocation.coordinate.longitude)"
        latitudeTxt.text = "\(currLocation.coordinate.latitude)"
        HeightTxt.text = "\(currLocation.altitude)"
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!){
        println(error)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}