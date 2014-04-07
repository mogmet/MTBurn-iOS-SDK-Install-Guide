# 目次

* [まずはじめに](#まずはじめに)
    * [Media Id の取得](#Media Id の取得)
    * [コード内初期化](#コード内初期化)
* [ウォール広告](#ウォール広告)
    * [ウォール広告の表示](#ウォール広告の表示)
    * [ウォール広告の表示時のイベント取得](#ウォール広告の表示時のイベント取得)
    * [ウォール広告誘導ボタンの表示計測](#ウォール広告誘導ボタンの表示計測 )
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

    //(4444) ウォール広告ロードを呼び出し
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

# アイコン広告


## アイコン広告の表示

アイコン広告を表示するために必要なファイルは以下の2つです。

```
ADVSIconAdLoader.h
ADVSIconAdView.h
```

ADVSIconAdLoader がアイコン広告の情報をロードするためのコントローラ、ADVSIconAdView がアイコン広告を表示するためのビューです。

以下の様に実装してアイコン広告を表示します。

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

    //(3)アイコン広告ビューを生成
    ADVSIconAdView *iconAdView = [ADVSIconAdView new];

    //(4)アイコン広告コントローラを生成
    self.iconAdLoader = [ADVSIconAdLoader new];

    //(5)広告情報をロードする対象ビューを追加
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
ADVSParameterIconAdTextPadding | 文字領域の上部パディング (pixel) | CGFloat | `5` | `@10.0f`
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

    //(3) ADVSInterstitialAdLoader をインスタンス化
    self.interstitialAdLoader = [ADVSInterstitialAdLoader new];

    //(4) インタースティシャル広告ロードを呼び出し
    [self.interstitialAdLoader loadRequest];
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
