//
//  TaskAddViewController.swift
//  TaskToDoApp
//
//  Created by 福島悠樹 on 2020/06/14.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import UIKit
import PKHUD

class TaskAddViewController: UIViewController, ToDoListDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var todoTextField: UITextField!
    
    //var photoSelects:[PhotoSelect] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ToDoListMgr.sharedInstance.delegate = self
        
        setupNavigationBar()

        // Do any additional setup after loading the view.
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
        title = "Add"
        let rightButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(tapSaveButton))
        navigationItem.rightBarButtonItem = rightButtonItem
    }
    
    @objc func tapSaveButton() {
        guard let title = titleTextField.text, let memo=todoTextField.text else {
            return
        }
        
        // titleが空白のときのエラー処理
        if title.isEmpty {
            print(title, "👿titleが空っぽだぞ〜")
            HUD.flash(.labeledError(title: nil, subtitle: "👿 タイトルが入力されていません！！！"), delay: 1)
            //showAlert("👿 タイトルが入力されていません！！！")
            return // return を実行すると、このメソッドの処理がここで終了する。
        }
        
        // tasksにAddする処理
        let photoSelect = PhotoSelect(title: title, memo: memo)
        ToDoListMgr.sharedInstance.appendToDoList(photoSelect: photoSelect)
        ToDoListMgr.sharedInstance.saveListData()

        HUD.flash(.success, delay: 0.3)
        // 前の画面に戻る
        navigationController?.popViewController(animated: true)
    }
}
