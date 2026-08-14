---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]", "[[パイロット分析 横断所見]]", "[[リポジトリ分析 microsoft-llmwiki]]"
tags: [template-design, llm-wiki-pattern]
---

# IndexとLog

LLM Wikiのナビゲーションを支える2つの特殊ファイル。

## index.md

コンテンツ指向。wiki内の全ページのカタログ。各エントリはリンク＋1行要約（＋任意で日付やソース数などのメタデータ）。カテゴリ別に整理される。

使い方:
- Query時、LLMは最初にindex.mdを読んで関連ページを探す
- Ingest時、LLMは新ページの追加と要約変更を反映する
- 中規模（〜100ソース、〜数百ページ）まではembeddingベースのRAGインフラなしで機能する

Karpathy: "This works surprisingly well at moderate scale"

### 配置の2派

パイロット分析から、index.mdの配置には2つの派閥がある:

| 派 | 例 | 特徴 |
|---|---|---|
| **ルート直下派** | about-nishio (1/5) | AGENTS.mdからの即時参照。パスが1段短い |
| **wiki/配下派** | grasp, AMME, BDL, delite (4/5) | wiki/が自己完結。多数派 |

### 形式のバリエーション

| 形式 | 例 |
|---|---|
| 1行リスト | about-nishio, 本wiki |
| 説明付きテーブル | grasp (各エントリにdescription付き) |
| HTMLテーブル | AMME (wikilinkバックリンクを代替) |
| カテゴリ別大規模リスト | BDL (266概念を11カテゴリに分割、409行) |

[[Microsoft llmwiki]] もH2カテゴリ（## Entities / ## Concepts / ## Sources）+ `- [Title](path) — summary #tag` の
同一形式を独立実装（Karpathy/nishio系統と独立の収束）。log.mdも `## [YYYY-MM-DD] verb | subject` で当wikiと同一。
→ [[リポジトリ分析 microsoft-llmwiki]]

nishioの実測（[[LLM Wikiの実運用データ]]）:
- 188ページでindexは約12K tokens = Opus 4.7の1.2%（問題ない）
- Gemma 4等ローカルLLMでは超過。人間の可読性を捨てAI用に書き換えで1/8圧縮可能

## index.md存廃論（2026-08-14検証）

「Cosenseの思想から見てindex.mdは筋悪では？」という論点をsubagent相談2往復で検証済み（[[index.md存廃の設計判断]]）:

- 「大きなリンク」論は適用範囲外（index.mdはplainリンクでwikilinkグラフの外）。真の批判の核心は「明示的登録作業」への違和感
- 結論: index必須維持。肥大化は可視・出口あり（カテゴリ分割/1/8圧縮/株分け）、廃止は不可視・サイレントなrecall低下
- 対応策3段階（未実装）: lintにstale-entries追加、AGENTS.mdに「indexはキャッシュ」（欠損・陳腐化時はLLMが再生成してよい）、生成型indexはvariant提示

## log.md

時系列指向。追記専用の出来事記録。ingest、query、lintパスを記録する。

KarpathyのTip: 各エントリの先頭を一貫したプレフィックスにすると（例: `## [2026-04-02] ingest | Article Title`）、シンプルなUNIXツールでパース可能になる。例: `grep "^## \[" log.md | tail -5`

### 形式のバリエーション（既存実装の実測）

2026-08-14時点の実リポジトリ調査で、見出しは全実装で**短い**（`## [DATE] action | 短い対象名`がデファクト）、**詳細は本文**に書くのが標準。

| wiki | 見出し形式 | 詳細の置き場所 | 粒度 |
|---|---|---|---|
| Karpathy gist（原典） | `## [2026-04-02] ingest | Article Title` | 本文前提 | 日付 |
| about-nishio | `## [2026-06-04 23:00] filing-back | 書く場所による言語化の効果` | 本文に箇条書き | **時刻まで** |
| delite | `## [2026-05-22] refactor | concepts/ → wiki/...` | 本文に詳細 | 日付 |
| grasp | `## [2026-06-28 08:17] implementation+file-back | title` | 本文を `code: / tests: / file back:` で構造化 | **時刻まで** |
| BDL | Query→作業→Changesの定型フォーマット | 構造化 | — |
| tsurubee記事 | `\| YYYY-MM-DD HH:MM \| ingest-paper \| Added [[論文名]], updated [[concept名]] \|` | テーブル形式 | 時刻まで |

種別語彙も拡張される: Karpathyの ingest/query/lint に対し、about-nishioは `filing-back`, `deliverable`, `correction`, `scaffold`、graspは `implementation+file-back` のような複合アクション。[[Microsoft llmwiki]] は `## [YYYY-MM-DD] verb | subject` で当wikiと同一（[[リポジトリ分析 microsoft-llmwiki]]）。

→ 当wikiの旧形式（見出しに長文全込み）はむしろ例外的で、2026-08-14の変更でデファクト（見出し短＋本文詳細）に追いついた。

### log.md肥大化と自動化の相関

パイロット分析から、file-back自動化がlog爆発を引き起こすことが確認された:

| repo | log.md | 自動化 |
|---|---|---|
| about-nishio | 313行 | 手動 |
| AMME | 336行 | 手動 |
| BDL | 1,347行 | 手動（構造化フォーマット） |
| grasp | **2,018行/334KB** | 自動（ship loop） |

テンプレートにはlog肥大化抑制ルール（例: 1回のfile-backで最大N行まで）が必要。

### log.md vs git logの分工

「git管理下ならcommit messageで賄えるのでlog.md不要では？」という論点は、[[log.mdとgit logの分工]]で検証済み。結論は「log.mdは維持しつつ軽量化」。要点: gitはコミット時刻しか測れず操作時刻は記録できない、gitの時系列は書き換え可能だがlog.mdは追記専用で不変、git diffから復元できない情報（動機・未解決事項・破棄した案・操作単位のまとまり）がlog.mdにはある。

## 当wikiでの実装

両方とも当wikiに採用されている。`index.md`の各エントリは1行ルール。`log.md`は見出し `## [DATE] action | 短い題名` + 詳細は本文（2026-08-14変更）。

## 関連概念

- [[LLM Wikiのスケーラビリティ]] — index.mdの有効範囲と限界
- [[LLM Wikiの実運用データ]] — 実測値
- [[qmd]] — indexベースを超えた後の検索ソリューション
- [[Ingest]] / [[QueryとFile-back]] — 両方を更新する操作
