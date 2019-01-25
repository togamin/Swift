## 【Swift4】プログラミングにおける「変数」について

## 変数とは

「変数」と聞いて何を思い浮かべるでしょうか。

名前の通り変な数？変化する数？

はたまた、小学生、中学生の算数、数学の授業で習った「x」や「y」といったものを思い浮かべる人が多いかと思います。

じゃあ、プログラミングにおける「変数」とは一体なんなのか。

プログラミングにおいて、「変数」とは、数値や文字列などのデータを保持する仕組みのことです。

データを入れるための「箱」とイメージするとわかりやすいかもしれません。

![variable](/Users/togamiyuki/Desktop/Swift/variable/images/variable.jpg)

上の図のように、変数とは数字や文字列のデータを入れる箱であり、プログラムを書く際は「var x = 123456」のように書きます。

次に、プログラミングにおいて、変数の使い方の説明をします。

<h2>変数の使い方</h2>

変数の使い方について、主に以下の3ステップがあります。

* 変数を宣言する
* 値を代入する
* 値を取り出す

```swift
//変数を宣言する
var 変数名

//変数に値を代入する
var 変数名 = 値

//値を取り出す
print(変数名)　// => 値
```

次に、変数を使うメリットについて説明します。

<h2>変数を使うメリット</h2>

変数を使うことによって得られるメリットについて。

* コスト面
  * 変数を使うことによって、プログラムを変更する際の手間を省ける。
* リスク面
  * プログラムを変更する際、変更箇所が減るので、変更ミスを減らせる。

```swift
//2の段の計算結果を表示する。
2*1 => 2
2*2 => 4
2*3 => 6
2*4 => 8
2*5 => 10
2*6 => 12
2*7 => 14
2*8 => 16
2*9 => 18
```

もし3の段の計算結果を表示させるプログラムに書き換えたい場合、上記の左側の2を全て3に書き換えないといけません。

何回も書き直さないといけない上に、書き換える際、値の打ちミスをしてしまう可能性もあります。

しかし、下記のように変数を使うと、一箇所変更するだけで、どの段の計算結果を表示するプログラムができるようになります

```swift
var x = 2

x*1 => 2
x*2 => 4
x*3 => 6
x*4 => 8
x*5 => 10
x*6 => 12
x*7 => 14
x*8 => 16
x*9 => 18
```

<h2>「var」と「let」の違い</h2>

変数を宣言する際、変数名の前に「var」または「let」をつけます。

この違いについて説明します。

「var」で宣言した変数は、後から変更できるのに対し、「let」で宣言した値は後から変更できません。

```swift
//「var」で宣言した場合
var x = 2
x = 3
print(x) // => 3

//「let」で宣言した場合
let x = 2
x = 3 // => エラー
print(x) 

//「let」で宣言した変数は値を変更すると以下のようなエラーが出る。
"cannot assign to value: 'x' is a 'let' constant"
```

「let」で定義した変数の中の値を変更するとエラーがでます。

なぜ「let」が存在するのかというと、プログラムの不具合を見つけやすくするためです。

プログラムを書く際、絶対に変更されない変数を定義するとき、「let」で宣言することによって、もし万が一、変更されて欲しくない変数が変更されてしまった場合に、エラーを吐き出してくれるので、プログラムの不具合を見つけやすくなります。

## 変数の名前の付け方と気をつけること

### 変数の名前の付け方について

変数に名前をつける時は、「誰が見ても理解できるコードを書く」ために、変数名を見た時に、その変数に何が入っているのかがわかりやすい名前にすべきです。

* ローワーキャメルケース
  * 先頭を小文字で書き始め、複合語の先頭を大文字にする。
* アッパーキャメルケース
  * 先頭を大文字で書き始め、複合語の先頭も大文字にする。
* スネークケース
  * 全て小文字で複合語のスペースをアンダースコアで区切る。

```swift
//ローワーキャメルケース
var exampleCase = "example"
//アッパーキャメルケース
var ExampleCase = "example"
//スネークケース
var example_case = "example"
```

### 変数の名前をつける際に気をつけること

* ルールを統一する。名前をつけるルールが違うと見辛い。

* ```swift
  //良い例
  var exapleCase01 = "example01"
  var exapleCase02 = "example02"
  var exapleCase03 = "example03"
  
  //悪い例
  var exapleCase01 = "example01"
  var ExapleCase02 = "example02"
  var exaple_case03 = "example03"
  ```

* 変数名を見ただけで、内容がわかるようにする。

* ```swift
  //例）ペンギン、くま、豚、馬、ライオン等が入る変数はどのような名前にすれば良いか。
  
  //良い例
  var animal = "ペンギン"
  
  //悪い例
  var x = "ペンギン"
  ```


























