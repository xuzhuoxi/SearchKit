# SearchKit
Swift Search framework for keywords. Keywords support for custom encoding.
这是一个基于关键字的检索框架。支持自定义编码的关键字检索。

## 兼容性
- OS X 10.9+ / iOS 8.0+ / tvOS 9.0
- Xcode 7.1+, Swift 2.1+

## 主要功能
- 输入关键字的一部分，检索出包含这一部分的全部关键字。
- 输入关键字的自定义编码的一部分，检索出包含这一部分编码的全部关键字。
- 混合输入关键字与编码，检索出包含包含关键字部分且包含编码的全部关键字。

##### 注意 
- 不支持带逻辑运算的检索
- 内部已包含了拼音、五笔两个编码的字库，如果要自定义新的编码，要求自行准备字库资源文件(\*.properites)或运行时保充，并提供扩展实现。
关键字可通过资源文件*.properites文件进行配置。例如

## Usage 如何使用

### 1.准备资源

#### 资源文件:
- ID资源文件（如：Dota_ID.properites）内部格式为`key=value`：

	```
	显隐之尘=14
	粉=14
	魔瓶=16
	加速手套=17
	回复戒指=18
	bkb=116
	```
	####注意：
	- 等号"="左边对应的是关键字，右边对应的是关联信息。**多个关键字可关联相同信息**
	- 如果关键字对应的是游戏道具的话，右边的就可以是道具对应的Id。
	- 这是应是==必要==的资源，也可以在**运行过程中补充**。
	
- 编码资源文件（如：Dota_pinyin.properites），内部格式为`key=value[#value]*`：

	```
	显隐之尘=xian yin zhi chen
	粉=fen
	魔瓶=mo ping
	加速手套=jia su shou tao
	回复戒指=hui bi jie zhi#hui fu jie zhi
	bkb=bkb
	```
	####注意
	- 等号"="左边为关键字，右边为编码，多个编码用“#”相隔
	- 编码资源文件直接参与检索，决定检索结果。
	- 编码资源文件包含的关键字应该与ID资源文件**保持一致**
	- 这是应是==必要==的资源，也可以在**运行过程中补充**。
	
- 权重资源文件（如：Dota_weight.properites）内部格式为`key=value`：

	```
	显隐之尘=1.5
	粉=2.0
	魔瓶=1.0
	加速手套=1.6
	回复戒指=1.8
	bkb=1.9
	```
	####注意
	- 等号"="左边为关键字，右边为权重值，权重值要求**大于或等于**1。
	- 如果关键字被命中，权重值越大，自动排后就越靠前。
	- 如果不提供权重资源文件，全部权重值默认为1。
	- 可以在**运行过程中补充**。
	
- 字库资源文件（如：word_pinyin.properites）内部格式为`key=value`：

	```
	魔=mo
	瓶=ping
	回=hui
	复=bi#fu
	戒=jie
	指=zhi
	```
	####注意
	- 等号"="左边的是字，右边的字编码
	- 拼音、五笔的字库已经内部提供。
	- **不可以**在运行过程中补充字编码。
	
