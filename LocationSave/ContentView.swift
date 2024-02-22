//
//  ContentView.swift
//  LocationSave
//
//  Created by Apple on 2024/02/21.
//

import SwiftUI
import CoreLocation

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

struct ContentView: View {
    @ObservedObject var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let location = locationManager.lastLocation {
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
