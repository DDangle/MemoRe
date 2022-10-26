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

class WriteViewController : UIViewController {
    weak var delegate: WriteViewControllerDelegate?
}
