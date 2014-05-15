# 目次

* [まずはじめに](#まずはじめに)
    * [Media Id の取得](#Media Id の取得)
    * [コード内初期化](#コード内初期化)
* [ウォール広告](#ウォール広告)
    * [ウォール広告の表示](#ウォール広告の表示)
    * [ウォール広告の表示時のイベント取得](#ウォール広告の表示時のイベント取得)
    * [ウォール広告誘導ボタンの表示計測](#ウォール広告誘導ボタンの表示計測 )
    * [ウォール広告誘導画像の取得](#ウォール広告誘導画像の取得)
* [アイコン広告](#アイコン広告)
    * [アイコン広告の表示](#アイコン広告の表示)
    * [アイコン広告の表示時のイベント取得](#アイコン広告の表示時のイベント取得)
    * [アイコン広告のリフレッシュ時間の調整](#アイコン広告のリフレッシュ時間の調整)
    * [アイコン広告のリフレッシュ停止](#アイコン広告のリフレッシュ停止)
    * [アイコン広告のリフレッシュ管理](#アイコン広告のリフレッシュ管理)
    * [アイコン広告表示パラメータの設定](#アイコン広告表示パラメータの設定)
* [インタースティシャル広告](#インタースティシャル広告)
    * [インタースティシャル広告の表示](#インタースティシャル広告の表示)
    * [インタースティシャル広告表示時のイベント取得](#インタースティシャル広告表示時のイベント取得)
* [よくある質問](#よくある質問)
    * [iOS 6.0未満の端末においてクラッシュする問題への対応](#ios6.0未満の端末においてクラッシュする問題への対応)
    * [他社SDKとの競合の解決](#他社sdkとの競合の解決)

# まずはじめに

## Media Id の取得

管理画面より登録し、Media Id を発行します。

**(現段階では担当者にお問い合わせください)**

この Media Id はアプリの識別に用いるものですので、忘れない様にして下さい。

### テスト用 ID

テスト用の Media Id 1 をご利用いただくことができます。ダミーデータが表示され、動作確認が可能です。

## コード内初期化

上記で取得した media_id を引数に、 AppDavis を初期化します。

特別な理由が無い限り、

[UIApplicationDelegate -application:didFinishLaunchingWithOptions:](https://developer.apple.com/library/ios/documentation/uikit/reference/UIApplicationDelegate_Protocol/Reference/Reference.html#//apple_ref/occ/intfm/UIApplicationDelegate/application:didFinishLaunchingWithOptions:)

に記述して下さい。

```
[AppDavis initMedia:@"your_media_id"];
```

この**初期化を行わない限り、後述するアイコン広告やウォール広告の取得全般を行う事ができません**ので注意して下さい。

# ウォール広告

## ウォール広告の表示

ウォール広告の表示に必要なファイルは以下です。

```
ADVSWallAdLoader.h
```

ADVSWallAdLoader を用いて以下の様に実装し、ウォール広告を表示します。

```objc

//(1) ヘッダーをインポート
#import <AppDavis/ADVSWallAdLoader.h>

@interface YourViewController ()
//(2) プロパティを定義
@property (nonatomic) ADVSWallAdLoader *wallAdLoader;
@end


- (void)viewDidLoad
{
    [super viewDidLoad];

    //(3) ADVSWallAdLoader をインスタンス化
    self.wallAdLoader = [ADVSWallAdLoader new];

    //(4) ウォール広告ロードを呼び出し
    [self.wallAdLoader loadAd];
}

```

上記のように実装する事で、ウォール広告を表示する事が出来ます。

## ウォール広告の表示時のイベント取得

ウォール広告を表示する際に、そのイベントを受け取りたい場合があります。

その場合は ADVSWallAdLoader のプロパティである delegate が、

ADVSWallAdLoaderDelegate に準拠しているので、それ経由で受信する事が出来ます。

```objc

- (void)viewDidLoad
{
    //(1) delegate を設定
    self.wallAdLoader.delegate = self;
}

//(2)ウォール広告が出る直前のイベントを通知
- (void)wallAdLoaderWillPresentWallAdView:(ADVSWallAdLoader *)wallAdLoader
{
}

//(3)ウォール広告が出た直後のイベントを通知
- (void)wallAdLoaderDidPresentWallAdView:(ADVSWallAdLoader *)wallAdLoader
{
}

//(4)ウォール広告が消える直前のイベントを通知
- (void)wallAdLoaderWillDismissWallAdView:(ADVSWallAdLoader *)wallAdLoader
{
}

//(5)ウォール広告が消えた直後のイベントを通知
- (void)wallAdLoaderDidDismissWallAdView:(ADVSWallAdLoader *)wallAdLoader
{
}

```

## ウォール広告誘導ボタンの表示計測

ウォール広告誘導ボタンの表示回数 (AppImp) を計測し、ウォール誘導ボタンの CTR の測定が可能です。
誘導ボタン表示時に以下のメソッドを呼び出していただくことで、表示回数を計測します。
計測が不要の場合は実装する必要はありません。

```objc
[self.wallAdLoader notifyAppImp];
```

また以下の delegate メソッドを実装することで、計測リクエストの成功・失敗時に通知を受け取ることが可能です。

```objc
- (void)viewDidLoad
{
    //(1) delegate を設定
    self.wallAdLoader.delegate = self;
}

//(2)計測リクエストの正常終了を通知
- (void)wallAdLoaderDidFinishNotifyingApp:(ADVSWallAdLoader *)wallAdLoader
{
}

//(3)計測リクエストの失敗を通知
- (void)wallAdLoader:(ADVSWallAdLoader *)wallAdLoader didFailToNotifyAppImpWithError:(NSError *)error
{
}
```

## ウォール広告誘導画像の取得

**現在は本機能のご利用前に、担当者にご相談ください。**

ウォール広告誘導ボタンをサーバから取得し、広告を表示させることが可能です。
本機能のご利用前に、管理画面での設定作業が必要です。

1. **[管理画面操作]** 誘導画像のセットを作成します。画像セットの ID (`WallLeadId`) が発行されます。
2. **[管理画面操作]** 作成した画像セット内に誘導ボタン画像を入稿します。また画像配信の最適化設定を行います。
3. **[SDK 呼び出し]** `requestWallLead` メソッドを発行された `WallLeadId` をつけて呼び出し、誘導ボタン画像を取得します。
4. **[Developer 様実装]** 誘導ボタン画像取得が完了した際に通知される、`wallAdLoaderDidGetWallLead` を実装します。
  - 画像の URL と縦横サイズが通知されるので、ボタンに設定するよう実装します
  - このメソッドは必ず実装していただく必要があります
5. **[SDK 呼び出し]** ボタンが表示された際に `notifyAppImp` メソッドを呼び出し、ウォール広告誘導ボタンの表示回数を計測します
  - 画像毎のボタン表示回数の計測のために必要です
  - 実装は任意ですが、実装しない場合はボタン画像の表示回数の計測ができません。(クリック数は計測されますが、CTR が算出できません)
6. **[SDK 呼び出し]** 通常通り、誘導ボタンがタップされた際に `loadAd` メソッドを呼び出し、ウォール広告を表示します。

`requestWallLead` には発行された `WallLeadId` を渡して呼び出します。

```objc
[self.wallAdLoader requestWallLead:@"YOUR_WALL_LEAD_ID"];
```

以下の delegate を実装することで各種通知を受け取ることができます。なお `wallAdLoaderDidGetWallLead` の実装は必須です。

- `wallAdLoaderDidGetWallLead`

```objc
- (void)wallAdLoaderDidGetWallLead:(ADVSWallAdLoader *)wallAdLoader imageURL:(NSURL *)imageURL width:(NSInteger *)width height:(NSInteger *)height
```

  - 画像 URL、画像幅 (pixel)、画像高さ (pixel) が引数として渡されます
  - このメソッドで受け取った画像をボタンに設定するよう実装します
- `didFailToRequestWallLeadWithError`

```objc
- (void)wallAdLoader:(ADVSWallAdLoader *)wallAdLoader didFailToRequestWallLeadWithError:(NSError *)error
```

  - リクエストが失敗した場合に通知されます

### 実装例

`requestWallLead` を呼び出しを追加します。

```objc
// yourViewController.m

- (void)viewDidLoad {
    [super viewDidLoad];

    self.wallAdLoader = [ADVSWallAdLoader new];
    self.wallAdLoader.delegate = self;

    [self.wallAdLoader requestWallLead:@"YOUR_WALL_LEAD_ID"];
}
```


delegate を実装します。`wallAdLoaderDidGetWallLead` 内で受け取った画像をボタンに設定します。
ボタンが画面上に表示される場合は `notifyAppImp` を呼び出します。

```objc
// yourViewController.m

- (void)wallAdLoaderDidGetWallLead:(ADVSWallAdLoader *)wallAdLoader imageURL:(NSURL *)imageURL width:(NSInteger *)width height:(NSInteger *)height
{
    // 受け取った画像をボタンに貼り付ける
    // (略)

    // 計測リクエストの送信
    [self.wallAdLoader notifyAppImp];
}

- (void)wallAdLoader:(ADVSWallAdLoader *)wallAdLoader didFailToRequestWallLeadWithError:(NSError *)error
{
    // エラー処理
}
```

通常通り、ボタンがタップされた際の広告呼び出しを行います。

```objc
// yourViewController.m

- (IBAction)wallButtonTapped:(id)sender
{
    [self.wallAdLoader loadAd];
}
```

取得済みの画像を使いボタンを表示する場合は、`notifyAppImp` の呼び出しを行うことで、その表示回数も計測可能です。

```objc
// yourViewController.m

// 画像を貼り付けた誘導ボタンが表示されるたびに呼び出す
[self.wallAdLoader notifyAppImp];
```

# アイコン広告


## アイコン広告の表示

アイコン広告を表示するために必要なファイルは以下の2つです。

```
ADVSIconAdLoader.h
ADVSIconAdView.h
```

ADVSIconAdLoader がアイコン広告の情報をロードするためのコントローラ、ADVSIconAdView がアイコン広告を表示するためのビューです。

以下の様に実装してアイコン広告を表示します。`iconAdLoader` に登録できる `iconAdView` は最大 6 個です。

```objc
//(1) 必要なヘッダーファイルをインポート
#import <AppDavis/ADVSIconAdLoader.h>
#import <AppDavis/ADVSIconAdView.h>

@interface MTBViewController ()
//(2)プロパティ定義
@property (nonatomic) ADVSIconAdLoader *iconAdLoader;
@end

- (void)viewDidLoad
{
    [super viewDidLoad];

    //(3)アイコン広告コントローラを生成
    self.iconAdLoader = [ADVSIconAdLoader new];
    
    //(3)アイコン広告ビューを生成。複数設置する場合は個数分生成する。
    ADVSIconAdView *iconAdView = [ADVSIconAdView new];

    //(5)広告情報をロードする対象ビューを追加。複数設置する場合はすべての View を追加する。
    [self.iconAdLoader addIconAdView:iconAdView];

    //(6)広告情報をロード
    [self.iconAdLoader loadAd];
}
```

## アイコン広告の表示時のイベント取得

アイコン広告を表示する際に、そのイベントを受け取りたい場合があります。

その場合は ADVSIconAdLoader のプロパティである delegate が、

ADVSIconAdLoaderDelegate に準拠しているので、それ経由で受信する事が出来ます。

```objc

- (void)viewDidLoad
{
    [super viewDidLoad];

    //(1)delegate を設定
    self.iconAdLoader.delegate = self;
}

//(2)アイコン広告情報取得開始のイベントを通知
- (void)iconAdLoaderDidStartLoadingAd:(ADVSIconAdLoader *)iconAdLoader
{
}

//(3)アイコン広告情報全体の取得完了のイベントを通知
- (void)iconAdLoaderDidFinishLoadingAd:(ADVSIconAdLoader *)iconAdLoader
{
}

//(4)アイコン広告情報取得失敗のイベントを通知
- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didFailToLoadAdWithError:(NSError *)error
{
}

//(5)対象アイコンビューのアイコン広告情報の取得完了イベントを通知
- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didReceiveIconAdView:(ADVSIconAdView *)iconAdView
{
}

//(6)対象アイコンビューのアイコン広告情報の取得失敗イベントを通知
- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didFailToReceiveIconAdView:(ADVSIconAdView *)iconAdView
{
}

//(7)対象アイコンビューのクリックイベントを通知
- (void)iconAdLoader:(ADVSIconAdLoader *)iconAdLoader didClickIconAdView:(ADVSIconAdView *)iconAdView
{
}

```

## アイコン広告のリフレッシュ時間の調整

アイコン広告情報は ADVSIconAdLoader によってリフレッシュされます。

デフォルトの設定では30秒になっています。

リフレッシュ時間は30秒~120秒の間で以下のように設定できます。

それ以外の時間を設定しようとした場合は無視されますので注意して下さい。

```objc
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.iconAdLoader.refreshInterval = 60.0f;
}
```

## アイコン広告のリフレッシュ停止

アイコン広告情報は ADVSIconAdLoader によって自動的にリフレッシュされます。

デフォルトではリフレッシュされますので、リフレッシュされたくない場合は以下の様に設定して下さい。

```objc
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.iconAdLoader.autoRefreshingEnabled = NO;
}
```

また、一時停止と再開も可能です。

以下の様にタブの移動などでビューが移動する場合は一時停止、自身のビューに戻ってきた際に再開処理を行うことで余分な通信を減らす事ができます。

```objc

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    //(1)広告ロードを再開
    [self.iconAdLoader resume];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    //(1)広告ロードを一時停止
    [self.iconAdLoader pause];
}
```

### アイコン広告のリフレッシュ管理

リフレッシュ設定されたアイコン広告が画面内に表示しないケースがある場合には、必ず上記の一時停止・再開処理を行ってください。これには、複数広告の切り替え処理（広告振り分け SDK の利用等も含む）を行う場合も含まれます。

- 画面遷移で広告が隠れる場合など、画面内にアイコン広告が表示されない場合は、`pause` メソッドでリフレッシュを停止してください。
- 画面遷移で広告のある View に戻った場合など、画面内にアイコン広告を表示する場合は、`resume` メソッドでリフレッシュを再開させてください。

## アイコン広告表示パラメータの設定

`initMedia` 時に初期化パラメータを、第二引数 `params` として渡すことで、アイコン広告の表示形式の調整が可能です。以下の項目が設定できます。

パラメータ | 説明 | 型 | デフォルト値 | 例
--- | ---- | --- | --- | ---
ADVSParameterIconAdWidth | 広告領域の横幅 (pixel) | CGFloat | `97.5` | `@75.0f`
ADVSParameterIconAdHeight | 広告領域の縦幅 (pixel) | CGFloat | `97.5` | `@75.0f`
ADVSParameterIconAdImgWidth | 広告画像横幅 (pixel) | CFFloat | `65` | `@50.0f`
ADVSParameterIconAdImgHeight | 広告画像縦幅 (pixel | CGFloat | `65` | `@50.0f`
ADVSParameterIconAdTextColor | 文字色 (RGB16進数表記) | NSString | `000000` (黒色) | `@ff0000`
ADVSParameterIconAdTextAlpha | 文字透過設定 (0-1 の範囲の割合) | CGFloat | `1` (透過なし) | `@1.0f`
ADVSParameterIconAdTextBgColor | 文字領域の背景色 (RGB16進数表記) | NSString | `ffffff` (白色) | `@000000`
ADVSParameterIconAdTextBgAlpha | 文字領域の背景透過設定 (0-1 の範囲の割合) | CGFloat | `0` (完全な透過) | `@1.0f`
ADVSParameterIconAdTextVisible | 文字表示有無 | BOOL | 'YES' (表示する) | `@0`
ADVSParameterIconAdTextFontSize | 文字のフォントサイズ (pixel) | CGFloat | `10.4` | `@10.4f`
ADVSParameterIconAdTextWidth | 文字領域の幅 (pixel) | CGFloat | `65` | `@50.0f`
ADVSParameterIconAdTextHeight | 文字領域の高さ (pixel) | CGFloat | `16.9` | `@13.0f`
ADVSParameterIconAdTextPadding | 文字領域の上部パディング。アイコン画像と文字間の幅。最小は (pixel, 最小は `0.1`) | CGFloat | `5` | `@10.0f`
ADVSParameterIconAdTextFontAjustWidth | 文字領域の自動リサイズ設定 | BOOL | `YES` | `@0`

実装例

```objc
     [AppDavis initMedia:@"YOUR_MEDIA_ID" params:@{ADVSParameterIconAdWidth: @75.0f,
                                                   ADVSParameterIconAdHeight: @75.0f,
                                                   ADVSParameterIconAdImgWidth: @50.0f,
                                                   ADVSParameterIconAdImgHeight: @50.0f,
                                                   ADVSParameterIconAdTextColor: @"ff0000",
                                                   ADVSParameterIconAdTextAlpha: @1.0f,
                                                   ADVSParameterIconAdTextBgColor: @"ffffff",
                                                   ADVSParameterIconAdTextBgAlpha: @1.0f,
                                                   ADVSParameterIconAdTextVisible: @"1",
                                                   ADVSParameterIconAdTextFontSize: @10.4f,
                                                   ADVSParameterIconAdTextWidth: @50.0f,
                                                   ADVSParameterIconAdTextHeight: @13.0f,
                                                   ADVSParameterIconAdTextPadding: @10.0f,
                                                   ADVSParameterIconAdTextFontAjustWidth: @"0",
                                      }];
```

# インタースティシャル広告

## インタースティシャル広告の表示

インタースティシャル広告の表示に必要なファイルは以下です。

```
ADVSInterstitialAdLoader.h
```

ADVSInterstitialAdLoader を用いて以下の様に実装し、インタースティシャル広告を表示します。

```objc

//(1) ヘッダーをインポート
#import <AppDavis/ADVSInterstitialAdLoader.h>

@interface YourViewController ()
//(2) プロパティを定義
@property (nonatomic) ADVSInterstitialAdLoader *interstitialAdLoader;
@end


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //(3) ADVSInterstitialAdLoader をインスタンス化。delegate を設定
    self.interstitialAdLoader = [ADVSInterstitialAdLoader new];
    self.interstitialAdLoader.delegate = self;

    //(4) インタースティシャル広告ロードを呼び出し
    [self.interstitialAdLoader loadRequest];
}

//(5) インターステイシャル広告表示準備の完了
- (void)interstitialAdLoaderDidFinishLoadingAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
    //(6) インターステイシャル広告表示を呼び出し
    [self.interstitialAdLoader displayAd];
}

```

上記のように実装する事で、ウォール広告を表示する事が出来ます。

## インタースティシャル広告表示時のイベント取得

インタースティシャル広告を表示する際に、そのイベントを受け取りたい場合があります。

その場合は ADVSInterstitialAdLoader のプロパティである delegate が、

ADVSInterstitialAdLoaderDelegate に準拠しているので、それ経由で受信する事が出来ます。

```objc
- (void)viewDidLoad
{
    //(1) delegate を設定
    self.interstitialAdLoader.delegate = self;
}

//(2)広告のロード開始時
- (void)interstitialAdLoaderDidStartLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
}

//(3)広告のロード完了時
- (void)interstitialAdLoaderDidFinishLoadingAd:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
}

//(4)広告 View のロード完了時
- (void)interstitialAdLoaderDidFinishLoadingAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
}

//(5)広告のクリック時
- (void)interstitialAdLoaderDidClickIntersititialAdView:(ADVSInterstitialAdLoader *)interstitialAdLoader
{
}

//(6)広告のロード失敗時
- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdWithError:(NSError *)error
{
}

//(7)広告 View のロード失敗時
- (void)interstitialAdLoader:(ADVSInterstitialAdLoader *)interstitialAdLoader didFailToLoadAdViewWithError:(NSError *)error
{
}
```

# よくある質問

## iOS6.0未満の端末においてクラッシュする問題への対応

当該SDKの対応OSは6.0以上のため、6.0未満の端末において広告を表示することはできません。

しかしながら、クラッシュする問題は回避する必要があると思いますので、SDKがクラッシュ回避対応を入れるまでの間にデベロッパーアプリ側で対応できる処置をこちらに記載します。

- iOS 6.0以上の場合のみ、SDKのmethod呼び出しを行うようにする
```objc
if (NSFoundationVersionNumber_iOS_6_0 <= floor(NSFoundationVersionNumber)) {
        [AppDavis initMedia:@"1"];
}
...
```
- デベロッパーアプリ内でリンクしている、AdSupportとFoundationをoptionalにする

## 他社SDKとの競合の解決

AppDavis SDK と他社広告 SDK と同時にご利用頂いた場合に競合が発生し、AppDavis の一部の昨日がご利用いただけない事例が報告されています。

解決方法として、それぞれの SDK の利用タイミングに応じて、初期化処理 (AppDavis の場合 `initMedia` 関数の呼び出し) の呼び出し自体を出し分けてしまうことで、衝突の回避ができることがあります。
