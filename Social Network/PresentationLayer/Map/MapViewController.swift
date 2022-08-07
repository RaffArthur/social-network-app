//
//  MapViewController.swift
//  Social_Network
//
//  Created by Arthur Raff on 30.07.2022.
//

import UIKit
import MapKit
import CoreLocation

final class MapViewController: UIViewController {
    private lazy var mapView = MKMapView()
    private lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupActions()
        
        locationManager.delegate = self
        mapView.delegate = self

        checkUserLocationPermissions()
        configureLocationZoom()
        addRoute()
        addKremlinPin()
    }
}

private extension MapViewController {
    func setupLayout() {
        view.addSubview(mapView)
        
        mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

private extension MapViewController {
    func setupActions() {
        let longGesture = UILongPressGestureRecognizer(target: self,
                                                       action: #selector(addUserPin(longGesture:)))
        longGesture.delegate = self
        
        mapView.addGestureRecognizer(longGesture)
    }
    
    @objc func addUserPin(longGesture: UILongPressGestureRecognizer) {
        if longGesture.state == .began {
            let location = longGesture.location(in: mapView)
            
            let coordinate = mapView.convert(location, toCoordinateFrom: mapView)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "\(String.setLocalizedStringWith(key: .coordinatesTitle)) \(coordinate.latitude)\n\(coordinate.longitude)"
            
            mapView.addAnnotation(annotation)
            
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        }
    }
    
    func addRoute() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        
        let directionRequest = MKDirections.Request()
        
        let sourcePlaceMark = MKPlacemark(coordinate: coordinate)
        let sourceMapItem = MKMapItem(placemark: sourcePlaceMark)
        
        let destinationPlaceMark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: 55.755786,
                                                                                  longitude: 37.617633))
        let destinationMapItem = MKMapItem(placemark: destinationPlaceMark)
        
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate { [weak self] response, error in
            guard let route = response?.routes[0] else { return }
            
            self?.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            let rect = route.polyline.boundingMapRect
            
            self?.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    
    func addKremlinPin() {
        let coordinate = CLLocationCoordinate2D(latitude: 55.755786,
                                                       longitude: 37.617633)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = .setLocalizedStringWith(key: .kremlinPinTitle)
        
        mapView.addAnnotation(annotation)
    }
    
    func showLocationServicesAuthorizationAlert() {
        let alertController = UIAlertController(title: "Включите службы геолокации",
                                                message: "Перейдите в настройки, чтобы предоставить службам геолокации доступ к приложению",
                                                preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "ОК",
                                   style: .cancel)
        
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true)
    }
}

private extension MapViewController {
    func configureLocationZoom() {
        
        guard let centerCoordinates = locationManager.location?.coordinate else { return }
                
        mapView.setCenter(centerCoordinates, animated: true)
        
        let region = MKCoordinateRegion(center: centerCoordinates,
                                        latitudinalMeters: 2000,
                                        longitudinalMeters: 2000)
        
        mapView.setRegion(region, animated: true)
    }
    
    func checkUserLocationPermissions() {
        startLocationUpdating()
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            showLocationServicesAuthorizationAlert()
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
        @unknown default:
            fatalError()
        }
    }
    
    func startLocationUpdating() {
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = 5
    }
    
    func stopLocationUpdating() {
        locationManager.stopUpdatingLocation()
    }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocationPermissions()
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        
        let region = MKCoordinateRegion(center: location.coordinate,
                                        latitudinalMeters: 2000,
                                        longitudinalMeters: 2000)
        
        mapView.setRegion(region, animated: true)
        
        stopLocationUpdating()
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView,
                 rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .systemOrange
        renderer.fillColor = .white
        renderer.lineWidth = 5.0
        
        return renderer
    }
}

extension MapViewController: UIGestureRecognizerDelegate {
    
}
