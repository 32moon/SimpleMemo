////
////  textViewImageViewController.swift
////  SimpleMemo
////
////  Created by 이문정 on 2021/05/22.
////
//
//import UIKit
//
//class textViewImageViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.navigationItem.title = "Main View"
//
//        addUITextView()
//        
//    }
//
//    func addUITextView(){
//
//        //lauout for the View
//        let myTextView = UITextView()
//        myTextView.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addSubview(myTextView)
//
//        let views = [
//            "view" : view,
//            "textView" : myTextView
//        ]
//
//        var allConstraints: [NSLayoutConstraint] = []
//        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "V:|-[textView]-|",
//                                                         options: [], metrics: nil, views: views as [String : Any])
//        allConstraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-[textView]-|",
//                                                         options: [], metrics: nil, views: views as [String : Any])
//        NSLayoutConstraint.activate(allConstraints)
//
//        // start with our text data
//        let font = UIFont.systemFont(ofSize: 26)
//        let attributes: [NSAttributedString.Key: Any] = [
//            .font: font,
//            .foregroundColor: UIColor.orange
//        ]
//        let myString = NSMutableAttributedString(string: "Text at the beginning\n",
//                                                 attributes: attributes)
//
//        // A text attachment object contains either an NSData object or an FileWrapper object,
//        // which in turn holds the contents of the attached file.
//        let imageAttachment = NSTextAttachment()
//        imageAttachment.image = UIImage(named: "addButton")!
//        let imageSize = imageAttachment.image!.size.width;
//
//        // calculate how much to resize our image
//        // here we are doing it base on the space available in the view
//        var frameSize = self.view.frame.size.width - 100;
//        let topBarHeight = UIApplication.shared.statusBarFrame.size.height +
//            (self.navigationController?.navigationBar.frame.height ?? 0.0)
//        let height = self.view.frame.size.height - topBarHeight - 100;
//        if(height < frameSize) {
//            frameSize = height;
//        }
//        let scaleFactor = imageSize / frameSize;
//
//        // scale the image down
//        imageAttachment.image = UIImage(cgImage: imageAttachment.image!.cgImage!, scale: scaleFactor, orientation: .up)
//
//        // create attributed string from image so we can append it
//        let imageString = NSAttributedString(attachment: imageAttachment)
//
//        // add the NSTextAttachment wrapper to our original string, then add some more text.
//        myString.append(imageString)
//        myString.append(NSAttributedString(string: "\nTHE END!!!", attributes: attributes))
//
//        // set the text for the UITextView
//        myTextView.attributedText = myString;
//
//
//    }
//
//}
