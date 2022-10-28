//
//  DetailViewController.swift
//  MemoRe
//
//  Created by 한규철 on 10/25/R4.
//

import UIKit

class DetailViewController : UIViewController {
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var contentsLable: UILabel!
    
    var memo: MemoData?
    
    override func viewDidLoad() {
        self.titleLable.text = memo?.title
        self.contentsLable.text = memo?.contents
        
        
    }
    
    
    @IBAction func editBtnClicked(_ sender: UIButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "WriteVC") as! WriteViewController
        vc.memo = memo
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
    @IBAction func backButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}
