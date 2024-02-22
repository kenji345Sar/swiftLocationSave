//
//  ContentView.swift
//  LocationSave
//
//  Created by Apple on 2024/02/21.
//

import SwiftUI
import CoreLocation
import MapKit

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    @Published var lastLocation: CLLocation?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization() // アプリ使用中の位置情報の利用をリクエスト
        self.locationManager.startUpdatingLocation() // 位置情報の更新を開始
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last // 最後の位置情報を取得
    }
}

struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)

        // 現在地を示すピンを地図に追加
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        view.addAnnotation(annotation)
    }
}


struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let location = locationManager.lastLocation {
                MapView(coordinate: location.coordinate)
                    .edgesIgnoringSafeArea(.all)

                Text("Current location: \(location.coordinate.latitude), \(location.coordinate.longitude)")
            } else {
                Text("Fetching location...")
            }
        }
    }
}



#Preview {
    ContentView()
}
