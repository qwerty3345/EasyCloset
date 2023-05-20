//
//  PhotoController.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import UIKit

import PhotosUI
import Combine

enum PhotoPickerError: Error {
  case transferError(error: Error)
  case invalidImage
}

final class PhotoPicker: NSObject {
  
  // MARK: - Properties
  
  private weak var viewController: UIViewController?
  
  private let imageSubject = PassthroughSubject<UIImage, PhotoPickerError>()
  
  // MARK: - Initialization
  
  init(parent viewController: UIViewController) {
    self.viewController = viewController
    super.init()
  }
  
  // MARK: - Public Methods
  
  func requestCamera() -> AnyPublisher<UIImage, PhotoPickerError> {
    let picker = UIImagePickerController()
    picker.sourceType = .camera
    picker.allowsEditing = true
    picker.cameraDevice = .rear
    picker.cameraCaptureMode = .photo
    picker.delegate = self
    
    viewController?.present(picker, animated: true)
    return imageSubject.eraseToAnyPublisher()
  }
  
  func requestAlbum() -> AnyPublisher<UIImage, PhotoPickerError> {
    var configuration = PHPickerConfiguration()
    configuration.filter = .images
    let picker = PHPickerViewController(configuration: configuration)
    picker.delegate = self
    
    viewController?.present(picker, animated: true)
    return imageSubject.eraseToAnyPublisher()
  }
  
  // MARK: - Private Methods
  func getDocumentsDirectory() -> URL? {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths.first
  }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
// 카메라 촬영 _ UIImagePickerController
extension PhotoPicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    guard let image = info[.editedImage] as? UIImage else {
      imageSubject.send(completion: .failure(.invalidImage))
      return
    }
    
    imageSubject.send(image)
    picker.dismiss(animated: true)
  }
}

// MARK: - PHPickerViewControllerDelegate
// 갤러리 선택 _ PHPicker
extension PhotoPicker: PHPickerViewControllerDelegate {
  func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
    picker.dismiss(animated: true)
    
    let itemProvider = results.first?.itemProvider
    guard let itemProvider = itemProvider,
          itemProvider.canLoadObject(ofClass: UIImage.self) else { return }
    
    itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
      guard let self = self else { return }
      
      if let error = error {
        self.imageSubject.send(completion: .failure(.transferError(error: error)))
      }
      
      DispatchQueue.main.async {
        guard let image = image as? UIImage else {
          self.imageSubject.send(completion: .failure(.invalidImage))
          return
        }
        self.imageSubject.send(image)
      }
    }
  }
}
