//
//  ListViewController.swift
//  MemoRe
//
//  Created by 한규철 on 9/24/R4.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var memoList = [MemoData]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.setData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setData()
        self.updateMemo()
    }
    //메모 가져오고, 리로드
    func setData() {
        self.memoList = DBManager.shared.readMemo()
        self.updateMemo()
        
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let writeVC =
        self.storyboard?.instantiateViewController(withIdentifier: "WriteVC") as? WriteViewController
        
        writeVC?.delegate = self
        self.navigationController?.pushViewController(writeVC!, animated: true)
    }
    
    // MARK : 테이블 뷰
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = self.memoList.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //메모리스트에서 데이터 꺼내기
        let memo = self.memoList[indexPath.row]
        let celled = "MemoCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: celled) as! MemoCell
        cell.delegate = self
        
        //memoCell 의 값
        cell.setData(memo: memo)
        
        //날짜 포매터
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 mm월 dd일"
        cell.mymemoRegDate?.text = formatter.string(from: memo.regDate!)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //선택된 행에 맞는 데이터 꺼내오기
        let memo = self.memoList[indexPath.row]
        
        //디테일 뷰컨트롤러 화면의인스턴스를 생성후 디테일 뷰컨트롤러로 이동한다.
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        vc.memo = memo
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
extension ListViewController: WriteViewControllerDelegate {
    func updateMemo() {
        self.tableView.reloadData()
    }
}

extension ListViewController: MemoCellDelegate {
    //삭제 버튼 클릭시 호출
    func deleteBtnClicked(memo: MemoData?) {
        if let memo = memo {
            //DBManager 의 딜리트메모 메소드를 불러온다
            let success = DBManager.shared.deleteMemo(memo: memo)
            if success {
                self.memoList.removeAll(where: { $0.memoId == memo.memoId })
                self.tableView.reloadData()
            }
            else {
                
            }
        }
    }
}

