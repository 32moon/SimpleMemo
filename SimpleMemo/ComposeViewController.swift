//
//  ComposeViewController.swift
//  SimpleMemo
//
//  Created by 이문정 on 2021/05/19.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var memoListViewModel = MemoViewModel()
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var memoTextView: UITextView!
    
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        guard let content = memoTextView.text, content.isEmpty == false else { return }
        
        let memo = MemoManager.shared.createMemo(content: content, date: Date())
        memoListViewModel.addMemo(memo)
        memoTextView.text = ""
        self.navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.memoTextView.resignFirstResponder()
        }
    
    // MARK: - PHOTO
    func openLibrary(){
      imagePicker.sourceType = .photoLibrary
      present(imagePicker, animated: false, completion: nil)
    }
    
    func openCamera(){
        imagePicker.sourceType = .camera
        present(imagePicker, animated: false, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var newImage: UIImage?
       
        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
          newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
          newImage = possibleImage
        }
        
        let newMemo = NSMutableAttributedString(string: memoTextView.text)
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = newImage
        
        let imageSize = imageAttachment.image!.size.width;
        var frameSize = self.view.frame.size.width.binade
        let height = self.view.frame.size.height.binade
        if(height < frameSize) {
            frameSize = height;
        }
        let scaleFactor = imageSize / frameSize;
        
        imageAttachment.image = UIImage(cgImage: imageAttachment.image!.cgImage!, scale: scaleFactor, orientation: .up)
        
        // create attributed string from image so we can append it
        let imageString = NSAttributedString(attachment: imageAttachment)
        
        // add the NSTextAttachment wrapper to our original string, then add some more text.
        newMemo.append(imageString)
        
        memoTextView.attributedText = newMemo
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cameraButtonCliked(_ sender: Any) {
        let alert = UIAlertController()
        let camera = UIAlertAction(title: "사진 촬영", style: .default) {(action) in self.openCamera()}
        let library = UIAlertAction(title: "앨범에서 사진 선택", style: .default) {(action) in self.openLibrary()}
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(camera)
        alert.addAction(library)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
    }
    
  

}
