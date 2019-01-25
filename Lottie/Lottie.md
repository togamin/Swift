## 【Swift4】アニメーションを簡単導入「Lottie」







<h2>サンプルアプリ</h2>

以下のように、Startボタンを押すと歯車のアニメーションが動作し、Stopボタンを押すと止まるサンプルについて書いていきます。

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">【iOSアプリ開発】<br><br>アニメーションの導入 <a href="https://t.co/Hc4lyGBHxa">pic.twitter.com/Hc4lyGBHxa</a></p>&mdash; とがみん@ブロガーinセブ (@togaminnnn) <a href="https://twitter.com/togaminnnn/status/1085054011898642433?ref_src=twsrc%5Etfw">2019年1月15日</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<h2>実装方法</h2>

```swift
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Lottie' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Lottie
  pod 'lottie-ios'//追加

end
```



`Lottie`をimportします。

```swift
import Lottie
```



<a href = "https://www.lottiefiles.com/">![Lottie](/Users/togamiyuki/Desktop/Swift/Lottie/images/Lottie.png)</a>



Lottieのサイトから、使用したいアニメーションをダウンロードし、プロジェクトに追加します。

![Lottie01](/Users/togamiyuki/Desktop/Swift/Lottie/images/Lottie01.png)

その後、`ViewController.swift`にアニメーションを表示するViewに関するコードを書いていきます。

```swift
animationView.frame.size.width = 300//アニメーションを表示するViewの幅
animationView.frame.size.height = 300//アニメーションを表示するViewの高さ
animationView.center = self.view.center//Viewのs中心に配置
animationView.setAnimation(named: "gears")
animationView.animationSpeed = 1//アニメーションのスピード
animationView.contentMode = .scaleAspectFit
animationView.loopAnimation = true//アニメーションを繰り返し行う
self.view.addSubview(animationView)//Viewにアニメーションを追加する処理
```

Startボタンを押した時に実行される関数と、Stopボタンが押されたときに実行される関数の中に、以下の処理を書きます。

```swift
//アニメーション開始
@IBAction func startAct(_ sender: UIButton) {
	print("アニメーション開始")
	animationView.play()
}
    
//アニメーション終了
@IBAction func stopAct(_ sender: UIButton) {
   	print("アニメーション終了")
   	animationView.stop()
}
```

これで実行すると、Startボタンを押した時に、アニメーションが動き、Stopボタンを押した時に、アニメーションが止まります。



<h2>GitHub</h2>

サンプルコード

<a href = "https://github.com/togamin/LottieSample.git">＞https://github.com/togamin/LottieSample.git</a>

Lottie

<a href = "https://github.com/airbnb/lottie-ios">＞https://github.com/airbnb/lottie-ios</a>



<h2>まとめ</h2>


