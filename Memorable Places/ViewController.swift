//
//  ViewController.swift
//  Memorable Places
//
//  Created by 李宝明 on 16/8/24.
//  Copyright © 2016年 李宝明. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: MKMapView!
    var locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        loadPlace()
        
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(ViewController.longPress(gestureRecognizer:)))
   
        longPressGestureRecognizer.minimumPressDuration = 2
        
    
        
        map.addGestureRecognizer(longPressGestureRecognizer)
    }

    
    
    
    func longPress(gestureRecognizer: UIGestureRecognizer) {
        
        if gestureRecognizer.state == UIGestureRecognizerState.began {
            
            let touchPoint = gestureRecognizer.location(in: self.map)
            
            let coordinate = self.map.convert(touchPoint, toCoordinateFrom: self.map)
            
            
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            map.setRegion(region, animated: true)
            
            let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
            
           
           
            
            var title = ""
            
            CLGeocoder().reverseGeocodeLocation(location) { (placemarks, error) in
                if error != nil {
                    print(error)
                }else {
                    
                    if let placemark = placemarks?[0] {
                        
                        if let name = placemark.subThoroughfare {
                            title += name + " "
                        }
                        
                        if let thoroughfare = placemark.thoroughfare {
                            title += thoroughfare + " "
                        }
                    }
                    
                    if title == "" {
                        title = "added \(NSDate())"
                    }
                    
                    
                    let annotation = MKPointAnnotation()
                    
                    annotation.coordinate = coordinate
                    annotation.title = title
                    
                    self.map.addAnnotation(annotation)
                    
                    places.append(["name":"\(title)","lat":"\(coordinate.latitude)","lon":"\(coordinate.longitude)"])
                    
                   UserDefaults.standard.set(places, forKey: "places")
                }
            }

            
        }
        
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let currentlocation = locations[0]
        
        var title = ""
        
        CLGeocoder().reverseGeocodeLocation(currentlocation) { (placemarks, error) in
            if error != nil {
                print(error)
            }else {
                
                if let placemark = placemarks?[0] {
                    if let name = placemark.subThoroughfare {
                        title += name + " "
                    }
                    
                    if let thoroughfare = placemark.thoroughfare {
                        title += thoroughfare + " "
                    }

                }
                
            }
        }
        
        if title == "" {
            title = "it is not be recorde"
        }
        
        
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05,longitudeDelta: 0.05)
        
        let region = MKCoordinateRegion(center: currentlocation.coordinate, span: span)
        
        self.map.setRegion(region, animated: true)
        
        let annonation = MKPointAnnotation()
        annonation.coordinate = currentlocation.coordinate
        annonation.title = title
        
        
        self.map.addAnnotation(annonation)
        
    
    }
    
    
    
    
    func loadPlace(){
        if activePlaces == -1 {
            
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        
        }else if places.count > activePlaces {
                
                if let name = places[activePlaces]["name"] {
                    
                    if let latStr  = places[activePlaces]["lat"] {
                        
                        if let lonStr  = places[activePlaces]["lon"] {
                            
                            if let lat = Double(latStr) {
                                if let lon = Double(lonStr) {
                                    
                                    let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                    
                                    let center = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                                    
                                    let region = MKCoordinateRegion(center: center, span: span)
                                    
                                    self.map.setRegion(region, animated: true)
                                    
                                    let annotation = MKPointAnnotation()
                                    
                                    annotation.coordinate = center
                                    
                                    annotation.title = name
                                    
                                    map.addAnnotation(annotation)
                                    
                                    
                                }
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }





