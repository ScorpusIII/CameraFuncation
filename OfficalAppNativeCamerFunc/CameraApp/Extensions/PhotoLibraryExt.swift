//
//  PhotoLibraryExt.swift
//  CameraApp
//
//  Created by Slayter Jameson on 09/05/21.
//

import SwiftUI

import Photos

extension PHPhotoLibrary {
    
    // MARK: - Public methods
    static func checkAuthorizationStatus(completion: @escaping (_ status: Bool) -> Void) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            completion(true)
        } else {
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                if newStatus == PHAuthorizationStatus.authorized {
                    completion(true)
                } else {
                    completion(false)
                }
            })
        }
    }
    
}

extension PHAssetCollection {
    
    // MARK: - Public methods
    
    func getCoverImgWithSize(_ size: CGSize) -> UIImage! {
        let assets = PHAsset.fetchAssets(in: self, options: nil)
        let asset = assets.firstObject
        return asset?.getAssetThumbnail(size: size)
    }
    
    func hasAssets() -> Bool {
        let assets = PHAsset.fetchAssets(in: self, options: nil)
        return assets.count > 0
    }
    
}

extension PHAsset {
    
    // MARK: - Public methods
    
    func getAssetThumbnail(size: CGSize) -> UIImage {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var thumbnail = UIImage()
        option.isSynchronous = true
        manager.requestImage(for: self, targetSize: size, contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
//            thumbnail = !
            if let res = result {
                thumbnail = res
            } else {
                thumbnail = UIImage()
            }
        })
        
        return thumbnail
    }
    
    func getOrginalImage(complition:@escaping (UIImage) -> Void) {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        var image = UIImage()
        manager.requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: option, resultHandler: {(result, info)->Void in
            image = result!
            
            complition(image)
        })
    }
    
    func getImageFromPHAsset() -> UIImage {
        var image = UIImage()
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.exact
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        requestOptions.isSynchronous = true
        
        if (self.mediaType == PHAssetMediaType.image) {
            PHImageManager.default().requestImage(for: self, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: requestOptions, resultHandler: { (pickedImage, info) in
                image = pickedImage!
            })
        }
        return image
    }
    
}
