//
//  LocationGpsView.swift
//  SmartPaint
//
//  Created by jackychoi on 18/1/2024.
//
import MapKit
import SwiftUI
import CoreLocation

struct HongKongMuseum: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct LocationGpsView: View {
    
    let annotations = [
        HongKongMuseum(name: "Hong Kong Museum of Art", coordinate: CLLocationCoordinate2D(latitude: 22.2894605088 , longitude: 114.169880987)),
        HongKongMuseum(name: "Hong Kong Palace Museum", coordinate: CLLocationCoordinate2D(latitude: 22.30165 , longitude: 114.15527)),
        HongKongMuseum(name: "Museum Plus", coordinate: CLLocationCoordinate2D(latitude: 22.30096  , longitude: 114.15938)),
        HongKongMuseum(name: "Hong Kong Heritage Museum", coordinate: CLLocationCoordinate2D(latitude: 22.37663 , longitude: 114.18563)),
        HongKongMuseum(name: "Hong Kong Museum of History", coordinate: CLLocationCoordinate2D(latitude: 22.30148   , longitude: 114.17723 )),
        HongKongMuseum(name: "Sun Museum", coordinate: CLLocationCoordinate2D(latitude: 22.31082, longitude:114.21950)),
        HongKongMuseum(name: "Bamboo Scenes Gallery", coordinate: CLLocationCoordinate2D(latitude: 22.24793, longitude: 114.16488 )),
        HongKongMuseum(name: "Blue Lotus Gallery", coordinate: CLLocationCoordinate2D(latitude: 22.28428, longitude: 114.14726 )),
        HongKongMuseum(name: "H Queen's", coordinate: CLLocationCoordinate2D(latitude: 22.28299, longitude: 114.15526)),
        HongKongMuseum(name: "Pedder Building", coordinate: CLLocationCoordinate2D(latitude: 22.28185, longitude: 114.15701))
    ]
    
    @StateObject private var viewModel = LocationGpsViewModel()
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        ZStack(alignment:.topLeading){
            Map(coordinateRegion: $viewModel.region,showsUserLocation: true,annotationItems: annotations){
                museum in
                MapAnnotation(coordinate: museum.coordinate) {
                    VStack{
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.system(size: 20))
                        Text(museum.name)
                            .font(.caption2)
                    }
                }
            }
            .onAppear{
                viewModel.checkIfLocationServicesIsEnabled()
            }
            .ignoresSafeArea()
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrow.backward")
                    .foregroundStyle(.black)
                    .font(.title2)
            }
            .padding()
        }
    }
}

#Preview {
    LocationGpsView()
}

final class LocationGpsViewModel: NSObject,ObservableObject,CLLocationManagerDelegate{
    var locationManagers: CLLocationManager?
    
    @Published var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 22.32538, longitude: 114.18028), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    
    func checkIfLocationServicesIsEnabled(){
        if CLLocationManager.locationServicesEnabled(){
            locationManagers = CLLocationManager()
            locationManagers!.delegate = self
            
        }else{
            print("Show a alert")
        }
    }
    
   private func checkLocationAuthorization(){
        guard let locationManagers = locationManagers else{return}
        
        switch locationManagers.authorizationStatus{
        
        case .notDetermined:
            locationManagers.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it")
        case .authorizedAlways,.authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManagers.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
