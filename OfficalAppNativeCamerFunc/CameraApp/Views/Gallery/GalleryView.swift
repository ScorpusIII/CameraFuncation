//
//  GalleryView.swift
//  CameraApp
//
//  Created by Slayter Jameson on 09/04/21.
//

import SwiftUI
import Photos

struct GalleryView: View {
    
    @State var galleryVM = GalleryVM()
    @State var selectedIndex:[Int] = []
    @Binding var isGallery: Bool
    @State var currentImageSelected:UIImage?

    var body: some View {
        
        GeometryReader { geometry in
            VStack(spacing:0){
                CustomNavigationBar(title: "Add New Post", leftButtonAction: {
                    isGallery = false
                }, rightButtonAction: {}).zIndex(1)
                ImageStackView(selectedIndex: selectedIndex, isGallery: $isGallery, currentImageSelected: $currentImageSelected).zIndex(0)
                GalleryStackView(selectedIndex: $selectedIndex, photos: $galleryVM.photos, currentImageSelected: $currentImageSelected)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .onAppear(){
                self.galleryVM = GalleryVM()
            }
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct ImageStackView: View {
    
    var selectedIndex:[Int]
    @Binding var isGallery: Bool
    @Binding var currentImageSelected:UIImage?
    
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .bottom){
                
                Color.clear
                
                //Image
                if let currentImageSelected = currentImageSelected{
                    Image.init(uiImage: currentImageSelected)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .clipped()
                }else{
                    VStack{
                        Spacer()
                        Text("No Image Selected!")
                            .font(.system(size: 16))
                        Spacer()
                    }
                }
                
                //Bar
                HStack{
                    ZStack{
                        Color.black.opacity(0.6)
                        HStack{
                            Spacer()
                            ZStack(){
                                Color.clear
                                Button(action:{
                                }){
                                    Image.init("image-gallery (1)")
                                        .resizable()
                                        .frame(width: 23, height: 23)
                                }
                                if(selectedIndex.count > 0){
                                    VStack{
                                        HStack{
                                            Spacer()
                                            Text("\(selectedIndex.count)")
                                                .foregroundColor(Color.white)
                                                .frame(width: 18, height: 18)
                                                .background(Color.red)
                                                .cornerRadius(9)
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            .frame(width: 30, height: 30)
                            
                            Spacer().frame(width: 30)
                            
                            Button(action:{
                                isGallery = false
                            }){
                                Image.init("photo-camera")
                                    .resizable()
                                    .frame(width: 23, height: 23)
                            }
                            Spacer().frame(width: 20)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height*0.15, alignment: .bottom)
            }
        }
        
    }
}

struct GalleryStackView: View {
    
    @Binding var selectedIndex:[Int]
    @Binding var photos:PHFetchResult<PHAsset>
    @Binding var currentImageSelected:UIImage?
    
    let columns = [
        GridItem(.flexible(), spacing:0),
        GridItem(.flexible(), spacing:0),
        GridItem(.flexible(), spacing:0),
        GridItem(.flexible(), spacing:0),
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .bottom){
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(0..<photos.count, id: \.self) { index in
                            let image = photos.object(at: index).getAssetThumbnail(size: CGSize(width: geometry.size.width/4, height: geometry.size.width/4))
 
                            Button(action:{
                                if selectedIndex.contains(index){
                                    selectedIndex.remove(at: selectedIndex.firstIndex(of: index)!)
                                }else{
                                    if selectedIndex.count >= 4{
                                        return
                                    }
                                    selectedIndex.append(index)
                                    currentImageSelected = photos.object(at: index).getAssetThumbnail(size: CGSize(width: geometry.size.width, height: geometry.size.height))
                                }
                            }){
                                GalleryTile(image: image, isSelected: selectedIndex.contains(index))
                                    .frame(width:geometry.size.width/4, height: geometry.size.width/4)
                            }
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)

                //ConfirmView
                if selectedIndex.count >= 1{
                    VStack{
                        Spacer()
                        ConfirmView()
                            .frame(width: geometry.size.width, height: geometry.size.height*0.4)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct ConfirmView: View {
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(){
                Color.black.opacity(0.8)
                VStack{
                    Spacer().frame(height:16)
                    Button(action:{
                    }){
                        Text("Confirm")
                            .foregroundColor(Color.white)
                            .font(.system(size: 18, weight: .semibold))
                    }
                    .frame(width: geometry.size.width - 40, height: 55)
                    .background(Color.init("buttonColor"))
                    .cornerRadius(27.5)
                    Spacer()
                }
            }
        }
    }
}

//struct GalleryView_Previews: PreviewProvider {
//    static var previews: some View {
//        GalleryView()
//    }
//}
