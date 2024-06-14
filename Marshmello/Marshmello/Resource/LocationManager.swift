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

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
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
