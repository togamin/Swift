## 【Swift4】UITableViewControllerの使い方



<h2>作成するサンプルアプリ</h2>

以下が今回作成するサンプルアプリです。

<blockquote class="twitter-tweet" data-lang="ja"><p lang="ja" dir="ltr">【iOSアプリ開発】<br><br>TableViewControllerを用いたサンプルアプリ <a href="https://t.co/1OspS35dQ5">pic.twitter.com/1OspS35dQ5</a></p>&mdash; とがみん@ブロガーinセブエンジニア (@togaminnnn) <a href="https://twitter.com/togaminnnn/status/1067237131901259777?ref_src=twsrc%5Etfw">2018年11月27日</a></blockquote>
<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<h2>実装方法</h2>

<h3>UITableViewControllerの準備</h3>

UITableViewControllerを表示します。

![table01](/Users/togamiyuki/Desktop/Swift/table/images/table01.png)

その後`ViewController`を選択し、削除します。

![table02](/Users/togamiyuki/Desktop/Swift/table/images/table02.png)

削除したら、`Is Initioal View Controller`にチェックを入れます。これで、この`UITableViewController`がアプリ実行時にはじめに呼ばれる画面になります。

`ViewController.swift`ファイルも削除します。

![table03](/Users/togamiyuki/Desktop/Swift/table/images/table03.png)

次に`command`+`N`キーを押して、新しいファイルを選択します。`Cocoa Touch Class`を選択します。

![table04](/Users/togamiyuki/Desktop/Swift/table/images/table04.png)

`TableViewController`と名前をつけ、`Subclass of`を`UITableViewController`にし保存します。

![table05](/Users/togamiyuki/Desktop/Swift/table/images/table05.png)

新しく`TableViewController`クラスが書かれた、ファイルが作成されるので、`TableViewController`を選択し、ユーティリティエリアの`Custom Class`に`TableViewController`を記入して準備完了です。

<h3>TableViewController機能の説明</h3>

テーブルに関する関数についてそれぞれ説明していきます。

<ol><li>テーブルのセクションについて</li><li>各セクションに表示させるセルの数</li><li>セルのインスタンス化</li><li>セルをスワイプした際にボタンを表示する関数</li><li>セル選択後、セルの情報を別のviewに送る処理</li></ol>

<h4>1.テーブルのセクションについて</h4>

以下の関数は、テーブルビューに表示するセクションの数を返します。返り値を`2`としています。テーブル上に2つのセクションが現れます。2つ目の関数は、それぞれのセクションのタイトルを設定しています。

```swift
//テーブルビュー内に表示するセクションの数
override func numberOfSections(in tableView: UITableView) -> Int {
	return 2
}

//Sectioのタイトル
override func tableView(_ tableView: UITableView,
 	titleForHeaderInSection section: Int) -> String? {
   	var sectionTitle = ["togamin.com","とがみんブログ"]
  	return sectionTitle[section]
}
```

<h4>2.各セクションに表示させるセルの数</h4>

以下の関数は、各セクションに表示するセルの数を返します。

セルに入れるデータの配列をあらかじめ作っておき、その配列の個数だけ、セルの数を返します。

```swift
//配列を作成
var animal = ["ペンギン","パンダ","コアラ"]

//セクション内に表示するセルの数
override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
	return animal.count
}
```

<h4>3.セルのインスタンス化</h4>

以下の関数は、セル一つ一つに対してどういう処理とするかを書いていきます。

`withIdentifier`を`cell`にし、`Table View Cell`のユーティリティエリアの`Identifire`に`cell`と記入します。

これで、ストーリーボード 上のセルと、コードの`cell`を紐ずけます。名前はなんでも良いです。

`cell.textLabel?.text = animal[indexPath.row]`の処理は、セルに`animal`配列の中身が表示されます。

```swift
//セルのインスタンス化
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		//cellへの処理を書く。
    	cell.textLabel?.text = animal[indexPath.row]
	return cell
}
```

<h4>4.セルをスワイプした際にボタンを表示する関数</h4>

以下の関数で、テーブルのセルを横にずらしたときに、処理を行うボタンを表示させることができます。

```swift
//テーブルのセルを横にずらし、「ボタン1」と「ボタン2」を表示
override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
	let swipeBtn1 = UITableViewRowAction(style: .default, title: "ボタン1") { action, index in
  		print("ボタン1",index)
       	//処理を記述
  	}
   	swipeBtn1.backgroundColor = .blue
   	let swipeBtn2 = UITableViewRowAction(style: .default, title: "ボタン2") { action, index in
  		print("ボタン2",index)
      	//処理を記述
  	}
 	swipeBtn2.backgroundColor = .red
  	return [swipeBtn1,swipeBtn2]
}
```

<h4>5.セル選択後、セルの情報を別のviewに送る処理</h4>

`UIViewController`を配置し、`NextViewController.swift`ファイルを新しく作成し、ユーティリティエリアの`class`の部分に`NextViewController`と記述します。

セグエを引っ張り、セグエの`Identifire`に`next`を記述。

そして、セルを押した時に`NextViewController`のラベル押したセルの内容が表示されるようにします。

```swift
//セルがタップされた時に動作する処理
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   	let cell = tableView.cellForRow(at: indexPath)
   	performSegue(withIdentifier: "next",sender: nil)
}

//画面遷移時に呼び出される
override func prepare(for segue:UIStoryboardSegue,sender:Any?){
  	print("画面遷移中")
   	if let indexPath = self.tableView.indexPathForSelectedRow{
   		//遷移先のViewControllerを格納
    	let controller = segue.destination as! NextViewController
   		//遷移先の変数に代入
    	controller.animal = animal[indexPath.row]
  	}
}
```

`NextViewController.swift`に書かれているコードは以下です。

```swift
import UIKit
class NextViewController: UIViewController {
	//テーブルセルから送られてきた情報を格納
    var animal:String!
    //ラベル
    @IBOutlet weak var label: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //ラベルにanimal変数に入っているデータを代入。
        label.text = animal
    }
}
```



<h2>GitHub</h2>

サンプルコードはGitHubにあげています。参考にしながら実装してみてください。

<a href = "https://github.com/togamin/UITableViewControllerSample.git">＞https://github.com/togamin/UITableViewControllerSample.git</a>

<h2>まとめ</h2>

`UITableViewController`の使い方と、よく使う機能についてまとめました。

