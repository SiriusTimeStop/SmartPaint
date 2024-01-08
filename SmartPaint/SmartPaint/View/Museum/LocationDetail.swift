//
//  locationDetail.swift
//  SmartPaint
//
//  Created by jackychoi on 7/1/2024.
//

import SwiftUI
import MapKit
import CoreLocation

struct LocationDetail: View {
    let location: Location

    var body: some View {
        ScrollView(.vertical){
            VStack{
                Image(location.locationImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 350)
                
                HStack{
                    Image("ellipsis.message")
                        .frame(width: 10,height: 10,alignment: .trailing)
                    Spacer()
                    Text(location.locationName)
                        .font(.title)
                        .bold()
                    Spacer()
                    NavigationLink(destination: ChatView()){
                            Image(systemName: "ellipsis.message")
                            .foregroundColor(.black)
                        }
                    .frame(width: 20,height: 20,alignment: .trailing)
                }
                
                Text(location.locationCountry)
                    .font(.callout)
                
                Text(location.locationDetail)
                    .font(.caption2)
                    .padding(.top,1)
                
                Map(initialPosition: .region(region)){
                    Marker(location.locationName, coordinate: CLLocationCoordinate2D(latitude: Double(location.locationLatitude) ?? 0, longitude: Double(location.locationLongitude) ?? 0))
                }
                .frame(height: 300)
                .padding(.top,10)
            }
            .padding(.horizontal)
        }
    }
    private var region: MKCoordinateRegion{
        
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: Double(location.locationLatitude) ?? 0, longitude: Double(location.locationLongitude) ?? 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    }
}


struct LocationDetail_Previews: PreviewProvider {
    static var previews: some View {
        LocationDetail(location: LocationArray[0])
    }
}
