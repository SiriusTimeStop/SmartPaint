//
//  Annotatedltem.swift
//  LocationEx
//
//  Created by itst on 27/11/2023.
//
import MapKit
import Foundation

struct AnnotatedItem : Identifiable{
    let id = UUID()
    let name : String
    var coordinate : CLLocationCoordinate2D
}
