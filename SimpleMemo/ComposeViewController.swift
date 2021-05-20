//
//  ComposeViewController.swift
//  SimpleMemo
//
//  Created by 이문정 on 2021/05/19.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    var memoListViewModel = MemoViewModel()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.memoTextView.resignFirstResponder()
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
