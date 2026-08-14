---
sources: "[[2026-08-14 赤リンクとLLM Wiki (nishio+villagepump)]]"
tags: [template-design, cosense, llm-wiki-pattern, red-links]
---

# 赤リンクとLLM Wiki

KarpathyのLLM Wikiには想定されていなかったCosenseのリンク概念を、LLM Wikiに取り入れる方法論とその理論的裏付け。赤リンク＝情報の不在表現がLLM WikiのOpen Questionと同型であること、AIによる赤リンク延伸、リンクの仕事の層分離（come-from）、lint設計への含意を扱う。

## 赤リンクは情報の不在の表現

nishioの分析（2026-05-31）: **赤リンクは未充足の情報の存在＝「情報の不在」を表現している**。KarpathyのLLM Wikiの「Open Question」セクションがLLMが書いてくる質問は、この赤リンクの同型物である。Open Questionに対して人間が答えるのと同じく、赤リンク（情報の不在）をAIに埋めさせてみる実験がなされていた。

### AIによる赤リンクの延伸（2023-08-30）

「AIが毎日研究ノートを書く」システムのユースケースとして発見:

- 赤リンク（リンク先が空のリンク）を作った上で、その赤リンクを指定すれば**リンクタイトルでベクトル検索した結果を用いてページが作られる**
- 「確かこんなことを書いたことがある気がするな〜」をリンクサジェストが支援し、されなかった場合でもAIに任せてつなげられる
- 「説明のある検索」（なぜそれを候補に出したのかの説明がついている検索）と評価された
- 発展形: AIの生成物を見て「長めのフレーズ」にマーカーを引く感じでリンクにし、赤リンク延伸する

### Open Questionへの応用

Open Questionに対して仮説的にAIに回答を作らせてみるのはどうか？それを人間が見て違和感をフィードバックする。→ [[徒歩レビュー]]（人間は違和感のみ）と同型の運用。

## リンクの4つの仕事（Karwiの分析）

Cosenseの`[X]`という1行為は4つの別々の仕事を兼ねている:

1. recall — Xのページを探す検索面
2. attention/retrieval意図 — 著者が後でこの軸で戻りたい印
3. navigation — 今そこへ飛ぶ
4. 読者ケア — この語が分からない読者を説明へ辿らせる

Cosenseがこれらを束ねる理由は2つ: **substrateが他チャネルを持たない**＋**人間著者が出現ごとに4チャネルを撃ち分けるコストを払えない**（2本撚り）。

**grasp最適の核**: 3仕事を層に分離してrecallをlink graphの外へ出す。recallがlinkから外れた瞬間、linkはinfrastructure（必須）からeditorial（任意の表明）に変わる。KJ法が490ページで言及されているのは「壊れたlink graph」ではなく「豊かなcorpus」だ。

**AI著者化は人間労力-限界を溶かす**: AI著者はdeclare/4チャネル撃ち分けを実質ゼロコストで払う。ただし**読者ケアだけは消費者が人間なので溶けない**（come-from-at-renderが別機構として必要）。

## 公開PKMがover-linkを産む問題

純粋にprivateなPKMなら読者は未来の自分だけで文脈を共有しているため「リンクしないと分からない」不安は生まれない。公開が文脈ゼロの見知らぬ他者を読者集合に注入し、「リンクしないと置き去りになる」が実在の不安になる。

- 著者（PKM機能）はsparse・felt-sense・意図リンクを要求
- 公開ストレンジャーは密な説明リンクを要求
- **Cosense→Markdown LLM-wikiへ移って静的公開すると、over-linkが守っていた公開読者体験を逆に劣化させる**

## come-from = 判断と帰結のレベルを揃える

リンクはper-occurrenceの局所判断だが、双方向なので局所判断N個が大域的帰結（backlink hub）を生む。誰も「KJ法を490-backlink hubにしよう」と決めていない。hubは「壊れたlink graph」ではなく「局所判断が大域に漏れたartifact」。

対処は「もっとリンクする」でも「リンクを消す」でもなく、**判断を帰結と同じレベル（用語-大域）に上げること**。howmのcome-fromリンク（`<<< aaa`）は「この用語は一般には伝わりにくいよな」という1回の判断で全出現（過去も未来も）が親切になる。

**安全域＝必要域**: 読者ケアが要るのは一般的でない用語で、uncommon≈一意・希少文字列＝come-fromの安全域。危険域（一般的な多義語）はまさに読者ケアが要らない域。

## AI作ページの裸言及

裸言及には3系統がある:

| 源 | 意味 | 正しい解決 |
|---|---|---|
| (a) 意図的 non-link | 著者がhub肥大を避け裸で書いた | そのまま（or come-from宣言） |
| (b) link gap | 本来リンクしたいが貼り忘れ | felt-sense linkを足す |
| (c) AI default 裸 | AIが書いたページは元々リンク疎 | come-fromで一括gather |

**書き手がAI化するほど(c)が支配的**になり、裸言及は著者の意図と無関係に増える。∴ lintは「埋めるべきgap」だけでなく「come-from昇格候補」（高頻度・uncommon・一意の裸語）を別枠で出すべき。

## リンクの2型の分離

Cosenseの単一`[X]`は宛先の違う2種類のリンクを束ねていた:

- **come-fromリンク** — 用語キー・1宣言・全出現・読者のcomprehensionに奉仕（standing rule）
- **felt-senseリンク** — 行キー・sparse・per-occurrence・著者のfuture-self retrievalに奉仕（edge）

これらはidentityもlifecycleも別であり、同じものとしてモデル化してはいけない。

## 実践例

- [[リポジトリ分析 grasp]]関連: `unresolved`コマンドで未解決targetのrank view（TODOではなく概念ノード）、`mentions`で裸言及の監査、`related`で2-hop、`read`で近傍同梱
- [[リポジトリ分析 BDL-2026S]]: broken_wikilink（1頁参照）=typo扱い / aspect_handle（2+頁参照）=概念ハブの種に分類。「赤リンクはfeature、TODOリスト扱いするな」「1頁参照だけでページを作るな」
- [[リポジトリ分析 SMS-2026S-report]]: lint_wiki.pyで参照数分割。「unresolvedはbrokenではない、全て実参照」「2+頁参照=aspect-handle候補（2-hop hubの種）」

## テンプレート設計への含意

1. **lintの設計**: broken-wikilink=エラー一辺倒ではなく、参照数による分類（1頁=typo/error、2+頁=aspect_handle/info）が有力。本wikiの[[Lint]]は現在エラー扱いであり、赤リンク許容との分岐が研究課題
2. **LLM生成ページのリンク疎問題**: AIが書くページは元々リンク疎（(c)）なので、wikilinkの追加を強制するよりcome-from的gatherや、赤リンク許容で「将来の接続点」として残す運用が向く
3. **2 hop linkの輸入**: 赤リンク（同一の赤リンクを共有するページ群）を2-hop関連として提示するlint改善は既に研究課題にある（[[このWikiの目的と研究課題]]）

## 関連概念

- [[Cosenseのリンク概念]] — 基本概念の体系
- [[Lint]] — 壊れリンクの扱い論争
- [[LLM Wiki]] — Open Questionとの同型性
- [[徒歩レビュー]] — 違和感フィードバックの分業
- [[OKF]] — §9の赤リンク許容
- [[LLM Wikiの作文リスク]] — 赤リンク延伸が作文リスクとどう関わるか
