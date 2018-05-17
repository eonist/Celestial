import Foundation
import CoreLocation

/**
 * NOTE: Lat,Long, for Oslo:  //59.9139° N, 10.7522° E
 */
struct Loc{
    let lat:Double
    let long:Double
}
extension Loc{
    /**
     * Fetches Name of Place and Country
     */
    func locality(onComplete:@escaping (_ locality:String)->Void) {
        let userLocation :CLLocation = CLLocation.init(latitude: lat, longitude: long)
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")

        let geocoder = CLGeocoder()

        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            
            //                let placemark = placemarks! as [CLPlacemark]
            //                if placemark.count > 0{
            //                let placemark = placemarks![0]
            //                Swift.print("placemark.locality:  \(placemark.locality)")
            
            //                print(placemark.administrativeArea!)
            //                Swift.print("placemark.country:  \(placemark.country)")
            
            if let placemarksUnwrapped:[CLPlacemark] = placemarks, let firstPlacemark = Optional(placemarksUnwrapped[0]), let locality = firstPlacemark.locality, let country = firstPlacemark.country {
                let localityStr = "\(locality), \(country)" // \(placemark.administrativeArea!),
                onComplete(localityStr)
            }else {
                onComplete("unknown location")
            }
        }
    }
}

class LocationManager: NSObject, CLLocationManagerDelegate {
    var loc:Loc {
        return .init(lat:currentLocation.coordinate.latitude, long:currentLocation.coordinate.longitude)//init(lat:59.9139,long:10.7522)//⚠️️ init in oslo, debug
    }
    var currentLocation = CLLocation()
    var locationManager = CLLocationManager()
    // Region
    static var regionRadius = 500.0 // the radius of the region the user has to move out of to trigger a forecast update.
    var region = CLCircularRegion()
    //singleton
    static let sharedInstance = LocationManager()
    //callbacks:
    var onExitRegion:()->Void = {Swift.print("⚠️️ onExitRegion - no callback is assigned ⚠️️")}
    var onBeganMonitoring:()->Void = {  Swift.print("⚠️️ onBeganMonitoring - no callback is assigned ⚠️️")}
    var authorizationCallback:(Bool)->Void = { _ in Swift.print("⚠️️ authorizationCallback - no callback is assigned ⚠️️")}
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    func requestAuthorization() {
        Swift.print("🎉requestAuthorization-begin")
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        Swift.print("🎉requestAuthorization-ended")
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            Swift.print("denied 👌")
            authorizationCallback(false)
        } else if (status == CLAuthorizationStatus.authorizedAlways) {
            // The user accepted authorization
            Swift.print("accepted 👌")
            authorizationCallback(true)
        }
    }
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
    }
    func startMonitoringForRegion() {
        setupRegion()
        locationManager.startMonitoring(for: region)
    }
    func setupRegion() {
        // Create region with center at device location
        if let currentLocation = locationManager.location?.coordinate {
            region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: currentLocation.latitude, longitude:  currentLocation.longitude), radius: LocationManager.regionRadius, identifier: "UpdateForecastRegion")
        } else {
            region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: loc.lat, longitude:  loc.long), radius: LocationManager.regionRadius, identifier: "UpdateForecastRegion")
        }
        region.notifyOnEntry = false
        region.notifyOnExit = true
    }
    
    //Event methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        Swift.print("didUpdateLocations: \(locations.last!)")
        // Update current location
         currentLocation = locations.last!
    }
    func locationManager(_ manager: CLLocationManager, didStartMonitoringFor region: CLRegion) {
        Swift.print("didStartMonitoringFor 👈")
        Swift.print("loc:  \(loc)")
        onBeganMonitoring()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location: Location Manager failed with the following error: \(error)")
    }
    /**
     * Region Methods
     */
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("LocationManager: exited region")
        // Stop monitoring for old region so we can create a new region
        locationManager.stopMonitoring(for: self.region)
        
        // Setup and start monitoring for new region
        startMonitoringForRegion()
        onExitRegion()//call the callback method
    }
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("Location: Monitoring failed for region with identifier: \(region!.identifier)")
    }
}
