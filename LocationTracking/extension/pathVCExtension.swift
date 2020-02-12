//
//  pathVCExtension.swift
//  LocationTracking
//
//  Created by manish on 12/02/20.
//  Copyright © 2020 Lokesh. All rights reserved.
//

import UIKit
import GoogleMaps

extension ViewController{
    
    func isSucessReadJson()  {
        drawPathOnMap()
    }
    
    func isFailReadJson(msg : String)  {
        let alert = UIAlertController(title: "Map Alert", message: msg, preferredStyle: .alert)
        let actionOK : UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(actionOK)
        self.present(alert, animated: true, completion: nil)
    }
    
    func drawPathOnMap()  {
           let path = GMSMutablePath()
           let marker = GMSMarker()
           
           let inialLat:Double = objViewModel.arrayMapPath[0].lat!
           let inialLong:Double = objViewModel.arrayMapPath[0].lon!

           for mapPath in objViewModel.arrayMapPath
           {
               path.add(CLLocationCoordinate2DMake(mapPath.lat!, mapPath.lon!))
           }
           //set poly line on mapview
           let rectangle = GMSPolyline(path: path)
           rectangle.strokeWidth = 5.0
           rectangle.strokeColor = UIColor.red
           marker.map = mapView
           rectangle.map = mapView
           
           //Zoom map with path area
           let loc : CLLocation = CLLocation(latitude: inialLat, longitude: inialLong)
           updateMapFrame(newLocation: loc, zoom: 12.0)
       }
       
       //marker move on map view
       func movingCarBetweenRoutes()
       {
           if iTemp <= (objViewModel.arrayMapPath.count - 1 )
           {
               let iTempMapPath = objViewModel.arrayMapPath[iTemp]
               
               let loc : CLLocation = CLLocation(latitude: iTempMapPath.lat!, longitude: iTempMapPath.lon!)
               
               updateMapFrame(newLocation: loc, zoom: self.mapView.camera.zoom)
               marker.position = CLLocationCoordinate2DMake(iTempMapPath.lat!, iTempMapPath.lon!)
               marker.groundAnchor = CGPoint(x: CGFloat(0.5), y: CGFloat(0.5))
               marker.rotation = iTempMapPath.angle!
               marker.icon = UIImage(named: "car.png")
               marker.map = mapView
               

            if iTemp == (objViewModel.arrayMapPath.count - 1)
               {
                    timer.invalidate()
                    iTemp = 0
                    alert(successMessage: "You reached your destination.")
                    btnStart.isEnabled = true
                    btnStart.alpha = 1.0
               }
               iTemp += 1
           }
       }
    
       func updateMapFrame(newLocation: CLLocation, zoom: Float) {
           let camera = GMSCameraPosition.camera(withTarget: newLocation.coordinate, zoom: zoom)
           self.mapView.animate(to: camera)
       }
       
    
    func alert(successMessage:String){
        let alert = UIAlertController(title: "Map Alert", message: successMessage, preferredStyle: .alert)
        let actionOK : UIAlertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(actionOK)
        self.present(alert, animated: true, completion: nil)
    }
    

}
