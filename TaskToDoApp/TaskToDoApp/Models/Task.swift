//
//  Task.swift
//  TaskToDoApp
//
//  Created by 福島悠樹 on 2020/06/14.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import Foundation
import UIKit

// プロパティに title と memo を持っている
class PhotoSelect: Codable {
    var title: String
    var memo: String
    
    init(title:String, memo: String) {
        self.title = title
        self.memo = memo
    }
}

protocol ToDoListDelegate:class{
    /* NoAction */
}

class ToDoListMgr{
    static let sharedInstance = ToDoListMgr()
    
    var photoLists: [PhotoSelect] = [PhotoSelect(title: "", memo: "")]
    var indexPathRowOfDetailList:Int = 0
    
    weak var delegate:ToDoListDelegate?
    
    /* 詳細画面の行番号セット */
    func setIndexPathRowOfDetailList(indexPathRow:Int){
        self.indexPathRowOfDetailList = indexPathRow
    }
    
    /* 詳細画面の行番号ゲット */
    func getIndexPathRowOfDetailList() -> Int{
        return self.indexPathRowOfDetailList
    }
    
    /* 指定行番号のタイトルセット */
    func setPhotoListsTitle(indexPathRow:Int, title:String){
        self.photoLists[indexPathRow].title = title
    }
    
    /* 指定行番号のタイトルゲット */
    func getPhotoListsTitle(indexPathRow:Int) -> String{
        return self.photoLists[indexPathRow].title
    }
    
    /* 指定行番号のメモセット */
    func setPhotoListsMemo(indexPathRow:Int, memo:String){
        self.photoLists[indexPathRow].memo = memo
    }
    
    /* 指定行番号のメモゲット */
    func getPhotoListsMemo(indexPathRow:Int) -> String{
        return self.photoLists[indexPathRow].memo
    }
    
    /* リストの数を取得 */
    func getPhotoListsCount() -> Int{
        return self.photoLists.count
    }
    
    /* リストに指定要素を追加 */
    func appendToDoList(photoSelect:PhotoSelect){
        self.photoLists.append(photoSelect)
    }
    
    /* リストから指定要素を削除 */
    func removeToDoList(indexPathRow:Int){
        self.photoLists.remove(at: indexPathRow)
    }
    
    /* リストを保存 */
    func saveListData(){
        UserDefaultsRepository.saveToUserDefaults(selects: self.photoLists)
    }
    
    /* リストを読出 */
    func loadListData(){
        self.photoLists = UserDefaultsRepository.loadFromUserDefaults()
    }
}




 /*
class PhotoSelect{
    var image: UIImage?
    var title: String
    var memo: String
    
    init(title:String, memo: String,image:UIImage?) {
        self.image = image
        self.title = title
        self.memo = memo
    }
}
extension PhotoSelect: Codable {
    // Decodable
    enum CodingKeys: String, CodingKey {
        case image
        case title
        case memo
    }
        
    func decode(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let title = try values.decode(String.self, forKey: .title)
        let memo = try values.decode(String.self, forKey: .memo)
        
        let imageDataBase64String = try values.decode(String.self, forKey: .image)
        let image: UIImage?
        if let data = Data(base64Encoded: imageDataBase64String) {
            image = UIImage(data: data)
        } else {
            image = nil
        }
        self.init(title: title, memo: memo, image: image)
    }
    
    // Encodable
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)

        if let image = image, let imageData = UIImagePNGRepresentation(image) {
            let imageDataBase64String = imageData.base64EncodedString()
            try container.encode(imageDataBase64String, forKey: .image)
        }
    }
}
*/
