//
//  ViewController.swift
//  SearchKitMemoryTest
//
//  Created by 许灼溪 on 16/1/6.
//
//

import UIKit
import SearchKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let _ = CachePool.instance.getCache(CacheNames.PINYIN_WORD)
//        let _ = CachePool.instance.getCache(CacheNames.WUBI_WORD)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

