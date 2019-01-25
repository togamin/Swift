//: Playground - noun: a place where people can play

import UIKit

var seisu01:Int8 = 127
print(seisu01)

//Int8型では128は扱えないのでエラーがでる。
//var seisu02:Int8 = 128

var seisu03:Int16 = 128
print(seisu03)


//以下が文字の「5」と数字の「5」
var mozi:String = "5"
var suzi:Int8 = 5

//mozi + suzi

//文字を数字に直して計算
Int8(mozi)! + suzi
print(Int8(mozi)! + suzi)


//数字を文字に直して計算
mozi + String(suzi)
