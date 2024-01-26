//
//  FormType.swift
//  coreDataSave
//
//  Created by jackychoi on 11/1/2024.
//MARK: Source Code refer to youtube "My Images Core Data" https://www.youtube.com/watch?v=og1R6HIYU5c&list=PLBn01m5Vbs4DYmnxdD1ZuEJA7yXqHcSEd&index=1

import SwiftUI

enum FormType: Identifiable, View{
    case new(UIImage)
    case update(MyImage)
    
    var id: String{
        switch self{
        case .new:
            return "new"
            
        case .update:
            return "update"
        }
    }
    
    var body: some View{
        switch self {
        case .new(let uiImage):
            return ImageFormView(viewModel: FormViewModel(uiImage))
        case .update(let myImage):
            return ImageFormView(viewModel: FormViewModel(myImage))
        }
    }
}
