//
//  ContentView.swift
//  LocationSave
//
//  Created by Apple on 2024/02/21.
//

import SwiftUI
import MapKit // ←これ

extension CLLocationCoordinate2D {
    static let tsu_station = CLLocationCoordinate2D(latitude: 34.7345036, longitude: 136.5101973)
}

struct ContentView: View {
    
    @State var position: MapCameraPosition = .automatic // ←ここ追加
    
    var body: some View {
        Map(position: $position)  {
            
            UserAnnotation(anchor: .center) // ←ここ追加
            
            Annotation("Tsu-Station",
                       coordinate: .tsu_station, anchor: .bottom) {
                VStack {
                    Text("Mie is Tokai")
                    Image(systemName: "flag.2.crossed")
                    LocationButton(position: $position) // ←ここ追加
                }
                .foregroundColor(.blue)
                .padding()
                .background(in: .capsule)
            }
        }
    }
}



#Preview {
    ContentView()
}
