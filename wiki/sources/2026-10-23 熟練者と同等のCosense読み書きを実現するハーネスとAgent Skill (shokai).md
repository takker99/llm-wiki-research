---
raw:
  - "raw/cosense/shokai/熟練者と同等のCosense読み書きを実現するハーネスとAgent Skill-2026-10-23.md"
source_url: "https://scrapbox.io/shokai/%E7%86%9F%E7%B7%B4%E8%80%85%E3%81%A8%E5%90%8C%E7%AD%89%E3%81%AECosense%E8%AA%AD%E3%81%BF%E6%9B%B8%E3%81%8D%E3%82%92%E5%AE%9F%E7%8F%BE%E3%81%99%E3%82%8B%E3%83%8F%E3%83%BC%E3%83%8D%E3%82%B9%E3%81%A8Agent_Skill"
repo_url: "https://github.com/helpfeel/cosense-cli"
commit: "e06bc890958cfe8d1b6fe932db06c35eb8c8577d"
accessed: 2026-10-23
tags: [template-design, cosense, agent-skills, query, ingest]
---

# 2026-10-23 熟練者と同等のCosense読み書きを実現するハーネスとAgent Skill (shokai)

shokaiによるToKyoto.js #03の発表資料、および`@helpfeel/cosense-cli`の実装・スキル文書群を統合したソース要約。AIに熟練者と同等の観点でナレッジグラフを読み書きさせるためのUI翻訳と、CLI・Agent Skill間の責任境界を扱う。

## 要点

1. 人間向けUIのAI向け翻訳による複雑性の縮減
   - 人間がCosenseを「ちゃんと読む」と呼ぶ行為は、本文だけでなく更新日時・執筆者・アイコン記法・関連ページリストをUI上で同時に知覚することで成り立っている
   - 手順書で「書く前にそのページを読め」「関連ページも読んで文脈を掴め」「更新者を確認しろ」「画像も見ろ」と指示を積み重ねると、手順書が肥大化し下位モデルで動作しなくなる
   - 解決策は手順書の詳細化ではなく、AIが読みたくなるMarkdown出力を返すCLIコマンドを用意し、人間用のUIをAI用に翻訳することにある

2. `browsePage`によるメタデータと関連ページリストの強制同梱
   - 本文より先にメタデータを見てほしいので、タイトル・pageId・commitId・更新日時・被リンク数・pageRankを先頭に出力する
   - 本文の末尾に`-------------------- Related Pages --------------------`として1 hopの関連ページタイトル一覧をpageRank降順で必ず出力する。日付ページ等のシリーズものはスタックして省略し、過剰な注目を防ぐ
   - 対象が未作成の空ページでもエラーにせず、未作成である旨とRelated Pagesを出力する。本文が空でも他ページの文脈から意味を掴めるようにするためである
   - 添付画像やGyazo URLは`<cosense:file>`や`<cosense:gyazo>`タグに展開し、OCRテキストやサイズを本文中に埋め込むことで、手順書で命令しなくてもAIが自律的に画像を読むように誘導する

3. 2段階の近傍探索と辿る深さの分岐
   - 起点選定ではベクトル検索と全文検索を併用する。短いクエリは抽象的な原理原則のページに、長い質問文は具体的なページに当たりやすい
   - 読む深さは「指定されたページのみ読む」と「関連ページまでしっかり読む」の2モードに分ける。浅いモードでも`browsePage`末尾の1 hopタイトル一覧は追加コストなしで視界に入る
   - 深いモードでは`list1hopLinks`・`list2hopLinks`・`browseRelatedPages`で近傍の`title`・`descriptions`・`relation`・`pageRank`を取得し、問いに関連するページだけを選んで`browsePage`で深掘りする。全リンク読破は完了条件にしない

4. 「書く前に読む」の制度化と内部リンク選定規律
   - 編集手順書`edit-page.md`は、文面を考える前に必ず対象ページを`browsePage`で読むことを求める。新規作成のつもりでも先に読み、既存の空ページに対する逆リンクや前書きを把握する
   - 文体や見出しの立て方はSkill内に固定規則を持たず、近いテーマの既存ページや前回のシリーズページを1〜2枚`browsePage`で観察して合わせる
   - 内部リンクは文中の固有名詞を網羅するのではなく、ページの主題を構成する中心概念で既存ノードに繋がる語に絞る
   - リンクの却下基準を明文化している。主題と直接関係のない被リンク数が突出したハブページへのリンク、文脈が違う同名ページ、同一ページ内の重複リンク、およびproject内に存在しない投機的な空リンクは却下する
   - `previewEdit`によるdry-runと、`submitEdit`後の`browsePage`による関連ページリストへの接続確認で、表記ゆれによるリンク不成立を防ぐ

5. CLIとAgent Skillの責任境界
   - `cosense <cmd> --help`: 引数・戻り値スキーマ・例といったmechanicsを書く。使う直前に読まれる
   - `SKILL.md`: ドメイン知識と「こういう時はこうする」のケース分岐・コマンド一覧表を書く
   - 個別手順書: コマンドを効果的に使うwisdomと、注目すべきフィールド名およびその注目理由を書く。`--help`を読めば分かるスキーマ定義や型は書かない

## 触れている概念・実体

- 概念: [[Cosenseのリンク概念]] / [[赤リンクとLLM Wiki]] / [[操作層]] / [[AGENTS.md+SKILL.md二層設計]] / [[QueryとFile-back]] / [[Ingest]]
- 実体: [[Agent Skills]]
- 分析: [[Cosense Skillとgraspに学ぶQuery近傍読解とIngest書き込み設計]] / [[リポジトリ分析 grasp]]