### 2.配置
可参考[Exconfig.swift](https://github.com/xuzhuoxi/SearchKit/blob/master/SearchKitTest/ExConfig.swift)

1. 为资源文件配置一个**唯一**的**名字**（字符串）：

	```swift
	extension CacheNames {
    /**
     * Dota
     */
    public static let DOTA_ID = "DOTA:ID"
    public static let DOTA_PINYIN = "DOTA:PINYIN"
    public static let DOTA_WUBI = "DOTA:WUBI"
    public static let DOTA_WEIGHT = "DOTA:WEIGHT"
	}
	```
	
	####注意
	- 无论是否以提供资源文件形式提供数据，**都**应该配置上**名字**。
	- 运行时补充数据也是通过**名字**进行获取缓存实例的。
	- 上面代`public static let DOTA_WUBI = "DOTA:WUBI"`是对应五笔编码资源。
	- 因为拼音、五笔字库已经内嵌，所以不用配置。对应用名字在[CacheNames.swift](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cacheconfig/CacheNames.swift)文件中已经存在。

2. 为资源文件配置路径信息：
	
	```swift
	private class RC {}
	extension ResourcePaths {
	    /**
	     * Dota
	     */
	    public static let URL_DOTA_ID = ResourcePaths.getProperitesURL(RC.self, name: "Dota_ID")!
	    public static let URL_DOTA_PINYIN = ResourcePaths.getProperitesURL(RC.self, name: "Dota_pinyin")!
	    public static let URL_DOTA_WUBI = ResourcePaths.getProperitesURL(RC.self, name: "Dota_wubi")!
	    public static let URL_DOTA_WEIGHT = ResourcePaths.getProperitesURL(RC.self, name: "Dota_weight")!
	    public static let PATH_DOTA_ID = ResourcePaths.URL_DOTA_ID.path!
	    public static let PATH_DOTA_PINYIN = ResourcePaths.URL_DOTA_PINYIN.path!
	    public static let PATH_DOTA_WUBI = ResourcePaths.URL_DOTA_WUBI.path!
	    public static let PATH_DOTA_WEIGHT = ResourcePaths.URL_DOTA_WEIGHT.path!
	}
	```
	#### 注意
	- `RC.self`引用了的是一个私有（文件内可用）类，类名可随便定义，目的只是为了获取当前应用**路径**。
	- `name:`资源文件的命名。实际文件命名应该为xxx.properites，配置中扩展名要求省略。当然可以通过修改代码去除这种默认行为。代码位于：[ResourcePaths.swift](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/resource/ResourcePaths.swift)和[CacheConfig.swift](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cacheconfig/CacheConfig.swift)。

3. 缓存池配置
	
	```swift
	extension CacheConfig {	    
	    func supplyDotaConfig(){
	        CacheConfig.instance.supplyConfig(CacheNames.DOTA_PINYIN, 
	        	reflectClassName: "SearchKit.ChineseCacheImpl", isSingleton: true, 
	        	initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_PINYIN], 
	        	charsetName: "UTF-8", valueCodingClassName: "SearchKit.PinyinWordsStrategyImpl")
	        CacheConfig.instance.supplyConfig(CacheNames.DOTA_WUBI, 
	        	reflectClassName: "SearchKit.ChineseCacheImpl", isSingleton: true, 
	        	initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_WUBI], 
	        	charsetName: "UTF-8", valueCodingClassName: "SearchKit.WubiWordsStrategyImpl")
	        CacheConfig.instance.supplyConfig(CacheNames.DOTA_WEIGHT, 
	        	reflectClassName: "SearchKit.WeightCacheImpl", isSingleton: true, 
	        	initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_WEIGHT], 
	        	charsetName: "UTF-8", valueCodingClassName: nil)
	        CacheConfig.instance.supplyConfig(CacheNames.DOTA_ID, 
	        	reflectClassName: "SearchKit.IDCacheImpl", isSingleton: true, 
	        	initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_ID], 
	        	charsetName: "UTF-8", valueCodingClassName: nil)
	    }
	}
	```
	####注意
	- supplyConfig方法的签名为：`supplyConfig(cacheName: String, reflectClassName: String, isSingleton: Bool, initialCapacity: UInt, resourceURLs: [NSURL]?, charsetName: String?, valueCodingClassName: String?)`
		- cacheName：第一步配置的名字。
		- reflectClassName：缓存实例的**完整类名**，要求是[`ReflectionProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/code/reflect/ReflectionProtocol.swift)协议与[`CacheInitProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/CacheInitProtocol.swift)协议的实现类。
		
		  框架中已包含：
		  - [IDCacheImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/IDCacheProtocol.swift)：**ID缓存**实例类，用于处理**ID资源文件**，完整类名为"SearchKit.IDCacheImpl"。用于代码操作的协议为[`IDCacheProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/IDCacheProtocol.swift)。
		  - [ChineseCacheImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/ChineseCacheImpl.swift)：**编码缓存**实例类，用于处理**编码资源文件**，完整类名为"SearchKit.ChineseCacheImpl"。用于代码操作的协议为[`ChineseCacheProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/ChineseCacheProtocol.swift)。
		  - [WeightCacheImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/WeightCacheImpl.swift)：**权重缓存**实例类，用于处理**权重资源文件**，完整类名为"SearchKit.WeightCacheImpl"。用于代码操作的协议为[`WeightCacheProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/WeightCacheProtocol.swift)。
		  - [CharacterLibraryImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/CharacterLibraryImpl.swift)：**字库缓存**实例类，用于处理**字库资源文件**，完整类名为"SearchKit.CharacterLibraryImpl"。用于代码操作的协议为[`CharacterLibraryProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/CharacterLibraryProtocol.swift)。
		- isSingleton：是否配置为单例。
		- initialCapacity：缓存初始容量，建议配置为**总关键字数**向**上**接近的$2^n$的结果值。
		- resourceURLs：资源文件路径，支持多个文件。详情请看**步骤2**。
		- charsetName：资源文件的字符编码，这参数**暂时无效**。
		- valueCodingClassName：编码处理策略实例的**完整类名**。用于处理资源文件等号"="**右边**部分（值），生成索引及缓存数后返回给**reflectClassName**对应实例。要求是[`ValueCodingStrategyProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/valuecoding/ValueCodingStrategyProtocol.swift)协议的实现类。
		
			框架中已包含：
			- [PinyinWordsStrategyImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/valuecoding/PinyinWordsStrategyImpl.swift)：用于处理**拼音==编码==资源文件**。
			- [PinyinWordStrategyImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/valuecoding/PinyinWordStrategyImpl.swift)：用于处理**拼音==字库==资源文件**。
			- [WubiWordsStrategyImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/valuecoding/WubiWordsStrategyImpl.swift)：用于处理**五笔==编码==资源文件**。
			- [WubiWordStrategyImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/valuecoding/WubiWordStrategyImpl.swift)：用于处理**五笔==字库==资源文件**。
			 
			[IDCacheImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/IDCacheProtocol.swift)、[WeightCacheImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/WeightCacheImpl.swift)不涉及建立索引和值处理（直接存储的），不需要提供。
			
4. 检索类型配置。例如：
	
	```swift
	extension SearchType {
	    /**
	     * Dota 拼音
	     */
	    public static let DOTA_PINYIN = SearchType(associatedName: CacheNames.DOTA_ID)
	    /**
	     * Dota 五笔
	     */
	    public static let DOTA_WUBI = SearchType(associatedName: CacheNames.DOTA_ID)
	}
	```
	####注意
	- associatedName对应的是**权重资源文件**的名字
	- **不同**编码的**编码资源文件**要求配置**不同**的检索类型，并关联**同一个**associatedName。
	
	
5. 检索类型**详细**配置。例如：

	```swift
	extension SearchTypeInfo {    
	    /**
	     * Dota 拼音检索
	     */
	    public static let DOTA_PINYIN_SEARCH: SearchTypeInfo = SearchTypeInfo(SearchType.DOTA_PINYIN, 
	    	CachePool.instance.getCache(CacheNames.DOTA_PINYIN) as! ChineseCacheProtocol, 
	    	ValueCodingStrategyFactory.getValueCodingStrategy(ValueCodingType.PINYIN_WORDS), 
	    	CachePool.instance.getCache(CacheNames.DOTA_WEIGHT) as? WeightCacheProtocol)
	}
	```
	#### 说明：
	- [SearchTypeInfo](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/search/SearchTypeInfo.swift)的构造签名：
		 	`init (_ searchType: SearchType, _ chineseCache: ChineseCacheProtocol, _ valueCodingStrategy: ValueCodingStrategyProtocol, _ weightCache: WeightCacheProtocol?)`
		 	
	- searchType：`SearchType.DOTA_PINYIN`，在**步骤4**中配置的检索类型。
	- chineseCache：`CachePool.instance.getCache(CacheNames.DOTA_PINYIN) as! ChineseCacheProtocol`	  
	  **编码缓存实例**，当前为从缓存池中获取。要求为[`ChineseCacheProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/ChineseCacheProtocol.swift)协议的实例。
	- valueCodingStrategy：输入处理策略实例。
`ValueCodingStrategyFactory.getValueCodingStrategy(ValueCodingType.PINYIN_WORDS)`
	要求是[`ValueCodingStrategyProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/valuecoding/ValueCodingStrategyProtocol.swift)协议的实现类。

	- weightCache：
	`CachePool.instance.getCache(CacheNames.DOTA_WEIGHT) as? WeightCacheProtocol`
	  **权重缓存实例**，当前为从缓存池中获取。要求为[`WeightCacheProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/WeightCacheProtocol.swift)协议的实现类。如果不需要，可直接配置为`nil`。
		
###3. 实际应用

 一般使用过程可参考[ViewController.swift](https://github.com/xuzhuoxi/SearchKit/blob/master/SearchKitTest/ViewController.swift)。
 简单例子如下（手打可能出错）：
 
```swift
var searchConfig: SearchConfig()
var searcher: ChineseSearcherProtocol!
	
var isInited = false
	
func init() {
	if isInited {
		return
	}
	isInited = true
	CacheConfig.instance.supplyDotaConfig() //加载配置，这个是必要的，实例情况只应该执行一次
	searchConfig = SearchConfig()
	searchConfig.addSearchType(SearchTypeInfo.DOTA_PINYIN_SEARCH) //这里只检索Dota拼音
	searcher = ChineseSearcherFactory.getChineseSearcher()
}
	
func doSearch(input: String) {
	if input.isEmpty {
		return
	}
	init()
	if let result = searcher.search(input, searchConfig: searchConfig, max: Int.max) {
		var sb = ""
		var idCache: IDCacheProtocol
		for r in result {
			sb.appendContentsOf("\(r.key)\t\t{匹配值:\(r.totalValue),关联名称:\(r.associatedNames),关联信息:")
			for name in r.associatedNames {
				idCache = CachePool.instance.getCache(name) as! IDCacheProtocol
				if let ids = idCache.getIDs(r.key) {
					sb.appendContentsOf("\(ids)")
				}else{
					sb.appendContentsOf("nil")
				}
			}
			sb.appendContentsOf("}\n")
		}
		print(sb)
	}
}
```
	

####注意：
- 检索实例为[`ChineseSearcherProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/ChineseSearcherProtocol.swift)协议的实例。
- 两个检索方法：

	`search(input: String, searchConfig: SearchConfig) ->SearchResult?`
	`search(input: String, searchConfig: SearchConfig, max: Int) ->[SearchKeyResult]?`
		
###4. 数据补充与行为扩展

- 数据补充（[`CacheInitProtocol`](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/CacheInitProtocol.swift)协议）
	
	- 框架包含的[IDCacheImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/IDCacheImpl.swift)，[ChineseCacheImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/ChineseCacheImpl.swift)，[WeightCacheImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/WeightCacheImpl.swift)都实现了[CacheInitProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/CacheInitProtocol.swift)协议，可以运行时补充数据。
	- [CacheInitProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/CacheInitProtocol.swift)中包含4个用于补充数据的方法：
		- supplyResource(resource: Resource)<br>
		  &nbsp;&nbsp;resource为key-value的列表，详情请看Resouce.swift
		- supplyResource(url: NSURL)<br>
		  &nbsp;&nbsp;url为要补充的资源文件路径。
		- supplyData(data: String)<br>
		  &nbsp;&nbsp;data为一到多条数据，对应资源文件中的一到多行数据。
		- supplyData(key : String, value: String)<br>
		  &nbsp;&nbsp;key为关键字，value为对应数据。
			
- 行为扩展
	- [DimensionMapProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/map/DimensionMapProtocol.swift)<br>
	  索引协议，被[ChineseCacheProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/ChineseCacheProtocol.swift)实例使用。实现协议可用于替换原有实现[UnfixedDimensionMapImpl](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/map/UnfixedDimensionMapImpl.swift)，针对特写环境提高索引效率。
	- [ValueCodingStrategyProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/valuecoding/ValueCodingStrategyProtocol.swift)<br>
	  资源值处理协议，包含对值的简化、索引计算以及对检索输入的求值与过滤功能
	  - `getSimplifyValue(value:String) ->String` //简化值
	  - `getDimensionKeys(simplifyValue:String) ->[String]` //计算索引
	  - `filter(input:String) ->String` //输入过滤
	  - `translate(filteredInput:String) ->[String]` //输入求值（翻译）
	- [CacheProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/CacheProtocol.swift)<br>
	  全部缓存实现都必须实现的协议，
	- [CacheInitProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/CacheInitProtocol.swift)<br>
	  全部可补充缓存实现都必须实现的协议。
	- [CharacterLibraryProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/CharacterLibraryProtocol.swift)<br>
	  **字库**缓存协议，重新实现本协议可提供不同的字库缓存处理。
	- [ChineseCacheProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/ChineseCacheProtocol.swift)<br>
	  **编码**缓存协议，用于缓存编码资源文件或数据的实现类应该实现的协议。
	- [WeightCacheProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/WeightCacheProtocol.swift)<br>
	  **权重**缓存协议，用于缓存权重资源文件或数据的实现类应该实现的协议。
	- [IDCacheProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cache/IDCacheProtocol.swift)<br>
	  **ID(关联)**缓存协议，用于缓存关联资源文件或数据的实现类应该实现的协议。<br>
	  **注意**:关联数据所可能千变万化，这个协议被**重新实现**的机会很大。
	- [ChineseWordsCodingProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/wordscoding/ChineseWordsCodingProtocol.swift)<br>
	  提供从关键字→对应编码的计算过程的一个协议，在整个检索过程并没有使用。当没有编码资源文件或数据时，可以通过关键字求出编码，然后补充到缓存中。当然这种做法**不太建议**。
	- [ChineseSearcherProtocol](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/ChineseSearcherProtocol.swift) <br>
	  直接面向使用者的一个协议，提供从输入信息→关键字列表的一个过程。

## 使用或参考到的开源项目
- ExSwift: https://github.com/pNre/ExSwift<br>
  这个项目已经很久没更新了，更新xcode后可能编译报错。<br>
  可以到以下地址clone下来：<br>
  https://github.com/ayn/ExSwift<br>
  https://github.com/xuzhuoxi/ExSwift<br>
  
## 其它
- Swift中的String处理速度相当慢，只有Java中的StringBuilder或ActionScript中的String性能的1/10左右。😂😅😑😖😱


## License

SearchKit is released under the [MIT License](LICENSE.md). 

```
Copyright (c) 2016 xuzhuoxi

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```








