//
//  MemoCell.swift
//  MemoRe
//
//  Created by 한규철 on 10/25/R4.
//

import UIKit

protocol MemoCellDelegate: AnyObject {
    func deleteBtnClicked(memo: MemoData?)
}

class MemoCell : UITableViewCell {

    @IBOutlet weak var mymemoTitle: UILabel!
    @IBOutlet weak var mymemoRegDate: UILabel!
    
    //메모 데이터 가져오기
    var memo: MemoData?
    //위에 있는 프로토콜
    weak var delegate: MemoCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUI() {
        
    }
    
    func setData(memo: MemoData) {
        self.memo = memo
        self.mymemoTitle.text = memo.title
        
        //DateFormaatter 객체 생성
        let formatter = DateFormatter()
//        formatter.dateStyle = .long
//        formatter.timeStyle = .medium
        formatter.dateFormat = "yyyy년 mm월 dd일"
        
        let str = formatter.string(from: Date())
        mymemoRegDate.text = "\(str)"
        
    }
    @IBAction func deleteBtnClicked(_ sender: Any) {
        self.delegate?.deleteBtnClicked(memo: memo)
    }
    
}
