//
//  PhotoPicker.swift
//  EasyCloset
//
//  Created by Mason Kim on 2023/05/20.
//

import UIKit

import PhotosUI
import Combine

enum PhotoPickerError: LocalizedError {
  case transferError(error: Error)
  case invalidImage
  case authorizationDenied
  
  var errorDescription: String? {
    switch self {
    case .transferError(let error):
      return "에러가 발생했습니다. \(error)"
    case .invalidImage:
      return "이미지를 불러오는데 실패했습니다."
    case .authorizationDenied:
      return "카메라 접근 권한이 없습니다. \n설정으로 이동하시겠어요?"
    }
  }
}

final class PhotoPicker: NSObject {
  
  typealias ImageCompletionHandler = (Result<UIImage, PhotoPickerError>) -> Void
  
  // MARK: - Properties
  
  private weak var viewController: UIViewController?
  
  private var imageCompletionHandler: ImageCompletionHandler?
  
  // MARK: - Initialization
  
  init(parent viewController: UIViewController) {
    self.viewController = viewController
    super.init()
  }
  
  // MARK: - Public Methods
  
  func requestCamera() -> AnyPublisher<UIImage, PhotoPickerError> {
    return Future { [weak self] promise in
      guard let self = self else { return }
      
      self.checkAndRequestCameraPermission { isGranted in
        guard isGranted else {
          promise(.failure(.authorizationDenied))
          return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.cameraDevice = .rear
        picker.cameraCaptureMode = .photo
        picker.delegate = self
        
        DispatchQueue.main.async {
          self.viewController?.present(picker, animated: true)
        }
        
        self.imageCompletionHandler = { result in
          switch result {
          case .success(let image):
            promise(.success(image))
          case .failure(let error):
            promise(.failure(error))
          }
        }
      }
    }.eraseToAnyPublisher()
  }
  
  func requestAlbum() -> AnyPublisher<UIImage, PhotoPickerError> {
    return Future { [weak self] promise in
      guard let self = self else { return }
      
      var configuration = PHPickerConfiguration()
      configuration.filter = .images
      let picker = PHPickerViewController(configuration: configuration)
      picker.delegate = self
      
      DispatchQueue.main.async {
        self.viewController?.present(picker, animated: true)
      }
      
      self.imageCompletionHandler = { result in
        switch result {
        case .success(let image):
          promise(.success(image))
        case .failure(let error):
          promise(.failure(error))
        }
      }
    }.eraseToAnyPublisher()
  }
  
  // MARK: - Private Methods
  private func checkAndRequestCameraPermission(completion: @escaping (Bool) -> Void) {
      let status = AVCaptureDevice.authorizationStatus(for: .video)
      switch status {
      case .notDetermined:
        AVCaptureDevice.requestAccess(for: .video) { isGranted in
          completion(isGranted)
        }
      case .authorized:
        completion(true)
      case .denied:
        completion(false)
      case .restricted:
        completion(false)
      @unknown default:
        break
      }
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
// 카메라 촬영 _ UIImagePickerController
extension PhotoPicker: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController,
                             didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    guard let image = info[.editedImage] as? UIImage else {
      imageCompletionHandler?(.failure(.invalidImage))
      return
    }
    imageCompletionHandler?(.success(image))
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
        self.imageCompletionHandler?(.failure(.transferError(error: error)))
      }
      
      DispatchQueue.main.async {
        guard let image = image as? UIImage else {
          self.imageCompletionHandler?(.failure(.invalidImage))
          return
        }
        self.imageCompletionHandler?(.success(image))
      }
    }
  }
}
