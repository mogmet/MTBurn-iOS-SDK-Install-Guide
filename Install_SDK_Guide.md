
本ドキュメントは AppDavis iOS SDK を Xcode のプロジェクトに追加し、実際に使える所までを記したものです。

サポートする Xcode のバージョンは 5.0 以上としています。

## AppDavis iOS SDK をダウンロード

以下の URL から AppDavis iOS SDK をダウンロードします。

(TODO:URL を変更)

[AppDavis iOS SDK をダウンロード](https://www.dropbox.com/s/hc8jtk8m2fyaxug/AppDavis.1.0.zip)

ダウンロードが完了したら、取得した zip ファイルを解凍して以下の Framework ファイルを確認して下さい。

```
AppDavis.framework
```

## AppDavis iOS SDK をインストール

上記で取得した Framework ファイルをプロジェクトへ追加します。

### プロジェクトへの追加

まずは取得した Framework ファイルをプロジェクトへ追加します。

AppDavis.framework をドラッグ&ドロップで、プロジェクトの Frameworks ディレクトリに入れて下さい。


![](Install_SDK_Guide_Images/framework_add.png)


追加時に出てくるオプション情報入力では以下の様にして下さい。


![](Install_SDK_Guide_Images/choose_options.png)


Frameworks グループに AppDavis.framework が追加された事を確認できたら、以下の順番で追加する AdSupport.Framework を設定します。

- 1.プロジェクトファイルを選択

- 2.ビルドターゲットを選択

- 3.Build Phase タブを選択

- 4.Link Binary with Libraries セクションの + ボタンをクリック


![](Install_SDK_Guide_Images/goto_build_phases.png)


- 5.AdSupport.framework を選択

- 6.Add ボタンをクリック


![](Install_SDK_Guide_Images/select_adsupport_framework.png)


これでインストールは完了です。
