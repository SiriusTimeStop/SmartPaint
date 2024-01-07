//
//  Location.swift
//  SmartPaint
//
//  Created by jackychoi on 7/1/2024.
//

import Foundation
import SwiftUI

struct Location: Identifiable{
    let locationName: String
    let locationImage: String
    let locationCountry: String
    let locationLatitude: String
    let locationLongitude: String
    let locationDetail: String
    let id = UUID()
}

let LocationArray = [
    Location(locationName:"Louvre", locationImage: "LouvreImage", locationCountry: "France", locationLatitude: "48.860294", locationLongitude: "2.338629", locationDetail: "The Louvre ,or the Louvre Museum, is a national art museum in Paris, France. It is located on the Right Bank of the Seine in the city's 1st arrondissement and home to some of the most canonical works of Western art, including the Mona Lisa and the Venus de Milo. The museum is housed in the Louvre Palace, originally built in the late 12th to 13th century under Philip II. Remnants of the Medieval Louvre fortress are visible in the basement of the museum. Due to urban expansion, the fortress eventually lost its defensive function, and in 1546 Francis I converted it into the primary residence of the French Kings."),
   Location(locationName: "Vatican Museums", locationImage: "VaticanMuseumsImage", locationCountry: "Vatican City", locationLatitude: "41.906487", locationLongitude: "12.453641", locationDetail: "The Vatican Museums are the public museums of Vatican City, enclave of Rome. They display works from the immense collection amassed by the Catholic Church and the papacy throughout the centuries, including several of the most well-known Roman sculptures and most important masterpieces of Renaissance art in the world. The museums contain roughly 70,000 works, of which 20,000 are on display, and currently employ 640 people who work in 40 different administrative, scholarly, and restoration departments."),
    Location(locationName: "British Museum", locationImage: "UnitedKingdomImage", locationCountry: "UK", locationLatitude: "51.518757", locationLongitude: "-0.126168", locationDetail: "The British Museum is a public museum dedicated to human history, art and culture located in the Bloomsbury area of London. Its permanent collection of eight million works is the largest in the world. It documents the story of human culture from its beginnings to the present. The British Museum was the first public national museum to cover all fields of knowledge."),
    Location(locationName: "National Museum of Korea", locationImage: "NationalMuseumOfKoreaImage", locationCountry: "Korea", locationLatitude: "37.52362083541996", locationLongitude: "126.98007323083513", locationDetail: "The National Museum of Korea is the flagship museum of Korean history and art in South Korea. Since its establishment in 1945, the museum has been committed to various studies and research activities in the fields of archaeology, history, and art, continuously developing a variety of exhibitions and education programs. It was relocated to the Yongsan District in Seoul in 2005. On June 24, 2021, the National Museum of Korea opened a new branch inside Incheon International Airport."),
    Location(locationName: "National Museum of China", locationImage: "NationalMuseumOfChinaImage", locationCountry: "China", locationLatitude: "39.905159", locationLongitude: "116.400894", locationDetail: "The National Museum of China is the national museum of China. It flanks the eastern side of Tiananmen Square in Beijing, China. The museum's mission is to educate about the arts and history of China. It is a level-1 public welfare institution funded by the Ministry of Culture and Tourism of China."),
    Location(locationName: "National Gallery of Art", locationImage: "NationalGalleryOfArtImage", locationCountry: "USA", locationLatitude: "38.891289", locationLongitude: "-77.020065", locationDetail: "The National Gallery of Art is an art museum in Washington, D.C., United States, located on the National Mall, between 3rd and 9th Streets, at Constitution Avenue NW. Open to the public and free of charge, the museum was privately established in 1937 for the American people by a joint resolution of the United States Congress. Andrew W. Mellon donated a substantial art collection and funds for construction. The core collection includes major works of art donated by Paul Mellon, Ailsa Mellon Bruce, Lessing J. Rosenwald, Samuel Henry Kress, Rush Harrison Kress, Peter Arrell Browne Widener, Joseph E. Widener, and Chester Dale. The Gallery's collection of paintings, drawings, prints, photographs, sculpture, medals, and decorative arts traces the development of Western art from the Middle Ages to the present, including the only painting by Leonardo da Vinci in the Americas and the largest mobile created by Alexander Calder.")
]
