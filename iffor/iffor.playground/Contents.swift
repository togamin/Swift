import UIKit

//エンジニアとして重要なこと。
//わからない事があったら自分で調べて解決する。

//という事で以下の問題を「swift」で書いてください。書き方は自分で調べてください。

//問題1
//if文を使って、以下の変数が「true」なら、先週一番楽しかった事、「false」なら、先週一番辛かった事を表示
var feeling:Bool = false
/*
if文
true => print("楽しかった事")
false => print("辛かった事")
*/
if feeling {
    print("おもしろそうな本を買えた!")
}else{
    print("SMモールに行くつもりが、全く別の場所にたどり着いた")
}




//問題2
//自分の年齢ごとに何に注力しているかを出力するプログラムを書いてください(ざっくりで最低3つ)。
var age:Int = 26
/*
 (例)
 24歳の時 => インターン
 25歳から27歳　=> 仕事
 28歳から50歳 => 子育て
 50歳以上 => 海外うろうろ
 */
if age == 24{
    print("インターン")
}else if 25 <= age,age <= 27{
    print("仕事")
}else if 28 <= age,age <= 50{
    print("子育て")
}else{
    print("海外うろうろ")
}

//&&をカンマ区切りでもかける。





//問題3
//for文を使って、配列の値を以下のように表示してください。
/*---------------
 ペンギン魚
 ライオンお肉
 コアラユーカリ
-----------------*/
var animal = [["ペンギン","魚"],["ライオン","お肉"],["コアラ","ユーカリ"]]
for i in animal{
    print(i[0] + i[1])
}


//問題4
//ifとfor文を使って「0 1 2 3 4 5 4 3 2 1 0」を表示するプログラム。
//コンソールには縦に表示される。
for i in 0...10{
    if i <= 5{
        print(i)
    }else if 5 < i{
        print(10 - i)
    }
}
