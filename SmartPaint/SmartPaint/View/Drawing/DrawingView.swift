//
//  DrawingView.swift
//  SmartArt
//
//  Created by jackychoi on 3/1/2024.
//

import SwiftUI
import PencilKit

struct DrawingView: View {
    var body: some View{
        MultiDrawView()
    }
}



struct MultiDrawView : View {
    
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color : Color = .black
    @State var type : PKInkingTool.InkType = .pencil
    @State var colorPicker = false
    
    var body: some View{
        NavigationView{
            // Drawing View...
            DrawPageView(canvas: $canvas, isDraw: $isDraw,type: $type,color: $color)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    
                    // saving Image...
                    SaveImage()
                    
                }, label: {
                    
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.title)
                }),trailing: HStack(spacing:15){
                    
                    Button(action: {
                        
                        // erase tool...
                        isDraw = false
                        
                    }){
                        Image(systemName: "eraser")
                            .font(.title)
                    }
                    
                    // menu for inkType
                    
                    Menu {
                        
                        //Color Picker...
                        Button (action: {
                            
                            colorPicker.toggle()
                        }){
                            Label{
                                
                                Text("Color")
                                
                            }icon: {
                                Image(systemName: "eyedropper.full")
                            }
                        }
                        Button (action: {
                            
                            // chaing type...
                            isDraw = true
                            type = .pencil
                        }){
                            Label{
                                
                                Text("Pencil")
                                
                            }icon: {
                                Image(systemName: "pencil")
                            }
                        }
                        
                        Button (action: {
                            
                            isDraw = true
                            type = .pen
                            
                        }){
                            Label{
                                
                                Text("Pen")
                                
                            }icon: {
                                Image(systemName: "pencil.tip")
                            }
                        }
                        
                        Button (action: {
                            
                            isDraw = true
                            type = .marker
                        }){
                            Label{
                                
                                Text("Marker")
                                
                            }icon: {
                                Image(systemName: "highlighter")
                            }
                        }
                        
                    } label: {
                        Image("menu")
                            .resizable()
                            .frame(width: 22, height: 22)
                    }
                    
                })
                .sheet(isPresented: $colorPicker){
                    ColorPicker("Pick Color", selection: $color)
                        .padding()
                }
        }
    }
    
    func SaveImage(){
        // gettting image from cavas...
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

struct DrawPageView: UIViewRepresentable{
    
    @Binding var canvas : PKCanvasView
    @Binding var isDraw : Bool
    @Binding var type : PKInkingTool.InkType
    @Binding var color : Color
    
    var ink : PKInkingTool{
        PKInkingTool(type, color: UIColor(color))
    }
    
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDraw ? ink : eraser
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        //updating
        
        uiView.tool = isDraw ? ink : eraser
    }
}
