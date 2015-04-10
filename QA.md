#目次

* [問い合わせの仕方](#howto)
* [端末からどのような情報を取得していますか？](#info)
* [iOS 6.0未満の端末においてクラッシュする問題への対応](#ios6)
* [コード中にあるInstreamはどういう意味ですか](#instream)
* [〇〇の機能はありますか？](#function)
* [サンプルプロジェクトはありますか？](#sample)
* [広告の表示に問題がある（表示されない、重複するなど）](#not_found_ad)
* [バージョン番号はどういう意味がありますか？](#version)
* [他社SDKとの競合の解決](#race)

<a name="howto"></a>
#問い合わせの仕方

###問い合わせをする前に次のことをご確認ください

1. `Install-Guide`, [API 仕様 doc](http://mtburn.github.io/MTBurn-iOS-SDK-Install-Guide/appledoc/latest/) を確認する、特に`この QA ページ` にすでに解決策がないか確認する
2. [デモプロジェクト](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide/blob/master/DemoApp) を動かしてみる、また、ソースコードの該当箇所を確認する
3. [issues](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide/issues?q=is%3Aissue+is%3Aclosed) を確認する

###問い合わせ先

- [issues](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide/issues) を活用ください
- 何らかの理由により、`issues` による問い合わせが難しい場合には、担当者を介して問い合わせください
 - その場合も問い合わせ先以外の仕方はこの項を参考にしてください

###問い合わせフォーマット

- 次のフォーマットをコピーペーストして、`---` を実際の内容で置き換えてください
 - `再現した際のログ/プロジェクトファイル` がない場合は回答に時間がかかる可能性がありますので、できる限りご用意ください

```
- いつから: ---
- どの広告種別で: ---
- 症状: ---
- 再現条件: ---
- 再現した際のログ/プロジェクトファイル(あれば): ---
```

<a name="info"></a>
#端末からどのような情報を取得していますか？

- 次の情報を取得しています

| 名称 | API | 詳細 |
| --- | --- | --- |
| IDFA | `ASIdentifierManager advertisingIdentifier` | ユーザーがオプトアウト設定をしている場合には取得しない |
| OS | `UIDevice systemName` | `iPhone OS` など |
| OS バージョン | `UIDevice systemVersion` | `5.0.1 `, `7.1` など |
| 端末名称 | `utsname machine` | `iPhone4,1`, `iPhone7,1` など |
| 言語設定 | `NSLocale preferredLanguages [0]` | `ja`, `en` など |
| 国コード | `NSLocale NSLocaleCountryCode` | `JP`, `US` など |

<a name="ios6"></a>
#iOS6.0未満の端末においてクラッシュする問題への対応

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

<a name="instream"></a>
#コード中にあるInstreamはどういう意味ですか

このガイド中にある、`インフィード` `In-Feed` と同じ意味で用いられています

<a name="function"></a>
#〇〇の機能はありますか？

[Headers](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide/tree/master/AppDavis.framework/Headers) または [API 仕様ページ](http://mtburn.github.io/MTBurn-iOS-SDK-Install-Guide/appledoc/latest/) に public API がまとめられています

<a name="sample"></a>
#サンプルプロジェクトはありますか？
[DemoApp](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide/DemoApp) を参考にしてください

<a name="not_found_ad"></a>
#広告の表示に問題がある（表示されない、重複するなど）

次の順番でおおまかな原因の特定が可能です。それぞれに対する対応方法も示します。

1. アカウントに問題がある
2. アプリの呼び出し方法に問題がある

###アカウントに問題がある

ここでいう`アカウント`とは `媒体 ID (media_id)` とそれに紐づく `広告枠 ID (adspot_id)` を指します。

まず、発行いただいた`アカウント`の設定に問題がある可能性があります。それを確認するために、別の`アカウント` で試してもらうことをお願いしております。別の`アカウント`は、このドキュメントにある `media_id 1 または media_id 2` とそれぞれに紐づく `広告枠 ID` をご参照ください。

そのうえで、上記インフィード広告の説明にある、`media_id 2` とそれに紐づく`広告枠 ID` （以後、`本番の広告を表示するテストアカウント`）は、まれにですが、本番の広告を取得する性質上、広告が取得できない場合があります。
`本番の広告を表示するテストアカウント` を設定しても広告が表示されない場合には、`テストの広告を表示するテストアカウント`を試してもらうことをお願いしております。

`テストの広告を表示するテストアカウント` は `media_id` は `1` で、それぞれに対応する`広告枠 ID` は次のとおりです。

| media_id 1 に対応する広告枠 ID | media_id 2 に対応する広告枠 ID | 広告画像サイズ | 広告フォーマット |
| --- | --- | --- | --- |
| NDgzOjE | NDQ0OjMx | 114x114 pixel | ThumnailMiddle |
| Njc4OjI | OTA2OjMy | 114x114 pixel | ThumnailSmall |
| NzA3OjM | ODEzOjMz | 640x200 pixel | LandscapePhoto |
| MTY5OjQ | OTIyOjM0 | 640x320 pixel | PhotoBottom |
| OTMzOjU | NzA2OjM1 | 640x320 pixel | PhotoMiddle |
| MzUxOjk | MzA3OjM2 | 114x114 pixel | TextOnly |
| OTgxOjUy | MTI2OjU1 | 114x114 pixel | WebView（小） |
| MjQxOjUz | OTkzOjU2 | 640x200 pixel | WebView（中） |
| NjA0OjU0 | MzEzOjU3 | 640x320 pixel | WebView（大） |

###アプリの呼び出し方法に問題がある

`発行していただいたアカウント`、`本番の広告を表示するテストアカウント`、`テストの広告を表示するテストアカウント`の 3 つを試しても表示の問題が解消されない場合には、`アカウント` 関係に問題があるのか、アプリまたは SDK に問題があるのかどうかを確認してもらうことをお願いしております。

[SDK 付属のデモプロジェクト](https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide/blob/master/DemoApp)はデフォルトで `本番の広告を表示するテストアカウント` で動いているので、これを起動して表示がされれば、アプリの呼び出し方法に問題があることがわかります。`ADVSAppDelegate.m` で `アカウント`を任意に設定出来ますので、`アカウント`に問題があるのかどうかの切り分けにご活用ください。

`アカウント`に問題がある場合には、担当者にご連絡ください。

<a name="version"></a>
#バージョン番号はどういう意味がありますか？
[semver](http://semver.org/) に従います

<a name="race"></a>
#他社SDKとの競合の解決

AppDavis SDK と他社広告 SDK と同時にご利用頂いた場合に競合が発生し、AppDavis の一部の機能がご利用いただけない事例が報告されています。

解決方法として、それぞれの SDK の利用タイミングに応じて、初期化処理 (AppDavis の場合 `initMedia` 関数) の呼び出し自体を出し分けてしまうことで、衝突の回避ができることがあります。
