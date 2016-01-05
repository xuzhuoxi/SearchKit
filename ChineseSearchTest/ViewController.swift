//
//  ViewController.swift
//  ChineseSearchTest
//
//  Created by 许灼溪 on 16/1/2.
//
//

import UIKit
import ChineseSearch

class ViewController: UIViewController {
    var searchConfig = SearchConfig()
    var switch2SearchTypes = [SearchType.AOLA_PINYIN,SearchType.AOLA_WUBI,SearchType.DOTA_PINYIN,SearchType.MINECRAFT_PINYIN]
    var switchs: [UISwitch] = []
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var switch0: UISwitch!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    
    @IBAction func onSwitch(sender: UISwitch) {
        let index = switchs.indexOf(sender)!
        if sender.on {
            searchConfig.addSearchType(getSearchTypeInfo(switch2SearchTypes[index])!)
        }else{
            searchConfig.removeSearchType(switch2SearchTypes[index])
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    final func initData(){
        CacheConfig.instance.supplyAolaConfig()
        CacheConfig.instance.supplyDotaConfig()
        CacheConfig.instance.supplyMinecraftConfig()
        switchs.append(switch0)
        switchs.append(switch1)
        switchs.append(switch2)
        switchs.append(switch3)
        for (index, sw) in switchs.enumerate() {
            if sw.on {
                searchConfig.addSearchType(getSearchTypeInfo(switch2SearchTypes[index])!)
            }
        }
        
    }
    
    final func getSearchTypeInfo(searchType: SearchType) ->SearchTypeInfo? {
        switch searchType {
        case SearchType.AOLA_PINYIN:
            return SearchTypeInfo.AOLA_PINYIN_SEARCH
        case SearchType.AOLA_WUBI:
            return SearchTypeInfo.AOLA_WUBI_SEARCH
        case SearchType.DOTA_PINYIN:
            return SearchTypeInfo.DOTA_PINYIN_SEARCH
        case SearchType.MINECRAFT_PINYIN:
            return SearchTypeInfo.MINECRAFT_PINYIN_SEARCH
        default:
            return nil
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        switchs.removeAll()
        switch2SearchTypes.removeAll()
        searchConfig.removeAll()
        // Dispose of any resources that can be recreated.
    }
}