---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]", "[[パイロット分析 横断所見]]"
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

nishioの実測（[[LLM Wikiの実運用データ]]）:
- 188ページでindexは約12K tokens = Opus 4.7の1.2%（問題ない）
- Gemma 4等ローカルLLMでは超過。人間の可読性を捨てAI用に書き換えで1/8圧縮可能

## log.md

時系列指向。追記専用の出来事記録。ingest、query、lintパスを記録する。

KarpathyのTip: 各エントリの先頭を一貫したプレフィックスにすると（例: `## [2026-04-02] ingest | Article Title`）、シンプルなUNIXツールでパース可能になる。例: `grep "^## \[" log.md | tail -5`

### log.md肥大化と自動化の相関

パイロット分析から、file-back自動化がlog爆発を引き起こすことが確認された:

| repo | log.md | 自動化 |
|---|---|---|
| about-nishio | 313行 | 手動 |
| AMME | 336行 | 手動 |
| BDL | 1,347行 | 手動（構造化フォーマット） |
| grasp | **2,018行/334KB** | 自動（ship loop） |

テンプレートにはlog肥大化抑制ルール（例: 1回のfile-backで最大N行まで）が必要。

## 当wikiでの実装

両方とも当wikiに採用されている。`index.md`の各エントリは1行ルール。`log.md`のフォーマットは `## [DATE] action | detail`。

## 関連概念

- [[LLM Wikiのスケーラビリティ]] — index.mdの有効範囲と限界
- [[LLM Wikiの実運用データ]] — 実測値
- [[qmd]] — indexベースを超えた後の検索ソリューション
- [[Ingest]] / [[QueryとFile-back]] — 両方を更新する操作
