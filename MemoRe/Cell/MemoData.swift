//
//  MemoData.swift
//  MemoRe
//
//  Created by 한규철 on 10/25/R4.
//

import UIKit
import FMDB

class MemoData: NSObject {
    
    var memoId: Int = 0
    var title: String?
    var contents: String?
    var regDate: Date?
    
    override init() {
        super.init()
    }
    
        
    init(rs: FMResultSet) {
        super.init()
        self.memoId = Int(rs.int(forColumn: "id"))
        self.title = rs.string(forColumn: "title")
        self.contents = rs.string(forColumn: "contents")
        self.regDate = Date(timeIntervalSince1970: TimeInterval(rs.int(forColumn: "reg_date")))
    }
}
