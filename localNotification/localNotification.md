## 【Swift4】ローカルNotificationの実装方法

![localNotification00](/Users/togamiyuki/Desktop/Swift/localNotification/images/localNotification00.jpg)

## サンプルアプリ

ローカル通知は、外部サーバーを介さずに、ユーザーに何らかの情報を伝えるための仕組みです。

午前9時に以下のような通知がくるサンプルアプリを作成します。

![LocalNotification](/Users/togamiyuki/Desktop/Swift/localNotification/images/LocalNotification.jpg)



`AppDelegate.swift`に`UserNotifications`ライブラリをインポートする。

```swift
import UserNotifications
```



AppDelegateクラスのメンバ変数に以下を追加する。

```swift
let center = UNUserNotificationCenter.current()
```



`didFinishLaunchingWithOptions`に通知を許可するかどうかの確認を行うダイアログを表示する処理を`didFinishLaunchingWithOptions`中に記述します。

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
	// このアプリで通知（Local Notification）を使用する許可をユーザーに求める。
    application.registerUserNotificationSettings(UIUserNotificationSettings(types: [UIUserNotificationType.sound,UIUserNotificationType.alert,UIUserNotificationType.badge], categories: nil))
    //UINotificationセンターのDelegateを設定
    center.delegate = self    
    return true
}
```



アプリがバックグラウンドに移行する際に呼ばれる`applicationDidEnterBackground`関数の中に以下を記述します。

```swift
func applicationDidEnterBackground(_ application: UIApplication) {
        
        //バックグラウンドに移行した時に既に設定されている通知を全て消し、新たに通知を設定する。
        center.removeAllPendingNotificationRequests()
        
        //通知を送る日時の指定(9時に通知がくるように設定しています)
        var dateComponents = DateComponents()
        dateComponents.hour = 9
        print("memo:通知する日",dateComponents)
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
    
        //通知の内容について
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "Subtitle"
        content.body = "Body"
    
    
    	//画像
        if let path = Bundle.main.path(forResource: "Feedmin", ofType: "jpeg") {
            content.attachments = [try! UNNotificationAttachment(identifier: "ID1", url: URL(fileURLWithPath: path), options: nil)]
        }
    
    
        
        let calendarRequest = UNNotificationRequest(identifier: "alert",content: content,trigger: calendarTrigger)
        
        //通知を設定する。
        UNUserNotificationCenter.current().add(calendarRequest, withCompletionHandler: nil)
        
    }
```



以下が通知が開かれた時に、呼ばれる関数です。この関数を追加し、通知が開かれた時に実行したい処理を記述します。

```swift
//通知に関する関数
extension AppDelegate:UNUserNotificationCenterDelegate{
    //通知がタップされ開封される時に呼ばれる。
    func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse,withCompletionHandler completionHandler: () -> Void) {
        debugPrint("opened")
        //通知が開封された時に実行させたい、処理を記述。
        print("通知経由でアプリが起動しました。")
        
        
        
        completionHandler()
    }
}
```

<h2>通知がくるかどうかの確認</h2>

デバイスの`設定`ー>`一般`ー>`日付と時刻`の順に進んでいき、自動設定を`OFF`にします。

すると時刻を設定できると思うので、時刻を設定します

今回は9時に通知が来るようにプログラムを記述しているので、以下の画面で、時刻を1分前の8:59分に設定します。

![LocalNotification01](/Users/togamiyuki/Desktop/Swift/localNotification/images/LocalNotification01.jpg)



時間になると無事、通知が来るかと思います。

![LocalNotification](/Users/togamiyuki/Desktop/Swift/localNotification/images/LocalNotification.jpg)

<h2>GitHub</h2>

<a href = "https://github.com/togamin/localPushNotification2.git">＞https://github.com/togamin/localPushNotification2.git</a>





<h2>まとめ</h2>







<h2>参考文献</h2>

<a href = "https://qiita.com/mshrwtnb/items/3135e931eedc97479bb5">＞＜Swift＞iOS 10 User Notifications Framework実装まとめ</a>

<a href = "http://www.cl9.info/entry/2017/04/19/210000">＞【iOS10】ローカル通知に画像を添付する | User Notifications framework</a>

<a href = "https://qiita.com/isom0242/items/e83ab77a3f56f66edd2f">＞Swift3での日時に関する処理</a>