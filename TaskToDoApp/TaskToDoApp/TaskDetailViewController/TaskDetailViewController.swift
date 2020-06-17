//
//  TaskDetailViewController.swift
//  TaskToDoApp
//
//  Created by 福島悠樹 on 2020/06/14.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController, ToDoListDelegate {

    @IBOutlet weak var detailTitle: UITextField!
    @IBOutlet weak var detailTodoText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        ToDoListMgr.sharedInstance.delegate = self
        
        configureTask()
        // Do any additional setup after loading the view.
    }
    
    private func configureTask() {
        detailTitle.text = ToDoListMgr.sharedInstance.getPhotoListsTitle(indexPathRow: ToDoListMgr.sharedInstance.getIndexPathRowOfDetailList())
        
        detailTodoText.text = ToDoListMgr.sharedInstance.getPhotoListsMemo(indexPathRow: ToDoListMgr.sharedInstance.getIndexPathRowOfDetailList())
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func setupNavigationBar() {
         title = "Select"
         let rightButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton))
         navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func tapSaveButton() {
        if let title = detailTitle.text{
            ToDoListMgr.sharedInstance.setPhotoListsTitle(indexPathRow: ToDoListMgr.sharedInstance.getIndexPathRowOfDetailList(), title: title)
        }
        if let memo = detailTodoText.text{
            ToDoListMgr.sharedInstance.setPhotoListsMemo(indexPathRow: ToDoListMgr.sharedInstance.getIndexPathRowOfDetailList(), memo: memo)
        }
        ToDoListMgr.sharedInstance.saveListData()
        
        // 前の画面に戻る
        navigationController?.popViewController(animated: true)
    }
}
