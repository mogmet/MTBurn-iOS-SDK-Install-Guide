
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

担当者から口頭で聞いて下さい。

**今後はツールから自動取得の予定**

この Media Id はアプリの識別に用いるものですので、忘れない様にして下さい。

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //(2) ADVSWallAdLoader をインスタンス化
    ADVSWallAdLoader *wallAdLoader = [ADVSWallAdLoader new];

    //(3) ウォール広告ロードを呼び出し
    [wallAdLoader loadAd];
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
    wallAdLoader.delegate = self;
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
## アイコン広告の表示時のイベント取得
## アイコン広告のリフレッシュ時間の調整
## アイコン広告のリフレッシュ停止

# よくある質問


# 更新履歴

| バージョン |   更新日付   |                更新内容                |
|------------|--------------|----------------------------------------|
|   1.0.0    |  2014/3/x    |             初期バージョン             |
