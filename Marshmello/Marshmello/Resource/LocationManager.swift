//
//  LocationManager.swift
//  Marshmello
//
//  Created by KimYuBin on 6/15/24.
//

import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    private var geocoder = CLGeocoder()
    @Published var location: CLLocation?
    @Published var address: String?
    @Published var authorizationStatus: CLAuthorizationStatus?
    let standardLocation: CLLocation = {
        if let addressCoordinate = UserDefaults.standard.array(forKey: "addressCoordinate") as? [[String: Double]],
           let firstCoordinate = addressCoordinate.first,
           let latitude = firstCoordinate["latitude"],
           let longitude = firstCoordinate["longitude"] {
            return CLLocation(latitude: latitude, longitude: longitude)
        } else {
            return CLLocation(latitude: 36.01433679, longitude: 129.32563839)
        }
    }()
    

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.allowsBackgroundLocationUpdates = true
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func calculateDistance() -> Double{
        guard let location = self.location else { return 0.0 }
        return location.distance(from: self.standardLocation)
    }

    func startUpdatingLocation() {
        self.locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        reverseGeocode(location: location)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.authorizationStatus = status
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            self.locationManager.startUpdatingLocation()
        }
    }

    private func reverseGeocode(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                self?.address = "주소를 가져올 수 없습니다."
            } else if let placemark = placemarks?.first {
                self?.address = [
                    placemark.administrativeArea,
                    placemark.subAdministrativeArea,
                    placemark.locality,
                    placemark.subLocality,
                    placemark.name
                ].compactMap { $0 }.joined(separator: " ")
            }
        }
    }
}
