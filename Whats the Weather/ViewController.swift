//
//  ViewController.swift
//  Whats the Weather
//
//  Created by William Peregoy on 2015/9/2.
//  Copyright © 2015年 William Peregoy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userCity: UITextField!
    
    @IBOutlet weak var weatherDescrip: UILabel!
    
    @IBAction func getWeather(sender: AnyObject) {
        
        var wasSuccessful = false
        
        let attemptUrl = NSURL (string: "http://www.weather-forecast.com/locations/" + userCity.text!.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        /*var midUrl = String(userCity.text!)
        
        if theInput.containsString(" ") {
            
            let myArray = theInput.componentsSeparatedByString(" ")
            
            var x = 0
            
            midUrl = ""
            
            while x < (myArray.count - 1) {
                
                midUrl = midUrl + myArray[x] + "-"
        
                x++
            }
            
            midUrl = midUrl + myArray[x]
            
        } */
        
        if let finalUrl = attemptUrl {

        
            let pullData = NSURLSession.sharedSession().dataTaskWithURL(finalUrl) { (data, response, error) -> Void in
                
                if let urlContent = data {
                    
                    let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                    
                    let xArray = webContent!.componentsSeparatedByString("3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">")
                    
                    if xArray.count > 1 {
                        
                        let xArray = NSString(string: xArray[1]).componentsSeparatedByString("<")
                    1
                        if xArray.count > 1 {
                            
                            wasSuccessful = true
                            
                            let realAnswer = xArray[0].stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                            
                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                                self.weatherDescrip.text = realAnswer
                                
                            })
                            
                            
                        }
                        
                    }
                    
                    if wasSuccessful == false {
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            
                            self.weatherDescrip.text = "Couldn't find that city in the database"
                        })
                    }
                    
                }
                
            }
            
            pullData.resume()
            
            
        } else {
            
            self.weatherDescrip.text = "Couldn't find that city in the database"
            
        }

    }
    
    
        
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

