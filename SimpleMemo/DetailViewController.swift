//
//  DetailViewController.swift
//  SimpleMemo
//
//  Created by 이문정 on 2021/05/19.
//

import UIKit

class DetailViewController: UIViewController, UITextViewDelegate {

    var memo: Memo?
    var memoListViewModel = MemoViewModel()
    @IBOutlet weak var doneButtonTrailing: NSLayoutConstraint!
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBAction func backButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareButtonClicked(_ sender: Any) {
        guard let memo = memo?.content else { return }
        
        let vc = UIActivityViewController(activityItems: [memo], applicationActivities: nil)
        present(vc, animated: true, completion: nil)
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        guard let content = detailTextView.text, content.isEmpty == false else { return }
        
        memo?.content = content
        memo?.date = Date()
        memoListViewModel.updateMemo(memo!)

        self.navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailTextView.text = memo?.content
        detailTextView.delegate = self
        self.doneButtonTrailing.constant = -40
        
        // Do any additional setup after loading the view.
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        self.doneButtonTrailing.constant = 25
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
