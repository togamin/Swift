## APIサンプル



<h2>APIとは</h2>

APIとは「Application Programming Interface（アプリケーション・プログラミング・インターフェイス）」の略で、ソフトウェアの機能を共有する仕組みのことです。

もう少し、わかりやすく言うと、他のソフトウェアの機能を自分のアプリにも導入できるようにしてくれるシステムのことです。



例えば、





実装したい機能が既にAPIで公開されているなら、同じプログラムを１から作る必要がなくなる。







<h2>サンプルアプリ</h2>

入力したクエリに紐ずいたWebサイトの情報を取得する。

Feedminでも使用している。





<h2>実装方法</h2>

<h3>「Almofire」と「SwiftyJSON」のインストール</h3>

```swift
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'APISampleAlmofire' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for APISampleAlmofire
  pod 'SwiftyJSON' //追加
  pod 'Alamofire' //追加

end
```

CocoaPodsを用いたライブラリの導入手順は以下の記事に詳しく書いてあります。

<a href = "https://qiita.com/ShinokiRyosei/items/3090290cb72434852460">＞【Swift】CocoaPods導入手順</a>

<h4>Almofireとは</h4>

ネットワークの通信をシンプルにするもの。

- サーバーへのリクエスト
- コンテンツのアップロード
- コンテンツのダウンロード

<a href = "https://www.webprofessional.jp/a-crash-course-on-networking-in-ios/">＞iOSアプリ開発でのHTTP通信をラクにする「Alamofire」の使い方</a>

<a href = "https://dev.classmethod.jp/references/swift-oss-alamofire-1/">＞[Swift] HTTP通信OSS Alamofire 導入編</a>

<h4>SwiftyJSONとは</h4>

SwiftyJSONとは、JSON形式で送られてきたデータをSwiftで簡単に扱えるように変換するためのライブラリです。

JSONとは「JavaScript Object Notation」の略で、人間に対するある程度の可読性を残した上で、コンピュータに対してもデータを伝達できる記法の一つです。

<a href = "http://cloud.feedly.com/v3/search/feeds?count=1&query=togamin.com">＞JSONの例</a>

<a href = "https://dev.classmethod.jp/etc/concrete-example-of-json/">＞非エンジニアに贈る「具体例でさらっと学ぶJSON」</a>

<a href = "">＞[Swift] JSONを簡単に扱う為のライブラリ SwiftyJSONのサンプル</a>

```swift
import Alamofire
import SwiftyJSON
```

<h2>APIを用いたサイト情報の取得</h2>

今回はFeedlyのAPIを使用します。

```swift
//サイト情報を取得するAPI
"http://cloud.feedly.com/v3/search/feeds?count=" + String(resultNum) + "&query=" + query
```

`String(resultNum)`は取得する件数、`query`には、検索クエリが入ります。

まず、APIを使用するための準備をします。URLにひらがな、カタカナ等含まれていると、上手くいかないことがあるので、エンコードします。

```swift
var resultNum = 10
var query = "ポケモン"

//ブログ、ニュースサイトの情報を取得するAPI
let urlString:String = "http://cloud.feedly.com/v3/search/feeds?count=" + String(resultNum) + "&query=" + query
        
//エンコードする。ひらがな、カタカナだと上手くいかないことがある。
let encodeURL:String = urlString.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed)!
```

また、Xcodeの`Info.plist`で、「http通信」の許可をします。セキュリティの観点上、デフォルトでhttp通信ができないようになっているので、

`Info.plist`に以下のように追加してください。

![Screen Shot 2019-01-03 at 10.36.45](/Users/togamiyuki/Desktop/Screen%20Shot%202019-01-03%20at%2010.36.45.png)

次に、URLにアクセスし、返ってきた値を受け取る処理を記述します。

```swift
Alamofire.request(encodeURL).responseJSON{ response in
            
	//何も返ってこなかった場合は、処理を抜け。
    //エラーが発生した時に処理を終了する。アプリのクラッシュを防ぐ。
    guard let object = response.result.value else {
    	return
   	}                                      
}
```







<h2>APIに関するインターフェース</h2>

<a href = "http://smsurf.app-rox.com/api/">＞APILIST 100+</a>

<a href = "https://qiita.com/mikan3rd/items/ba4737023f08bb2ca161">＞[2018] 個人でも使える！おすすめAPI一覧</a>



