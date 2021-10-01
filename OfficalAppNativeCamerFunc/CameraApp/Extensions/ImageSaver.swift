//
//  ImageSaver.swift
//  CameraApp
//
//  Created by Slayter Jameson on 9/8/21.
//

import UIKit

class ImageSaver: NSObject {
    
    var delegate: ImageSaverDelegate?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Save finished!")
        delegate?.imageSaved()
    }
}

protocol ImageSaverDelegate {
    func imageSaved()
}
