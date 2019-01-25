## 【Swift4】オブジェクト指向プログラミングの継承

(未修正)

以前の記事で、オブジェクト指向プログラミングについて説明したのですが、

<a href = "https://togamin.com/2018/11/16/object/">＞【Swift4】オブジェクト指向プログラミングとは</a>

今回の記事では、オブジェクト指向プログラミングの要素の一つである「継承」とは何か、そのメリットは何かといった事を説明していこうかと思います。

<h2>継承とは</h2>

継承とは、既存の設計図(クラス)の属性(プロパティ)、動作(メソッド)を新しく作成するクラスに引き継ぐ事です。

例えば、「救急車の設計図(クラス)」を書きたいとします。![override01](/Users/togamiyuki/Desktop/Swift/ObjectOriented/images/override01.png)

以前のオブジェクト指向プログラミングの記事で説明したように、設計図を書くと以下のようになります。

<a href = "https://togamin.com/2018/11/16/object/">＞【Swift4】オブジェクト指向プログラミングとは</a>

```swift
//救急車クラス
class Ambulance{
	var engin = "エンジン"
    var tireNum = 4//タイヤの数
    var siren = "サイレン"
    func run(){
    	print("走る")
    }
    func stop(){
        print("止まる")
    }
    func sirenOn(){
        print("サイレンを鳴らす")
    }
    func sirenOff(){
        print("サイレンを止める")
    }
}

//バスクラス
class Bus{
	var engin = "エンジン"
    var tireNum = 4//タイヤの数
    var hakkenki = "発券機"
    func run(){
    	print("走る")
    }
    func stop(){
        print("止まる")
    }
    func makeTicket(){
    	print("チケットを発行")
    }
}

//トラッククラス
class Truck{
    var engin = "エンジン"
    var tireNum = 4//タイヤの数
    var nidai = "荷台"
    func run(){
    	print("走る")
    }
    func stop(){
        print("止まる")
    }
    func openNidai(){
    	print("荷台を開ける")
    }
}
```

共通部分

```swift
//共通部分
var engin = "エンジン"
    var tireNum = 4//タイヤの数
func run(){
  	print("走る")
}
func stop(){
   	print("止まる")
}
```

ただ、既存クラスとして、以下のような「車クラス」がある場合、

![override2](/Users/togamiyuki/Desktop/Swift/ObjectOriented/images/override2.png)

「救急車クラス」は、「車クラス」のプロパティや、メソッドを引き継いで、プログラムを書く事ができます。

実際に書いたコードが以下です。

```swift
//②車クラス
class car{
    var engin = "エンジン"
    var tireNum = 4//タイヤの数
    func run(){
    	print("走る")
    }
    func stop(){
        print("止まる")
    }
}

//③「車クラス」を引き継いで書いた、「救急車クラス」
class ambulance:car{
    var siren = "サイレン"
    func run(){
    	print("走る")
    }
    func stop(){
        print("止まる")
    }
}
```

イメージとしては、最初から救急車を作るのではなく、まず初めに車を作ってから、救急車と車の違いの部分を作り上げるといったイメージになります。

このように、既存クラスのプロパティや、メソッドを新たに作成するクラスに引き継ぐ事を「継承」と言います。

<h2>「継承」のメリット</h2>

継承のメリットについて、主に2つあります。

<ol><li>プログラムを書く量を減らせる</li><li>仕様変更の際、変更箇所を減らせる</li></ol>

それぞれについて説明していきます。

<h3>プログラムを書く量を減らす事ができる</h3>

クラスを継承する事によって、プログラムを書く量を減らす事ができます。

例えば、車100台のオブジェクトを作らないといけない。しかも、バスや救急車、その他いろんな種類の車があるといった状況を思い浮かべてください。

<img src = "" alt = "たくさんの車">

それぞれの車一台一台の設計図を書く事は非常に手間がかかります。

なので、それら全てに共通する部分だけを、あらかじめクラスとして作っておき、

それを「継承」する事によって、同じ内容を何度も書く必要がなくなります。

![override03](/Users/togamiyuki/Desktop/Swift/ObjectOriented/images/override03.png)

トラックや救急車やバスは全て、エンジンやタイヤが4つあり、走ったり、止まることができます。

それらの共通部分を「車クラス」としてまとめ、再利用する事によって、コードを書く量を減らす事ができます。

以下は「車クラス」を継承して書いた、「バスクラス」と「トラッククラス」と「救急車クラス」です。



```swift
//②の「車クラス」を継承して書いた「バスクラス」
class bus:car{
    var chair = 60
    var hakkennki = "発券機"
    func makeTicket(){
    	print("チケットを発行")
    }
}
//②の「車クラス」を継承して書いた「トラッククラス」
class truck:car{
    var nidai = "荷台"
    func openNidai(){
    	print("荷台を開ける")
    }
}
//②の「車クラス」を継承して書いた「救急車クラス」
class ambulance{
    var siren =  "サイレン"
    func sirenOn(){
        print("サイレンを鳴らす")
    }
    func sirenOff(){
        print("サイレンを止める")
    }
}
```



<h3>仕様変更の際、変更箇所を減らすことができる</h3>

2つ目のメリットについて、上記100台の車のオブジェクトを作った後、

仕様変更があって、すべての車に、より性能の良いエンジンを使う事になったとします。

もし、車一台一台に対して、設計図を作成していた場合、車の台数分書き換えないといけません。

しかし、共通部分を抜き出したクラスを継承してクラスを書いていた場合、

その共通部分が書かれたクラスの中身を一箇所変更するだけで、全てに適応させる事ができます。

![override04](/Users/togamiyuki/Desktop/Swift/ObjectOriented/images/override04.png)

上記の例では、車クラスの中の「エンジン」を「高性能エンジン」に変更するだけで、その設計図を継承したクラスに適用させることができます。

このように、共通部分を抜き出したクラスをあらかじめ作り、それを継承する事で、仕様変更があった場合に、

変更箇所を減らす事ができます。

<h2>まとめ</h2>

オブジェクト指向における「継承」について説明しました。

「継承」とは、既存のクラスの属性を新しく作成するクラスに引き継ぐ事。

そしてそのメリットは、

<ol><li>プログラムを書く量を減らせる</li><li>仕様変更の際、変更箇所を減らせる</li></ol>

の2つあります。

