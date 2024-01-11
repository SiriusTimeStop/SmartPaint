//
//  FormType.swift
//  coreDataSave
//
//  Created by jackychoi on 11/1/2024.
//

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
