//
//  GalleryVM.swift
//  CameraApp
//
//  Created by Slayter Jameson on 09/05/21.
//

import SwiftUI
import Photos

class GalleryVM:ObservableObject{
    
    //var albums:[PHAssetCollection] = []
    @Published var photos:PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()
    
    init() {
        fetchAndCreateImageArray()
    }
    
//    func fetchAlbums() {
//
//        self.albums.removeAll()
//        PHPhotoLibrary.checkAuthorizationStatus { (authrized) in
//
//            guard authrized else{
//                return
//            }
//
//            let result = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil)
//            result.enumerateObjects({ (collection, _, _) in
//                if (collection.hasAssets()) {
//                    self.albums.append(collection)
//                }
//            })
//            if(self.albums.count > 0){
//                self.fetchImagesFromGallery(collection: self.albums[0])
//            }
//        }
//    }
    
//    func fetchImagesFromGallery(collection: PHAssetCollection?) {
//            DispatchQueue.main.async {
//                let fetchOptions = PHFetchOptions()
//                fetchOptions.predicate = NSPredicate(format: "mediaType = %d", PHAssetMediaType.image.rawValue)
//                if let collection = collection {
//                    self.photos = PHAsset.fetchAssets(in: collection, options: fetchOptions)
//                } else {
//                    self.photos = PHAsset.fetchAssets(with: fetchOptions)
//                }
//                print(self.photos)
//            }
//        }
    
    func fetchAndCreateImageArray()
    {
        PHPhotoLibrary.checkAuthorizationStatus { (authrized) in

            guard authrized else{
                return
            }

            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor.init(key: "creationDate", ascending: false)]
            self.photos = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            
        }
    }
    
}
