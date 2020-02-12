//
//  ViewController.swift
//  LocationTracking
//
//  Created by manish on 12/02/20.
//  Copyright © 2020 Lokesh. All rights reserved.
//

import UIKit
import GoogleMaps
class ViewController: UIViewController,GMSMapViewDelegate , ViewModelPathDelegate {

@IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnStart: UIButton!
    
    var objViewModel = ViewModelPath()
    var iTemp:Int = 0
    var marker = GMSMarker()
    var sourceMarker = GMSMarker()
    var destinationMarker = GMSMarker()
    var timer = Timer()
    

    let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: 22.857165, longitude: 77.354613, zoom: 4.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        pageSetUp()
        addMarkerToUserSourceAndDestinationLocation()
    }

    func pageSetUp()  {
        objViewModel.delegate = self
        mapView.delegate = self
        mapView.camera = camera
//        mapView.isMyLocationEnabled = true
//        mapView.settings.myLocationButton = true
        mapView.settings.compassButton = true
        mapView.settings.indoorPicker = true
        mapView.settings.scrollGestures = true;
        mapView.settings.zoomGestures = true;

        objViewModel.jsonDataRead()
    }
    
    func addMarkerToUserSourceAndDestinationLocation(){
        let sourceLat = objViewModel.arrayMapPath.first!.lat!
        let sourceLong = objViewModel.arrayMapPath.first!.lon!
        
        let destinationLat = objViewModel.arrayMapPath.last!.lat!
        let destinationLong = objViewModel.arrayMapPath.last!.lon!
        
        sourceMarker.position = CLLocationCoordinate2DMake(CLLocationDegrees(sourceLat), CLLocationDegrees(sourceLong))
        sourceMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        sourceMarker.map = mapView
        sourceMarker.icon = UIImage(named:"pin_marker.png")
        
        destinationMarker.position = CLLocationCoordinate2DMake(CLLocationDegrees(destinationLat), CLLocationDegrees(destinationLong))
        destinationMarker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
        destinationMarker.map = mapView
        destinationMarker.icon = UIImage(named:"pin_marker.png")

    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    @IBAction func onClickStart(_ sender: Any) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (_) in
            self.movingCarBetweenRoutes()
        })
        btnStart.alpha = 0.4
        btnStart.isEnabled = false
        RunLoop.current.add(timer, forMode: RunLoop.Mode.common)
    }
}


