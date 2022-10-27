//
//  WriteViewController.swift
//  MemoRe
//
//  Created by 한규철 on 10/25/R4.
//

import UIKit

protocol WriteViewControllerDelegate: AnyObject {
    func updateMemo()
}

class WriteViewController : UIViewController, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var writeTitle: UITextField!
    
    var subject: String!
    var memo: MemoData?
    
    weak var delegate: WriteViewControllerDelegate?
    
    override func viewDidLoad() {
        self.setUI()
    }
    
    func setUI() {
        self.detailTextView.delegate = self
        
        if let memo = memo {
            //메모가 있을때
            self.saveBtn.setTitle("수정", for: .normal)
            self.writeTitle.text = memo.title
            self.detailTextView.text = memo.contents
        }
        else {
            //메모가 없을때
            self.saveBtn.setTitle("저장", for: .normal)
        }
    }
    //save 버튼 클릭시 호출되는 메소드
    @IBAction func saveButton(_ sender: UIButton) {
        
        //내용이 없을시 경고창
        guard self.detailTextView.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용을 입력해주세요", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            self.present(alert, animated: true)
            return
        }
        
        if let memo = memo {
            //메모가 있을때
            memo.title = self.writeTitle.text
            memo.contents = self.detailTextView.text
            
            let success = DBManager.shared.updateMemo(memo: memo)
            var message = ""
            var action: UIAlertAction?
            
            if success {
                message = "메모 수정에 성공했습니다"
                action = UIAlertAction(title: "OK", style: .default)
                self.navigationController?.popViewController(animated: true)
            }
            else {
                message = "메모 수정에 실패했습니다"
                action = UIAlertAction(title: "OK", style: .default) {_ in
                    self.navigationController?.popViewController(animated: true)
                }
            }
            
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(action!)
            self.present(alert, animated: true)
        }
        else {
            //메모가 없을때
            let data = MemoData()
            
            data.title = self.writeTitle.text
            data.contents = self.detailTextView.text
            
            DBManager.shared.insertMemo(memo: data)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    //텍스트뷰에 글입력시 호출
    func textViewDidChange(_ textView: UITextView) {
        //글내용을 최대 15자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        let length = ((contents.length > 15) ? 15 : contents.length)
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
    }
}
