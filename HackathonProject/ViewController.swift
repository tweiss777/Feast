//
//  ViewController.swift
//  HackathonProject
//
//  Created by Tal Weiss on 11/10/16.
//  Copyright © 2016 Tal Weiss. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Social

class ViewController: UIViewController, CLLocationManagerDelegate{
    
    var locationManager: CLLocationManager!//CLLocatoinManager type.
    @IBOutlet weak var mapView: GMSMapView!
    var latitude :CLLocationDegrees = 0.0
    var longitude : CLLocationDegrees = 0.0
    var location: CLLocation!{
        //computed variable 
        didSet{/*pass coordinates into our lattitude & longitude variable*/
            
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            
            print("latitude: \(latitude)")
            print("longitude: \(longitude)")
        }
    }
//40.716762, -73.599752
// new coordinates 40.714526, -73.600589
//example url http://maps.google.com/?ll=39.774769,-74.86084
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCorelocationpermission()
        latitude = 40.716762
        longitude = -73.599752
        mapView.camera = GMSCameraPosition.camera(withLatitude:latitude, longitude:longitude, zoom:15)
        let location = CLLocationCoordinate2DMake(latitude,longitude)
        let marker = GMSMarker(position: location)
        marker.map = mapView
        
//        DispatchQueue.main.async {
//            self.mapView.camera = GMSCameraPosition.camera(withLatitude: self.latitude, longitude: self.longitude, zoom: 15)
//        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
            }

    func checkCorelocationpermission(){
        //check to see if we can use users core location!
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            //when you use the form the user allows call location
            locationManager.startUpdatingLocation()//user location gets updated
            
        }
        else if CLLocationManager.authorizationStatus() == .notDetermined{
            //User has not made a choice as to whether user location is authorized
            locationManager.requestWhenInUseAuthorization()
        }
        else if CLLocationManager.authorizationStatus() == .restricted{
            //YOU ARE NOT AUTHORIZED TO USE LOCATION SERVICES.
            print("SERVICE DENIED")
            //create ui popup showing denial of location
            let alert = UIAlertController(title: "Warning", message: "Location services denied!!!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last
        locationManager.stopUpdatingLocation() // stop updating. save battery
    }
    //let url = "http://maps.google.com/?ll=\(latitude),\(longitude)"

    @IBAction func shareToFacebook(_ sender: UIButton) {
        //share to facebook
        print("sharing with facebook")
        var shareToFacebook : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
        shareToFacebook.setInitialText("http://maps.google.com/?ll=\(latitude),\(longitude)")
        self.present(shareToFacebook, animated: true, completion: nil)
        
    }
    @IBAction func shareToTwitter(_ sender: UIButton) {
        //share to twitter
        var shareToTwitter: SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        shareToTwitter.setInitialText("http://maps.google.com/?ll=\(latitude),\(longitude)")
        self.present(shareToTwitter, animated: true, completion: nil)
        
    }
    
    
}

