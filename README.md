# ドタバタバトル！ 🎮

**iPad 1台で友達3〜4人が対戦する、完全オフラインのパーティーゲーム。**

## 遊べるもの

- ミニゲーム6種類: ⚡超高速タップ、🎯色取り、⏱️ピッタリ5秒、🚦反射神経、💥爆弾回避（画面上だけの架空ミニゲーム）、🎡ルーレット（お金や賭けは一切なし）
- 6種類から**重複なしのランダム5ラウンド**。1位100pt、2位60pt、3位30pt、4位10pt（同点は同順位）。
- 名前入力、3人／4人選択、効果音オン／オフ、最終順位発表、優勝演出
- 横画面、タッチ操作、ネットワークなしで動作。外部CDN、ログイン、課金、通信APIは使っていません。

## ① Windowsですぐ遊んで確かめる

`Game/index.html` をChromeかEdgeで開く。インターネット不要。

本作は複数人が**画面に同時に触って**対戦する設計。Windowsでの動作確認はできるが、タッチできない通常のPCでは複数人同時タップの面白さを十分に再現できない。

## ② GitHub Actionsで「未署名IPA」を作る

Macがなくても、GitHubのmacOSランナーでiOSアプリをビルドできる構成。`project.yml` から[XcodeGen](https://github.com/yonaskolb/XcodeGen)を使ってXcodeプロジェクトを生成する。

1. GitHubにログインして、新しいリポジトリを作る。公開リポジトリにすると**中身は誰でも見られる**ので、個人情報やApple IDのパスワードはアップロードしないこと。
2. このZIPを**Windowsで解凍**し、`DotabataBattle`フォルダ内のファイルをアップロード。`.github/workflows/build-ipa.yml` も忘れずに入れる（Windowsでは`.github`は隠しフォルダー扱いになることがある）。
3. リポジトリの **Actions** → **Build unsigned iPad IPA** → **Run workflow** を実行する。アカウント／リポジトリ設定によってはActionsの利用設定が必要。
4. 成功したらジョブ実行画面の **Artifacts** から `DotabataBattle-unsigned-IPA` を入手し、ZIPを解凍する。
5. `DotabataBattle-unsigned.ipa` が出る。これは**未署名**なので、そのままiPadにインストールはできない。

GitHubのランナー利用枠や料金はGitHubの規約・設定による。公開リポジトリの標準macOSランナーはGitHubドキュメント上、無料で利用可能。

## ③ iPadにインストールする

Windows向けの[Sideloadly](https://sideloadly.io/)など、アプリの適正な署名とインストールに対応したツールが必要。利用資格を満たすApple Accountと、必要なら保護者の協力を使い、Appleの利用条件を守ること。学校など管理されたiPadではインストールが制限される場合がある。

無料Apple Accountで署名したアプリは、通常**7日**で期限切れになるので再署名が必要。再署名にはPCへの接続や設定が必要な場合があるが、**署名済みアプリが有効な間はゲームそのものをネットなしで遊べる**。

> **重要**: ここに入っているのはゲームのコード＋未署名IPAを作る設定。IPA自体はまだビルドしていない。Windows版HTMLはChromiumで操作と5ラウンド進行をテスト済み。GitHub上でのXcodeビルドと実機へのインストールは未検証。

## フォルダー構成

```text
DotabataBattle/
  Game/index.html                    ← オフラインで動くゲーム本体
  App/DotabataBattleApp.swift        ← iOSアプリの入れ物（WKWebView）
  project.yml                        ← XcodeGenの設定
  .github/workflows/build-ipa.yml    ← GitHub ActionsでIPA作成
  README.md                          ← この説明
```

## アレンジの方法

ゲームの時間・ルール・デザインなどは`Game/index.html`を編集。iOSアプリのBundle IDは`project.yml`の`PRODUCT_BUNDLE_IDENTIFIER`で変更できる。アプリの効果音はWeb Audio APIでその場で生成され、音声ファイルのダウンロードはない。
