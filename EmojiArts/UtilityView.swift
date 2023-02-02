//
//  UtilityView.swift
//  EmojiArts
//
//  Created by Guru Mahan on 23/12/22.
//

import Foundation
import SwiftUI

struct OptionalImage: View{
    var uiImage: UIImage?
    
    var body: some View{
        if uiImage != nil{
            Image(uiImage: uiImage!)
        }
    }
    
}



struct AnimationActionButton: View{
    var title: String? = nil
    var systemImage: String? = nil
    let action: () -> Void
    
    var body: some View{
        Button{
            withAnimation{
                action()
            }
            
        } label: {
            if title != nil && systemImage != nil {
                Label(title!, systemImage:  systemImage!)
            } else if title != nil {
                Text(title!)
                
            } else if systemImage != nil {
                Image(systemName: systemImage!)
            }
        }
    }
}
