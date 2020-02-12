//
//  ViewModelPath.swift
//  LocationTracking
//
//  Created by manish on 12/02/20.
//  Copyright © 2020 Lokesh. All rights reserved.
//

import UIKit

protocol ViewModelPathDelegate {
    func isSucessReadJson()
    func isFailReadJson(msg : String)
}

class ViewModelPath {
    var delegate : ViewModelPathDelegate?
    var arrayMapPath : [ModelLocationPathOnMap] = []
    
    func jsonDataRead() {
        do {
            if let file = Bundle.main.url(forResource: "Users_coordinate", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    parseJson(json: object)
                } else {
                    print("JSON is invalid")
                    delegate?.isFailReadJson(msg: "JSON is invalid")
                }
            } else {
                print("no file")
                delegate?.isFailReadJson(msg: "No File found")
            }
        } catch {
            print(error.localizedDescription)
            delegate?.isFailReadJson(msg: error.localizedDescription)
        }
    }
    
    func parseJson(json : [String: Any])  {
        let pathArray = json["Locations"] as! NSArray
        for data in pathArray
        {
            let dic = data as! NSDictionary
            guard let lat = dic.value(forKey: "lat") as? String else {
                return
            }
            guard let lon:String = dic.value(forKey: "long") as? String else {
                return
            }
            guard let angle:String = dic.value(forKey: "angle") as? String else {
                return
            }
            
            arrayMapPath.append(ModelLocationPathOnMap(lat: Double(lat), lon: Double(lon), angle: Double(angle)))
        }
        
        if arrayMapPath.count > 0
        {
            delegate?.isSucessReadJson()
        }
    }

}
