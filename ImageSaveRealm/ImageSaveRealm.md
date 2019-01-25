## 【Swift】画像の保存と読み出し方法。Realmを使用。





<h2>サンプルアプリ</h2>

* 画像の選択
* 画像の保存
* 画像の読み込み
* コレクションViewに保存
* 非同期処理



<h2>実装方法</h2>

<h3>イメージピッカーの準備</h3>

Info.plistにライブラリを使用する旨を記述。

![imagePicker](/Users/togamiyuki/Desktop/Swift/ImageSaveRealm/images/imagePicker.png)

ImagePickerを表示する関数と、ImagePickerから画像が選択された時に呼び出される関数を記述

```swift
//ライブラリから画像を選択するImagePickerに関するもの
extension ViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    //ImagePickerの表示
    func imagePickUp(){
        let picker: UIImagePickerController! = UIImagePickerController()
        //ライブラリから画像を選択
        picker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //デリゲートの設定
        picker.delegate = self
        //ピッカーの表示
        present(picker, animated: true, completion: nil)
    }
    //画像が選択された時に呼ばれる関数
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            myImageView.image = image//選択した画像をmyImageViewに入れる
            
        }
        self.dismiss(animated: true, completion: nil)
    }
}
```

選択ボタンが押された時に、ImagePickerが呼ばれるようにする。

```swift
//画像の選択
@IBAction func selectImg(_ sender: UIButton) {
	imagePickUp()
}
```



<h3>Realmと画像の保存</h3>

ImagePickerで選択した画像を保存します。保存する画像をアプリのDocumentというフォルダに格納する。

ファイル名をRealmに保存します。

<h4>Realmの導入</h4>

Podfileに`pod 'RealmSwift'`を追加し、インストール。

```Swift
# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RealmImageSave' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RealmImageSave
  pod 'RealmSwift'//追加
end
```

<h4>画像をDocumentフォルダに保存</h4>





<h4>画像のファイル名をRealmに保存</h4>





<h3>画像の読み出し</h3>



<h3>コレクションViewへの代入</h3>



<h2>GitHub</h2>

https://github.com/togamin/RealmImageSave.git