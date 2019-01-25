import UIKit


class Animal{
    var name:String!//名前
    var sound:String!//鳴き声
    
    init(name:String,sound:String){
        self.name = name
        self.sound = sound
    }
    
    //鳴く関数
    func makeSound(){
        print(sound + "(" + name + ")")
    }
}

//オブジェクトを作成
var cat = Animal(name:"ネコ",sound:"ニャー")
var dog = Animal(name:"犬",sound:"ワンッ")
var monkey = Animal(name:"サル",sound:"ウキーッ")

cat.makeSound()
dog.makeSound()
monkey.makeSound()
