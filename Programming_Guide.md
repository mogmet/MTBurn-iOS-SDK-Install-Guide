# 目次

* [まずはじめに]
    * [Media Id の取得]
    * [コード内初期化]
* [ウォール広告]
    * [ウォール広告について]
    * [ウォール広告の表示]
    * [ウォール広告の表示時のイベント取得]
* [アイコン広告]
    * [アイコン広告について]
    * [アイコン広告の表示]
    * [アイコン広告の表示時のイベント取得]
    * [アイコン広告のリフレッシュ時間の調整]
    * [アイコン広告のリフレッシュ停止]
* [よくある質問]
* [更新履歴]


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

## ウォール広告について

ウォール広告は〜

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

```

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
# アイコン広告


## アイコン広告の表示

アイコン広告を表示するために必要なファイルは以下の2つです。

```
ADVSIconAdLoader.h
ADVSIconAdView.h
```

ADVSIconAdLoader がアイコン広告の情報をロードするためのコントローラ、ADVSIconAdView がアイコン広告を表示するためのビューです。

以下の様に実装してアイコン広告を表示します。

```
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

```

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

```
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.iconAdLoader.refreshInterval = 60.0f;
}
```

## アイコン広告のリフレッシュ停止

アイコン広告情報は ADVSIconAdLoader によって自動的にリフレッシュされます。

デフォルトではリフレッシュされますので、リフレッシュされたくない場合は以下の様に設定して下さい。

```
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.iconAdLoader.autoRefreshingEnabled = NO;
}
```

また、一時停止と再開も可能です。

以下の様にタブの移動などでビューが移動する場合は一時停止、自身のビューに戻ってきた際に再開処理を行うことで余分な通信を減らす事ができます。

```

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

# よくある質問


# 更新履歴

| バージョン |   更新日付   |                更新内容                |
|------------|--------------|----------------------------------------|
|   1.0.0    |  2014/3/x    |             初期バージョン             |
