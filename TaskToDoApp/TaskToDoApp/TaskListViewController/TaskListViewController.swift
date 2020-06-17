//
//  TaskListViewController.swift
//  TaskToDoApp
//
//  Created by 福島悠樹 on 2020/06/14.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import UIKit

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,ToDoListDelegate {

    @IBOutlet weak var CustomTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CustomTableView.delegate = self
        CustomTableView.dataSource = self
        ToDoListMgr.sharedInstance.delegate = self
        
        configureTableViewCell()
        
        setupNavigationBar()

        // Do any additional setup after loading the view.
    }
    
    //#warning("画面描画のたびにtableViewを更新")
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)  //元々表示されているものは全て表示
        
        //Dataのload
        ToDoListMgr.sharedInstance.loadListData()
        
        //TableViewを更新
        CustomTableView.reloadData()
    }
    
    // navigation barの設定
    private func setupNavigationBar() {
        let rightButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(showAddScreen))
        navigationItem.rightBarButtonItem = rightButtonItem
    }

    //warning("navigation barのボタンをタップしたときの動作")
    @objc func showAddScreen() {
        let vc = TaskAddViewController()
        // ★vc.photoSelects = photoLists
        navigationController?.pushViewController(vc, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    /* ★TableViewCellを読み込む(登録する)関数 */
    func configureTableViewCell(){
        /* nibを作成*/
        let nib = UINib(nibName: "CustomTableViewCell", bundle: nil)
        
        /* ID */
        let cellID = "CustomTableViewCell"
        
        /* 登録 */
        CustomTableView.register(nib, forCellReuseIdentifier: cellID)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ToDoListMgr.sharedInstance.getPhotoListsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as! CustomTableViewCell
        
        cell.titleLabel.text = ToDoListMgr.sharedInstance.getPhotoListsTitle(indexPathRow:indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TaskDetailViewController()
        ToDoListMgr.sharedInstance.setIndexPathRowOfDetailList(indexPathRow: indexPath.row) //選択行を記憶
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /* スワイプして削除 */
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        ToDoListMgr.sharedInstance.removeToDoList(indexPathRow:indexPath.row)   //削除
        ToDoListMgr.sharedInstance.saveListData()                               //保存
        
        tableView.reloadData()
    }
}
