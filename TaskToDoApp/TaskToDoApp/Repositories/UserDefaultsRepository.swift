//
//  UserDefaultsRepository.swift
//  TaskToDoApp
//
//  Created by 福島悠樹 on 2020/06/14.
//  Copyright © 2020 福島悠樹. All rights reserved.
//

import Foundation

class UserDefaultsRepository {
    // UserDefaults に使うキー
    static let userDefaultsSelectsKey:String = "user_selects"

    static func saveToUserDefaults(selects:[PhotoSelect]){
        //Data型に変換処理
        let encorder = JSONEncoder()
        let data = try! encorder.encode(selects)
        
        //UserDefaultsに保存
        UserDefaults.standard.set(data, forKey: userDefaultsSelectsKey)
        
    }

    static func loadFromUserDefaults()->[PhotoSelect]{
        let decorder = JSONDecoder()
        
        //UserDefaultsから読み出し
        guard let data = UserDefaults.standard.data(forKey: userDefaultsSelectsKey)else{ return [] }
        
        //dataから[Task]に変換
        let selects = try! decorder.decode([PhotoSelect].self, from: data)
        
        return selects
    }
}
