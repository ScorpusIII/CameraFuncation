//
//  GalleryTile.swift
//  CameraApp
//
//  Created by Slayter Jameson on 09/05/21.
//

import SwiftUI
import Photos

struct GalleryTile: View {
    var image:UIImage
    var isSelected:Bool
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){

                Image.init(uiImage:image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:geometry.size.width, height: geometry.size.height)
                    .clipped()
                
                //Checkmark
                if isSelected{
                    Color.blue.opacity(0.3)
                        .frame(width:geometry.size.width, height: geometry.size.height)
                    
                    Image.init("check-mark-circle (1)")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width/5.5, height: geometry.size.width/5.5)
                        .clipped()
                        .border(Color.white, width: 5)
                        .cornerRadius(4)
                        .padding(2)
                }
            }
            .frame(width:geometry.size.width, height: geometry.size.height)
        }
    }
}

//struct GalleryTile_Previews: PreviewProvider {
//    static var previews: some View {
//        GalleryTile()
//    }
//}
