# SearchKit
Search framework for keywords. Keywords support for custom encoding.
这是一个基于关键字的检索框加。支持自定义的关键字检索。

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
	死亡面罩=19
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
	死亡面罩=si wang mian zhao#si wu mian zhao
	```
	####注意
	- 等号"="左边为关键字，右边为编码，多个编码用“#”相隔
	- 编码资源文件直接参与检索，决定检索结果。
	- 编码资源文件包含的关键字应该与ID资源文件**保持一致**
	- 这是应是==必要==的资源，也可以在**运行过程中补充**。
	
- 权重资源文件（非必要）（如：Dota_weight.properites）内部格式为`key=value`：

	```
	显隐之尘=1.5
	粉=2.0
	魔瓶=1.0
	加速手套=1.6
	回复戒指=1.8
	死亡面罩=1.9
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
	- 拼音、五笔的字库已经包含，提供。
	- 可以在**运行过程中补充**字编码。
	
### 2.配置
可参考[Exconfig.swift](https://github.com/xuzhuoxi/SearchKit/blob/master/SearchKitTest/ExConfig.swift)

1. 为资源文件配置一个**唯一**的**名字**（字符串）：

	```
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
	
	``` 
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
	- 资源文件的命名应该为xxx.properites，配置中扩展名要求省略。当然可以通过修改代码去除这种默认行为。代码位于：[ResourcePaths.swift](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/resource/ResourcePaths.swift)和[CacheConfig.swift](https://github.com/xuzhuoxi/SearchKit/blob/master/Source/cs/cacheconfig/CacheConfig.swift)

3. 缓存池配置
	
	```
	extension CacheConfig {	    
	    func supplyDotaConfig(){
	        CacheConfig.instance.supplyConfig(CacheNames.DOTA_PINYIN, reflectClassName: "SearchKit.ChineseCacheImpl", isSingleton: true, initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_PINYIN], charsetName: "UTF-8", valueCodingClassName: "SearchKit.PinyinWordsStrategyImpl")
	        CacheConfig.instance.supplyConfig(CacheNames.DOTA_WUBI, reflectClassName: "SearchKit.ChineseCacheImpl", isSingleton: true, initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_WUBI], charsetName: "UTF-8", valueCodingClassName: "SearchKit.WubiWordsStrategyImpl")
	        CacheConfig.instance.supplyConfig(CacheNames.DOTA_WEIGHT, reflectClassName: "SearchKit.WeightCacheImpl", isSingleton: true, initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_WEIGHT], charsetName: "UTF-8", valueCodingClassName: nil)
	        CacheConfig.instance.supplyConfig(CacheNames.DOTA_ID, reflectClassName: "SearchKit.IDCacheImpl", isSingleton: true, initialCapacity: 256, resourceURLs: [ResourcePaths.URL_DOTA_ID], charsetName: "UTF-8", valueCodingClassName: nil)
	    }
	}
	```
	####注意
	- supplyConfig方法的签名为：`supplyConfig(: String: String: Bool: UInt: [NSURL]?: String?: String?)`
		- 第一个为 
4. 奔
5. 奔
	
		

	
	
	
	
	
	
	

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




