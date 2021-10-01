//
//  CameraView.swift
//  CameraApp
//
//  Created by Slayter Jameson on 09/03/21.
//

import SwiftUI

extension UIScreen{
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenSize = UIScreen.main.bounds.size
}

struct CameraView: View {
    @State var image: UIImage?
    @State var didTapCapture: Bool = false
    @State var isImageCaptured: Bool = false
    @State var isGallery: Bool = false
    @State var changeCamera:Bool = false
    
    var body: some View {
        
        GeometryReader { geometry in
            
            NavigationLink(destination: CaptureView(image: $image, isGallery: $isGallery), isActive: $isImageCaptured) { EmptyView() }
            NavigationLink(destination: GalleryView(isGallery: $isGallery), isActive: $isGallery) { EmptyView() }
            
            VStack(spacing:0){
                CustomNavigationBar(title: "Add New Post", leftButtonAction: {}, rightButtonAction: {})
                ZStack{
                    Color.clear
                    CameraLayerView(image: $image, didTapCapture: $didTapCapture, isImageCaptured: $isImageCaptured, changeCamera: $changeCamera)
                    ControlLayerView(didTapCapture: $didTapCapture, isGallery: $isGallery, changeCamera: $changeCamera)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            //.background(Color.green)
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }.edgesIgnoringSafeArea(.bottom)
    }
}

struct CameraLayerView: View {
    
    @Binding var image: UIImage?
    @Binding var didTapCapture:Bool
    @Binding var isImageCaptured: Bool
    @Binding var changeCamera: Bool

    var body: some View {
        //Image.init("portatit").resizable()
        CustomCameraRepresentable(image: self.$image, didTapCapture: $didTapCapture, isImageCaptured: $isImageCaptured, changeCamera: $changeCamera)
    }
}

struct ControlLayerView: View {
    @Binding var didTapCapture:Bool
    @Binding var isGallery:Bool
    @Binding var changeCamera: Bool

    var body: some View {
        GeometryReader { geometry in
            let bottomViewH = (geometry.size.height*0.21)
            VStack(spacing:0){
                HStack{
                    ZStack{
                        Color.black.opacity(0.6)
                        HStack{
                            Spacer().frame(width: 20)
                            Button(action:{
                                isGallery = true;
                            }){
                                Image.init("image-gallery (1)")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                            Spacer()
                            Button(action:{
                                changeCamera = true
                            }){
                                Image.init("flip")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                            Spacer().frame(width: 20)
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height*0.1, alignment: .center)
                .zIndex(1)
                GridLinesView()
                HStack{
                    ZStack{
                        Color.black.opacity(0.6)
                        VStack{
                            Spacer().frame(height: 20)
                            Button(action:{
                                didTapCapture = true
                            }){
                                Text("rerewrer")
                                    .foregroundColor(Color.init("RedInner"))
                            }
                            .frame(width: bottomViewH*0.3, height: bottomViewH*0.3)
                            .background(Color.init("RedInner"))
                            .cornerRadius((bottomViewH*0.3)/2)
                            .padding(10)
                            .background(Color.init("RedOuter"))
                            .cornerRadius((bottomViewH*0.3 + 20)/2)
                            Spacer()
                        }
                    }
                }
                .frame(width: geometry.size.width, height: bottomViewH)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
            .background(Color.clear)
        }
    }
}

struct GridLinesView: View {
    
    var borderWidth:CGFloat = 1
    
    var body: some View {
        GeometryReader { geometry in
            
            let height = (geometry.size.height)/3
            
            VStack(spacing:0){
                HStack(spacing:0){
                    Spacer()
                    HStack{}.frame(width: borderWidth, height: height).background(Color.white)
                    Spacer()
                    HStack{}.frame(width: borderWidth, height: height).background(Color.white)
                    Spacer()
                }
                HStack{}.frame(width: geometry.size.width, height: borderWidth).background(Color.white)
                ZStack{
                    HStack(spacing:0){
                        Spacer()
                        HStack{}.frame(width: borderWidth, height: height).background(Color.white)
                        Spacer()
                        HStack{}.frame(width: borderWidth, height: height).background(Color.white)
                        Spacer()
                    }
                    Image.init("plus")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: height*0.15, height: height*0.15)
                        .clipped()
                }
                HStack{}.frame(width: geometry.size.width, height: borderWidth).background(Color.white)
                HStack(spacing:0){
                    Spacer()
                    HStack{}.frame(width: borderWidth, height: height).background(Color.white)
                    Spacer()
                    HStack{}.frame(width: borderWidth, height: height).background(Color.white)
                    Spacer()
                }
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

//struct CameraView_Previews: PreviewProvider {
//   static var previews: some View {
//      CameraView()
//  }
//}
