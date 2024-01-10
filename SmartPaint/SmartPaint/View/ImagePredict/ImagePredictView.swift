//
//  ImagePredictView.swift
//  Aircraft Introduction
//
//  Created by jackychoi on 1/4/2023.
//

import SwiftUI
import CoreML
import Vision

struct ImagePredictView: View {
    
    @State private var showSheet: Bool = false
    @State private var showPhotoOptions: Bool = false
    @State private var image: UIImage?
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var classificationLabel: String = ""
    
    private let classifier = VisionClassfier(mlModel: WorldFamousPainting_1().model)
    
    var body: some View {
        
        NavigationView {
            VStack{
                if let image = image {
                    GeometryReader { geo in
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                } else {
                    GeometryReader { geo in
                        Image("placeholder")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geo.size.width, height: geo.size.height)
                    }
                }
          
                Button("Choose Picture") {
                    // open action sheet
                    self.showSheet = true
                }.padding()
                    .font(.title2)
                    .frame(width: 200)
                    .foregroundColor(.white)
                    .background(Color.gray)
                    .clipShape(Capsule())
                    .actionSheet(isPresented: $showSheet) {
                        ActionSheet(title: Text("Select Photo"), message: Text("Choose"), buttons: [
                            .default(Text("Photo Library")) {
                                // open photo library
                                self.showPhotoOptions = true
                                self.sourceType = .photoLibrary
                            },
                            .default(Text("Camera")) {
                                // open camera
                                self.showPhotoOptions = true
                                self.sourceType = .camera
                            },
                            .cancel()
                        ])
                        
                }
                Text(classificationLabel)
                    .font(.system(size: 26))
                    .padding(.top, 20)
                    .padding(.bottom, 20)
                
                Button("Classify") {
                    
                    if let img = self.image {
                        self.classifier?.classify(img) { result in
                            self.classificationLabel = result
                        }
                    }
                    
                }
                .fontWeight(.semibold)
                .padding(.horizontal,45)
                .padding(.vertical,15)
                .background(Color.yellow.opacity(0.7))
                .cornerRadius(12)
                .foregroundColor(.black)
                .padding(.bottom,20)
                Spacer()
            }
            .navigationBarTitle("Image Classification")
        }.sheet(isPresented: $showPhotoOptions) {
            ImagePicker(image: self.$image, isShown: self.$showPhotoOptions, sourceType: self.sourceType)
        }
    }
}

struct ImagePredictView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePredictView()
    }
}

