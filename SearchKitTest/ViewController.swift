//
//  ViewController.swift
//  SearchKitTest
//
//  Created by 许灼溪 on 16/1/2.
//
//

import UIKit
import SearchKit

class ViewController: UIViewController, UISearchBarDelegate {
    var searchConfig = SearchConfig()
    var switch2SearchTypes = [SearchType.AOLA_PINYIN,SearchType.AOLA_WUBI,SearchType.DOTA_PINYIN,SearchType.MINECRAFT_PINYIN]
    var switchs: [UISwitch] = []
    var searcher: ChineseSearcherProtocol!
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var switch0: UISwitch!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var switch2: UISwitch!
    @IBOutlet weak var switch3: UISwitch!
    @IBOutlet weak var txtOutput: UITextView!
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        let index = switchs.index(of: sender)!
        if sender.isOn {
            searchConfig.addSearchType(getSearchTypeInfo(switch2SearchTypes[index])!)
        }else{
            searchConfig.removeSearchType(switch2SearchTypes[index])
        }
        doSearch()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        doSearch()
    }
    
    final func doSearch(){
        if let input = searchBar.text {
            if input.isEmpty{
                txtOutput.text = ""
                return
            }
            if let result = searcher.search(input, searchConfig: searchConfig, max: Int.max) {
                var sb = ""
                var idCache: IDCacheProtocol
                for r in result {
                    sb.append("\(r.key)\t\t{匹配值:\(r.totalValue),关联名称:\(r.associatedNames),关联信息:")
                    for name in r.associatedNames {
                        idCache = CachePool.instance.getCache(name) as! IDCacheProtocol
                        if let ids = idCache.getIDs(r.key) {
                            sb.append("\(ids)")
                        }else{
                            sb.append("nil")
                        }
                    }
                    sb.append("}\n")
                }
                txtOutput.text = sb
            }else{
                txtOutput.text = ""
            }
        }else{
            txtOutput.text = ""
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
        for (index, sw) in switchs.enumerated() {
            if sw.isOn {
                searchConfig.addSearchType(getSearchTypeInfo(switch2SearchTypes[index])!)
            }
        }
        searcher = ChineseSearcherFactory.getChineseSearcher()
    }
    
    final func getSearchTypeInfo(_ searchType: SearchType) ->SearchTypeInfo? {
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
