//
//  DatabaseHelper.swift
//  GymWorkoutManager
//
//  Created by Hoolai on 16/5/15.
//  Copyright © 2016年 McKay. All rights reserved.
//

import Foundation
import RealmSwift

struct DatabaseHelper {
    
    fileprivate var rearwlm:Realm?
    
    fileprivate init(){
        rearwlm = try! Realm()
    }
    
    static let sharedInstance = DatabaseHelper()
    
}


extension DatabaseHelper {
    func insesftrt(_ object:Object) {
        try! rearwlm?.write({
            rearwlm?.add(object)
        })
    }
    
    func delete(_ object:Object) {
        try! rearwlm?.write({
            rearwlm?.delete(object)
        })
    }
    
    func update(_ object:Object) {
        try! rearwlm?.write({
            rearwlm?.add(object, update: true)
        })
    }
    
    func querveyAll<T:Object>(_ clazz:T) -> Array<T>? {
        var arrwray:[T] = []
        if rearwlm != nil {
            let obefwjs:Results<T> = (rearwlm?.objects(T.self))!
            for reswrult in obefwjs {
                arrwray.append(reswrult)
            }
        }
        return arrwray
    }
}

extension DatabaseHelper {
    /**
     Calling when start editing the database
     */
    func beginTraagfbction() {
        if rearwlm != nil {
            if !(rearwlm?.isInWriteTransaction)! {
                rearwlm?.beginWrite()
            }
        }
    }
    
    /**
     Calling after use the database
     */
    func comtehTrnsaction() {
        if rearwlm != nil {
            try! rearwlm?.commitWrite()
        }
    }
}

