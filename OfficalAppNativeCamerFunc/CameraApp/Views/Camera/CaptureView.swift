//
//  CaptureView.swift
//  CameraApp
//
//  Created by Slayter Jameson on 09/03/21.
//

import SwiftUI

struct CaptureView: View, ImageSaverDelegate {
    
    
    @Binding var image: UIImage?
    @Binding var isGallery: Bool
    @Environment(\.presentationMode) var presentation

    func imageSaved() {
        isGallery = true
    }
    
    func savePhoto() {
        let imageSaver = ImageSaver()
        imageSaver.delegate = self
        imageSaver.writeToPhotoAlbum(image: image!)
        
    }

    var body: some View {
        
        GeometryReader { geometry in
            
            ZStack(alignment: .bottom){
                Image.init(uiImage: image ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                VStack{
                    Spacer()
                    GeometryReader { geometry in
                        ZStack(){
                            Color.black.opacity(0.8)
                            VStack{
                                Spacer().frame(height:16)
                                Button(action:{savePhoto()
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
                        .frame(width: geometry.size.width, height: geometry.size.height*0.15)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button(action: { presentation.wrappedValue.dismiss() }) {
                                Image(systemName: "arrow.backward")
                                    .foregroundColor(.black)
                                    .imageScale(.large)
        })
        .navigationBarTitle("Captured Image", displayMode: .inline)
        .edgesIgnoringSafeArea(.bottom)
        .onDisappear(){
            image = nil;
        }
    }
}

//struct CaptureConfirmView: View {
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(){
//                Color.black.opacity(0.8)
//                VStack{
//                    Spacer().frame(height:16)
//                    Button(action:{savePhoto()
//                    }){
//                        Text("Confirm")
//                            .foregroundColor(Color.white)
//                            .font(.system(size: 18, weight: .semibold))
//                    }
//                    .frame(width: geometry.size.width - 40, height: 55)
//                    .background(Color.init("buttonColor"))
//                    .cornerRadius(27.5)
//                    Spacer()
//                }
//            }
//        }
//    }
//}

//struct CaptureView_Previews: PreviewProvider {
//    static var previews: some View {
//        CaptureView()
//    }
//}
