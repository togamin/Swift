## 【Swift4】Firebaseを用いたプッシュ通知送信機能の実装(未完)

[https://github.com/togamin/PushNotificationSample.git](https://github.com/togamin/PushNotificationSample.git)

実装はできた



```swift
//ViewDidLoadに追加したプッシュ通知の認証はいらない。
```



- 
- push通知
  - 秘書みたいなもん
- 証明書なぜ？
- 匿名ログインの必要なぜ
  - 各ユーザーごとにFCMトークンを登録する。
- Firestoreに各ユーザーごとのFCMトークンを登録できるようにする。

## Push通知とは

- システム側が外部サーバーと連携して、能動的に情報を通知してユーザーに通知する方式。ユーザーが働きかけなくても更新されたことを知ることができる。



## 実装する機能の説明

- Firebaseコンソールから、任意のデバイスにメッセージをpush通知する。
  - サーバーと端末の通信を暗号化するための証明書を発行。
- Firestoreデータベースへの更新を検知し、検知したら、その更新内容を通知する。
- 実機使って確認
  - Firebaseコンソールからメッセージを送信
  - アプリからコメントを送信。そのコメントがFirestoreに更新されたら、push通知が届く。

## 実装手順

- 新規プロジェクト作成(PushNotificationSample)

- Firebaseへの登録

  - ファイル名が`GoogleService-Info.plist`になっているかを確認。横に数字がついていると、アプリ実行時にエラーが生じる。

  - ```swift
    //以下をインストール
    pod 'Firebase/Core'
    pod 'Firebase/Messaging'//プッシュ通知する時に必要。
    
    //AppDelegate.swiftに以下を追加
    //Could not build Objective-C module 'Firebase'のエラーは実行時に治ることがあるので、とりあえずスルー。
    import Firebase
    FirebaseApp.configure()
    ```

- プッシュ通知の設定：[参考文献](https://diary.shuichi.tech/entry/2018/07/09/221502)

  - XcodeのCapabilitiesで `Push Notifications` と `Background Modes` をONにする。`Back ground fetch`と`Remort notification`にチェック。

  - [Apple Developer](https://developer.apple.com/account/ios/identifier/bundle)で`App IDs`を開くと、`XC togaminnnn PushNotificationSample`という名前で追加されているので詳細を開く。

  - `Edit`を押し証明書を作っていく。`Push Notifications`の状態が、`Configuable`

    になっているので`Edit`を押す。これから、Development(開発環境)とProduction(本番用)両方の証明書を作成していく。

  - この画面のまま`Keychain Access`を開く。

  - `キーチェーンアクセス` ＞ `証明書アシスタント` ＞ `認証局に証明書を要求` をクリックする。

  - `ユーザーのメールアドレス` を入力し、 `通称` はそのまま、 `CAのメールアドレス` は空欄のままで良い。 `要求の処理` は `ディスクに保存` を選択し `鍵ペア情報を設定` にチェックを入れ、 `続ける` をクリック。

  - [Apple Developer](https://developer.apple.com/account/ios/identifier/bundle)に戻って、`Create Certificate` をクリックして、作成したばかりのCSRファイルをアップロードする。

  - Dev CenterでApp IDsの当該プロジェクトを確認してPush Notificationsが緑になっていればOK.

  - Developerの`Keys`からの右上の`＋`をクリック。`Name`に記入し、`APNs`にチェックを入れる。`APNs`は`Apple Push Notification`の略。

  - ファイルをダウンロードして`Done`。`Key`の値を記憶。

  - [Firebaseコンソール](https://console.firebase.google.com/u/1/project/pushnotificationsample-3f0e6/overview)を開いて、証明書をセットする。`ProjectOverView`＞`プロジェクトの設定`＞`クラウドメッセージング`のタブに移動。

  - [Apple Developer](https://developer.apple.com/account/ios/identifier/bundle)のKeyと[Membership](https://developer.apple.com/account/#/membership)のページのTeamIDを入力`.p8`のファイルを登録。

  - Firebaseのサイトからプッシュ通知を送ることができる。端末との通信を暗号化して送信することができる。

  - 9P2VD5R922

### Firebase Cloud Messaging からのメッセージ送信

- プッシュ通知の実装

- ```swift
  //モジュール追加
  import Firebase
  import FirebaseMessaging
  import UserNotifications
  
  //AppDelegateに追加
  MessagingDelegate
  UNUserNotificationCenterDelegate
  ```

- AppDelgate.swiftの`didFinishLaunchingWithOptions`に以下を記入。

- ```swift
  // リモート通知 (iOS10に対応)
  let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
  UNUserNotificationCenter.current().requestAuthorization(
     	options: authOptions,
     	completionHandler: {_, _ in })
    
  // UNUserNotificationCenterDelegateの設定
  UNUserNotificationCenter.current().delegate = self
  // FCMのMessagingDelegateの設定
  Messaging.messaging().delegate = self
  
  // リモートプッシュの設定
  application.registerForRemoteNotifications()
  // Firebase初期設定
  FirebaseApp.configure()
          
  // アプリ起動時にFCMのトークンを取得し、表示する。FCMトークンとは、開発者が特定のデバイスに通知を送信するための文字列。あとで、Firestoreに登録するので、とりあえずUserDefaultに登録しておく。
  let token = Messaging.messaging().fcmToken
  UserDefaults.standard.set(token, forKey: "FCM_TOKEN")
  print("memo:FCM token: \(token ?? "")")
  ```

- プッシュ通知を受け取った時に、動作する処理を書く

- ```swift
  //プッシュ通知を受け取った時に動作する。
  func userNotificationCenter(_ center: UNUserNotificationCenter,willPresent notification: UNNotification,withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      
  	print("memo:プッシュ通知を受け取りました。")
      print("memo:メッセージの内容",notification.request.content.body)
      
      //「メッセージ文」に記入した文字とともにアラートを表示。
      completionHandler([.alert])
      
  }
  ```

- プッシュ通知を許可するかどうかのダイアログを表示する。

- ```swift
  // プッシュ通知の許諾ダイアログを出す。
  let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
  UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in
  	print("push permission finished")
  }
  ```

- これでFirebaseの`Cloud Messaging`で設定したテキストを、端末に送ることができる。

- 実機で起動しFirebaseからメッセージを送信してみる。

### Firestoreの更新を検知して、push通知を送る方法

- 次に、`Firestore`データベースが更新された時に通知を飛ばす処理を行う。`PodFile`に以下を追加しインストール。

- ```swift
  pod 'Firebase/Firestore'//データベースを使うのに使用。
  pod 'Firebase/Auth'//匿名ログイン
  ```

- FirestoreのDatabase設定

  - 読み書き変更

    ```swift
    //条件を変更
    allow read, write: if false
    allow read, write: if request.auth.uid != null;//idが一致する人のみ読み書き可能。
    ```

- ログイン実装。(匿名ログイン)

  - 匿名：認証情報(メールアドレス等)を入力することなく、ユーザー固有の設定をすることができる。どのユーザーに通知を送るかを選択できるようにするために、ユーザーを識別する必要がある。

  - ユーザーの登録

  - ```swift
    //モジュール追加
    import FirebaseAuth
    
    //変数定義
    var uid:String!
    
    //匿名ログインとユーザーIDの取得する関数を書く。
    func signInAno(){
    	//匿名ログイン
       	Auth.auth().signInAnonymously { (user, error) in
        	if let error = error {
              	print("memo:匿名ログイン失敗",error)
             	return
           	}
           	if let user = user{
              	print("memo:ログイン成功")
              	self.uid = user.user.uid
            	UserDefaults.standard.set(self.uid, forKey: "UserID")
            	print("memo:uid",self.uid)
            }
       	}
    }
    ```

- Cloud Functionsを使ってFirestoreの更新を監視する。[参考文献](https://diary.shuichi.tech/entry/2018/07/11/000858)

  - **Cloud Functions**を使用することで、複数のクラウド サービスを接続して拡張するためのコードを作成できる。Firestoreへの書き込みがされたpush通知を送る等。

    - `Node.js`のインストール。推奨版と最新版があるが、推奨版をしようする。最新版の方がバグが発生しやすい。しばらく運用されている推奨版を利用する。

      [＞Node.jsのインストール](https://nodejs.org/en/)

      ターミナルに`npm - v`と打ってインストールされているか確認。

    - `Cloud Functions`のページを開き、`$ npm install -g firebase-tools`をコピー。ターミナルを開いて実行。

    - permissionに関するエラーがでる。インストールするディレクトリを変更することによって、エラーを避けられる。以下のようにしたらうまく行った。

      [【備忘録】npm -g install に失敗する](https://qiita.com/NaokiIshimura/items/cc07441939b226e779c6)

    - `npm(Node Package Manager)`とは、`Node.js`のパッケージを管理するもの。`Node.js`

    - `firebase login`を実行

      [firebase-toolsのコマンドの使い方](https://qiita.com/gambare/items/fbb5e85e792fa9f488e4)

    - `Y`を実行。FirebaseCLIに許可を与える。ログイン成功の確認。

    - `firebase init`を実行

    - `Functions`をスペースで選択し、次へ進む。

    - `JavaScript`か`TypeScript`のどちらの言語で、`Cloud Function`に書き込むかを選択。とりあえず`JavaScript`でやる。

    - `? Do you want to use ESLint to catch probable bugs and enforce style?`は`No`

    - `Do you want to install dependencies with npm now?`は`Yes`

    - `functions`ディレクtりの中にある `index.js` を編集。ここに行いたい処理を実装する。

    - 実装したら`firebase deploy`をターミナル側で実行してデプロイする。`Firebase`のWebサイトでデプロイされているかを確認。

  - Index.jsにpush通知に使う用の関数を記述。

  - ```javascript
    //push通知に使う用の関数。
    const pushMessage = (fcmToken, memo) => ({
        notification: {
          title: 'プッシュ通知',
          body: `「${memo}」の保存が完了しました`,
        },
        data: {
          blog: 'togamin.com', // 任意のデータを送れる.
        },
        token: fcmToken,
    })
    ```

  - プッシュ通知に関するもの

  - ```javascript
    exports.getValue = functions.firestore
            .document('User/{userID}')//Userの中の全てのパスと一致する。
            .onUpdate((snapshot,context)=>{
    
            console.log("データ更新検知")
            console.log("snapshot",snapshot)
    
            //ユーザーIDの取得
            const userID = context.params.userID
            console.log("userID",userID)
    
            //データベースにアクセスするパスを取得
            const userRef = firestore.doc(`User/${userID}`)
            console.log("userRef",userRef)
    
    
            userRef.get().then((user)=>{
                //以下ユーザーデータには「FCM_TOKEN」と「memo」の情報が入っている。
                const userData = user.data()
                console.log("userData",userData)
                //プッシュ通知送信
                admin.messaging().send(pushMessage(userData.FCM_TOKEN,userData.memo))
                .then((response) => {
                    console.log('Successfully sent message:', response)
                })
                .catch((e) => {
                    console.log('Error sending message:', e)
                })
            }).catch((e) => console.log(e))
        })
    ```

  - `firebase deploy`

  - Firestore更新されるたびにデータを通知。





### 疑問

- 証明書発行は何のためのもの？
- `Node.js`とは何のためのもの?
  - サーバーサイドのJavaScript
  - 規模が大きく、高速なネットワークを構築することを目的として作られた。
  - 今回はFirebaseデータベースに変更があった時に、動作するコードを書いている。
  - 参考文献
    - [Node.js を5分で大雑把に理解する](https://qiita.com/hshimo/items/1ecb7ed1b567aacbe559)
    - [Node js 入門](https://www.slideshare.net/SatoshiTakami/intoroduction-nodejs)
- `firebase-tools`とは？
  - Firebaseのプロジェクトの管理、表示、デプロイ等を行うためのツール。
  - コマンド
    - `firebase login`googleアカウントでログインする画面が現れる。
    - `firebase list`作成済みのプロジェクト一覧が表示される。
    - `firebase use`現在のプロジェクトを確認する。
    - `firebase init`プロジェクトの初期化。
    - `firebase use --add`プロジェクト変更。[デプロイ先を切り替える。](https://qiita.com/star__hoshi/items/30cb78fe25b8b0fb279e)
    - `firebase help`コマンド一覧等でる。
    - `firebase logout`ログアウトする。

- 参考文献
  - [Firebaseでサーバレスアプリをサクッと作ってみる① ~Cloud MessagingでPush通知実装~](https://diary.shuichi.tech/entry/2018/07/09/221502)
  - [[Firebaseでサーバレスアプリをサクッと作ってみる② ~Firestore実装とプッシュ通知連携~]](https://diary.shuichi.tech/entry/2018/07/11/000858)
  - [Firebase NotificationをiOSで使ってみよう！](http://grandbig.github.io/blog/2017/09/18/firebase-notification/)
  - [Push通知が届かない場合のトラブルシューティング](https://faq.growthbeat.com/article/60-push)
  - [Pringで始める簡単Firebase App開発 for iOS（初心者向け）](https://qiita.com/1amageek/items/ca7574698c50cc076347)
  - [Cloud Functions for Firebaseとは？](https://qiita.com/koki_cheese/items/013d4e6ab5aefc792388)
  - [便利なパッケージ管理ツール！npmとは【初心者向け】](https://techacademy.jp/magazine/16105)
  - [Cloud Functions による Cloud Firestore の拡張](https://firebase.google.com/docs/firestore/extend-with-functions?hl=ja)
  - [iOSでのプッシュ通知の準備(バイナリインターフェイス・証明書認証での接続の場合)](https://www.fenrir-inc.com/jp/boltzengine/support/category/detail/?cat=implement_push_to_app&page=ios_registration_push_credential)
  - [【APNsの概要】](https://developer.apple.com/jp/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/APNSOverview.html)

















