//
//  MainViewController.swift
//  SimpleMemo
//
//  Created by 이문정 on 2021/05/19.
//

import UIKit


class MainViewController: UIViewController {
    
    var memo: Memo?
    var memoListViewModel = MemoViewModel()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy. MM. dd"
        return f
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //        addButton.layer.shadowColor = UIColor.gray.cgColor
        //        addButton.layer.shadowOpacity = 1.0
        //        addButton.layer.shadowOffset = CGSize.zero
        //        addButton.layer.shadowRadius = 6
        
        tableView.reloadData()
        memoListViewModel.loadTasks()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memoListViewModel.loadTasks()
        self.tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            if let vc = segue.destination as? DetailViewController {
                vc.memo = memoListViewModel.memos[indexPath.row]
            }
        }
        
        
    }
    
    @IBAction func editButtonClicked(_ sender: Any) {
        if self.tableView.isEditing {
            self.editButton.setTitle("편집", for: .normal)
            self.tableView.setEditing(false, animated: true)
        } else {
            self.editButton.setTitle("완료", for: .normal)
            self.tableView.setEditing(true, animated: true)
        }
    }
    
}

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoListViewModel.memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainViewControllerTableViewCell") as? MainViewControllerTableViewCell else { return
            UITableViewCell() }
        let target = memoListViewModel.memos[indexPath.row]
        cell.tableViewLabel.text = target.content
        cell.tableViewDateLabel.text = formatter.string(for: target.date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let row = memoListViewModel.memos[indexPath.row]
            memoListViewModel.deleteMemo(row)
            // 배열에서도 삭제 해줘야함
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    // 셀 순서 바꾸기
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        memoListViewModel.swapMemo(sourceIndexPath.row, destinationIndexPath.row)
    }
}
