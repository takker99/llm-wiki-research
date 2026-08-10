---
raw: ["raw/cosense/nishio/OKFとLLM Wiki-2026-08-11.md", "raw/cosense/nishio/一貫・網羅・頂点-2026-08-11.md", "raw/cosense/villagepump/2026-06-13-2026-08-11.md", "raw/cosense/villagepump/stakiran-OKFとMetadata_as_Code-2026-08-11.md"]
source_url: https://scrapbox.io/nishio/OKFとLLM_Wiki
accessed: 2026-08-11
tags: [template-design, okf, llm-wiki-pattern]
---

# 2026-08-11 OKFとLLM Wiki (nishio+villagepump)

2026-06-12にGoogleが発表したOpen Knowledge Format（OKF）に関するnishioの「OKFとLLM Wiki」ページ（2026-06-13作成、Karwiとの議論含む）、派生ページ「一貫・網羅・頂点」、villagepump 2026/06/13日記のOKF議論、stakiranのgist考察を統合したソース要約。

## 要点

1. **OKFとは**: Googleが2026-06-12に発表したオープン仕様。markdown + YAML frontmatterのディレクトリで知識を表現。「LLM-wikiパターンをportableでinteroperableな形式にformalizeする」とGoogle自身は位置付ける（Google Cloud Blog）。Google自身はこれを「KarpathyのLLM Wikiの改良版」と主張（[[OKF]]）。

2. **標準化戦争の認識**: KarpathyがLLM Wiki公表後にAnthropicに入社したこともあり、nishioは「これは標準化戦争だ」と感じている。villagepumpのstaも「Google本当に標準化戦争に首っつこむの好き」と反応。

3. **OKFの正体はデータカタログ由来（stakiranの分析）**: OKFのDNAはwiki文化ではなくDataplex系のデータカタログ（Entry / Aspect / EntryLinkモデル）。「仕組みはwikiの末裔だが、顔つきはデータカタログ」。Googleブログの「LLM-wiki patternをformalize」という表現は語弊があり、リポジトリ側の実際の記述は「markdown + frontmatterをagent-readable knowledge baseとして使うLLM wikiリポジトリ」で、Obsidian風と言うのが正確。OKFは「Knowledge Format」より「Knowledge Packaging Format」に近い（[[OKF]]）。

4. **format層と操作層の区別（nishioの考察1）**: OKFが標準化したのは「成果物（format）層」であり、「操作（足場）層」ではない。KarpathyのLLM Wikiは「知的生産の操作を言語化してAIに代行させられるようにする」こと。OKFは操作の標準化ではなく成果物のフォーマットの標準化しかしない。→ テンプレート設計の差別化点（[[LLM WikiテンプレートのOptionality]]）。

5. **赤リンク論争（OKF §9）**: OKFは壊れリンク=「未記述知識」として許容する（§9）。LLM Wiki側はlintが壊れリンクをエラー扱いする。nishioは「意図的な前方参照（未作成ページへのstub）とリネーム漏れ/誤りを区別する余地。前者を許す運用はwikiを育てやすい」と指摘。Cosenseの「同一の赤リンクが複数ページに出現→仮想的ページ（バックリンクリスト）ができる＋2ホップリンクで繋がる」挙動は一歩先で、OKFにも言及がない。concept ID＝ファイルパスのOKF・素のMarkdown wikiは赤リンクを「解決しないパス＝エラー」としか扱えず、キーワードベース・リンク（タイトル同一性での自動集約）を取りこぼす（Karwiの分析）（[[Lint]]、[[赤リンクの数の議論のLLM Wiki]]）。

6. **cross-run stability批判（nishioの考察2、後に撤回）**: OKFのenrichment eval（同一入力で毎回同じ概念集合を出せるか）は、本wikiの意味的lintの外部化とも読めるが、nishioは「安定性を求めることと新規な知的生産の発展はトレードオフ」と批判（利用と探索のトレードオフ、ランチエ/スペキュラトゥール）。cross-run stabilityは「創発を関数化しろ」という要求であり、予測可能な創発はもう創発ではない。「ジャズのソロを『同じに弾き直せるか』で採点するに等しい」。KJ法の意義を殺す「インテリ男性が理性でラベルを整理する」病の定量メトリクス版。後に「応用ドメインの違い」として整理（企業の事業活動では安定性は筋が通る。知的生産支援では違う）（[[一貫・網羅・頂点]]）。

7. **「安定性」の解像度向上 → 一貫・網羅・頂点**: この議論を通じて「安定性」の3つの異なる価値を分解した: 一貫（毎回同じ答え、min）、網羅（全部集める、union）、頂点（最良の一つ、max）。スペキュラトゥール（創発を生む人）が欲しいのは多くの場合peak。引用の正確さ（接地）はこの3つに入らない「床」で、全員に必要。信頼は非局所的で、引用リンク切れ1個で全体の信用が崩れる（[[一貫・網羅・頂点]]、[[LLM Wikiの作文リスク]]）。

8. **AIランチエ分業**: スペキュラトゥールは内部に「AIランチエ」を持てる。Karpathyの「LLMs don't get bored」＝疲れないAIランチエ。個人wikiが破綻してきたのは人間がランチエ保守に飽きたから。渡していいのは「接地の衛生」（引用検証・矛盾検出・raw突き合わせ）だけで、「どのframingを立てるか」（創発）は渡してはいけない。最大の落とし穴は、人間が退屈仕事から降りると境界を見張る者が消え、有能なAIランチエが創発層を無難に均してしまうこと。

9. **OKFの進化（v0.2）**: provenance（sources・信頼シグナル）、trust（generated / verified）、lifecycle（status: draft→stable→deprecated、stale_after）、attestation（Attested Computation）をfrontmatterでfirst-class化。本wikiのsources/status frontmatter慣行との親和性が高い（[[OKF]]）。

10. **terangの妄想（villagepump）**: 「じっくり読書会」のメモをLLM wiki or OKF的に外に見せつつ、元メモの更新が外部表示に同期するようにしたい。貧民的LLM wiki運用への関心。inajobのLLM wikiいじりを見ての妄想。

## 触れている概念・実体

- 概念: [[Lint]] / [[一貫・網羅・頂点]] / [[LLM Wikiの作文リスク]] / [[LLM WikiテンプレートのOptionality]] / [[赤リンクの数の議論のLLM Wiki]] / [[LLM Wiki]]
- 実体: [[OKF]] / [[Andrej Karpathy]] / [[Karwi]]
