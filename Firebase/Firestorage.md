## 【Swift4】Firebase Storageへの画像保存方法

画像、音声、動画データをFireStorageに保存。

URLをFirestoreに保存。

画像はSDWebImage.

その他再生する処理されたら、URLから音楽、動画を再生。

<h2>Firebase Storageとは</h2>





<h2>サンプルアプリの概要</h2>

* 画像の保存
*  動画の保存

<h2>実装方法</h2>

<h3>Firebaseの設定</h3>



```swift
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FirestorageSample02' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FirestorageSample02
  pod 'Firebase/Core'//追加
  pod 'Firebase/Firestore'//追加
  pod 'Firebase/Storage'//追加
  pod 'FirebaseUI/Storage'//追加
end

```

* Permission設定。デフォルトでは認証された人。
* 画像データを読み出す時、容量が大きいと、上手く呼び出せない。

https://firebase.google.com/docs/storage/ios/download-files?hl=ja

<h2>GitHub</h2>

<a href = "https://github.com/togamin/FirestorageSample02.git">＞https://github.com/togamin/FirestorageSample02.git</a>



<h2>参考文献</h2>

<a href = "https://qiita.com/nnsnodnb/items/8464369f9c9160f49634">＞Firebase Storageに画像をアップロードをするサンプルを作ってみた！</a>

<a href = "https://qiita.com/k-boy/items/3d6aa6c26a0c6510320e">＞FirebaseStorageの画像をSDWebImageで表示しようとして詰まった話</a>

<a href = "https://firebase.google.com/docs/storage/ios/download-files?hl=ja">＞iOS でファイルをダウンロードする</a>

