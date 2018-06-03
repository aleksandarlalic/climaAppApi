//
//  ViewController.swift
//  WeatherApp
//
//  Created by Pedja Jevtic on 5/7/18.
//  Copyright © 2018 Pedja Jevtic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func baseURL() -> String {
        //let apiToken = "a85b6e759652f522198ba6debc43bae7"
        var baseURL = "https://swapi.co/api/people/1/"
        
        return baseURL
    }
    
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var iconLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
 
    @IBOutlet weak var wInfo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateWeather()
    }

    func updateWeather(){
     // connect to API and load weather for given city
    
        print("loading weather")
        self.tempLbl.text = "..."
        
        // url for loading weather
        let urlString = self.baseURL()
            //+ "&q=Belgrade,rs"
        
        guard let url = URL.init(string: urlString)  else { return }
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
          // check if data is valid and not nil
            if let usableData = data {
                do {
                    
                    // unpack information from data to dictionary
                    // using JsonSerialization
                    if let jsonData = try JSONSerialization.jsonObject(with: usableData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        // update UI with our data
                        // dispatch is required because of multithreading (will learn more)
                        DispatchQueue.main.async {
                            if let people = jsonData as? [String: AnyObject]{
                               print(people)
                                
                                if let temp = people ["name"] as? String{
                                    self.tempLbl.text = String(temp)
                                }
                                if let icon = people ["height"] as? String{
                                    self.iconLbl.text = icon
                                }
                                if let location = people ["mass"] as? String{
                                    self.cityLbl.text = location
                                }
                                if let summary = people ["films"]! as? String {
                                    self.wInfo.text = summary
                                    
                                }
                                
                              
                                
                            }
                        }
                    }
                } catch let myJSONError {
                    print(myJSONError)
                }
            }
        }

        task.resume()
        
    }

}
