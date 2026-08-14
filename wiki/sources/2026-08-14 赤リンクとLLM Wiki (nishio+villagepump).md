---
raw: ["raw/cosense/nishio/AIによる赤リンクの延伸-2026-08-14.md", "raw/cosense/nishio/Open Questionと赤リンクの延伸-2026-08-14.md", "raw/cosense/nishio/多すぎるリンク-2026-08-14.md", "raw/cosense/nishio/公開PKMが読者ケアのせいでover-linkを産む-2026-08-14.md", "raw/cosense/villagepump/赤リンクの数の議論のLLM Wiki-2026-08-14.md"]
source_url: https://scrapbox.io/nishio/AIによる赤リンクの延伸
accessed: 2026-08-14
tags: [template-design, cosense, llm-wiki-pattern, red-links]
---

# 2026-08-14 赤リンクとLLM Wiki (nishio+villagepump)

nishioの赤リンク延伸・Open Questionとの同型性・リンクの仕事の分析（Karwiとの対話）、villagepumpの赤リンクの数の議論のLLM Wiki、およびgraspのcome-from理論を統合したソース要約。Cosenseのリンク概念をLLM Wikiに輸入する際の理論的裏付け。

## 要点

1. **AIによる赤リンクの延伸（nishio, 2023-08-30）**: 「AIが毎日研究ノートを書く」システムの実験で発見されたユースケース。赤リンク（リンク先が空のリンク）を作った上で、その赤リンクを指定すれば**リンクタイトルでベクトル検索した結果を用いてページが作られる**ようになった。「確かこんなことを書いたことがある気がするな〜」をリンクサジェストが支援し、されなかった場合でもAIに任せてつなげられる。「説明のある検索」（なぜそれを候補に出したのかの説明がついている検索）と評価（[[赤リンクとLLM Wiki]]）

2. **Open Questionと赤リンクの延伸（nishio, 2026-05-31）**: **KarpathyのLLM Wikiの「Open Question」セクションは赤リンクの同型物**。赤リンクは未充足の情報の存在＝「情報の不在」を表現している。当時、情報の不在をAIに埋めさせてみる実験をしていた。Open Questionに対して仮説的にAIに回答を作らせてみるのはどうか？それを人間が見て違和感をフィードバックする（[[赤リンクとLLM Wiki]]、[[LLM Wiki]]）

3. **リンクの4つの仕事（Karwiの分析, 2026-06-24）**: Cosenseの`[X]`という1行為は4つの別々の仕事を兼ねている:
   - recall（Xのページを探す検索面）
   - attention/retrieval意図（著者が後でこの軸で戻りたい印）
   - navigation（今そこへ飛ぶ）
   - 読者ケア（この語が分からない読者を説明へ辿らせる）
   - Cosenseはこれら全部を1つのlinkに束ねる。理由はsubstrateが他のチャネルを持たないから＋人間著者が出現ごとに4チャネルを撃ち分けるコストを払えないから（束ねはsubstrate-限界∧人間労力-限界の2本撚り）
   - **grasp最適の核は3仕事を層に分離してrecallをlink graphの外へ出すこと**。recallがlinkから外れた瞬間、linkはinfrastructure（必須）からeditorial（任意の表明）に変わる。KJ法が490ページで言及されているのは「壊れたlink graph」ではなく「豊かなcorpus」だ
   - **AI著者化は人間労力-限界を溶かす**: AI著者はdeclare/4チャネル撃ち分けを実質ゼロコストで払う。ただし読者ケアだけは消費者が人間なので溶けない（come-from-at-renderが別機構として必要）（[[赤リンクとLLM Wiki]]）

4. **公開PKMが読者ケアのせいでover-linkを産む（nishio, 2026-06-24）**: 純粋にprivateなPKMなら読者は未来の自分だけで文脈を共有している。公開が文脈ゼロの見知らぬ他者を読者集合に注入するため「リンクしないと置き去りになる」不安が生まれ、over-linkが発生する。著者（PKM機能）はsparseな意図リンクを要求し、公開ストレンジャーは密な説明リンクを要求する——二つの読者が逆のリンク密度を要求する。Cosense→Markdown LLM-wikiへ移って**静的公開するとover-linkが守っていた公開読者体験を逆に劣化させる**。nishioは「親切さから一般的でない用語にリンクをつけてしまうが、双方向リンクのせいで『頻繁に言及される一般的でない用語』にbacklinkが蓄積していってしまう」と自己観察。howmのcome-fromリンクは逆に特定用語の全出現をそこに呼び集める——「この用語は一般には伝わりにくいよな」という1回の判断で全出現が親切になる

5. **come-from = 判断と帰結を用語-大域で揃える**: リンクはper-occurrenceの局所判断だが、双方向なので局所判断N個が大域的帰結（backlink hub）を生む。誰も「KJ法を490-backlink hubにしよう」と決めていない。hubは「壊れたlink graph」ではなく「局所判断が大域に漏れたartifact」。対処は「もっとリンクする」でも「リンクを消す」でもなく、判断を帰結と同じレベル（用語-大域）に上げること。come-fromの安全域＝必要域: 読者ケアが要るのは一般的でない用語で、uncommon≈一意・希少文字列＝come-fromの安全域（[[赤リンクとLLM Wiki]]）

6. **AI作ページの裸言及（come-from-declared-gather §6）**: 裸言及には3系統がある: (a)意図的non-link（そのまま）、(b)link gap（felt-sense linkを足す）、(c)**AI default 裸**（AIが書いたページは元々リンク疎）。**書き手がAI化するほど(c)が支配的になり、裸言及は著者の意図と無関係に増える**。∴mentionsの出力は「埋めるべきgap」だけでなく「come-from昇格候補」（高頻度・uncommon・一意の裸語）を別枠で出すべき

7. **赤リンクの数の議論のLLM Wiki（villagepump, 2026-05-01）**: 「赤リンクの数」の議論をClaude Codeが整理したLLM Wiki（nishio作成）。Export for AIで周辺ページごとエクスポート→ingest。個々人の意見まとめページを見て「こんなこと言ってない！」と思ったらAIにやり直しさせる運用。公式用語では「空リンク」と記載されている（help-jp）ことをAIの概念解説ページが発見した例。既存の論点との共通点を整理して未解決の事柄を「残る矛盾」として書き留める（[[赤リンクの数の議論のLLM Wiki]]、[[AIによるスタンス解説生成]]）

8. **リンクの2型を分離する（come-from vs felt-sense）**: Cosenseの単一`[X]`は宛先の違う2種類のリンクを束ねていた:
   - come-fromリンク — 用語キー・1宣言・全出現・読者のcomprehensionに奉仕（standing rule）
   - felt-senseリンク — 行キー・sparse・per-occurrence・著者のfuture-self retrievalに奉仕（edge）
   - graspがwrite/identity層を作る時、これらを同じものとしてモデル化してはいけない（[[赤リンクとLLM Wiki]]）

## 触れている概念・実体

- 概念: [[赤リンクとLLM Wiki]] / [[Cosenseのリンク概念]] / [[LLM Wiki]] / [[AIによるスタンス解説生成]] / [[Lint]] / [[LLM Wikiの作文リスク]]
- 実体: [[赤リンクの数の議論のLLM Wiki]] / [[Karwi]]
