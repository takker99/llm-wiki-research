---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]"
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

nishioの実測（[[LLM Wikiの実運用データ]]）:
- 188ページでindexは約12K tokens = Opus 4.7の1.2%（問題ない）
- Gemma 4等ローカルLLMでは超過。人間の可読性を捨てAI用に書き換えで1/8圧縮可能

## log.md

時系列指向。追記専用の出来事記録。ingest、query、lintパスを記録する。

KarpathyのTip: 各エントリの先頭を一貫したプレフィックスにすると（例: `## [2026-04-02] ingest | Article Title`）、シンプルなUNIXツールでパース可能になる。例: `grep "^## \[" log.md | tail -5`

役割:
- wikiの進化のタイムラインを提供
- LLMが最近何が行われたかを理解するのに役立つ

## 当wikiでの実装

両方とも当wikiに採用されている。`index.md`の各エントリは1行ルール。`log.md`のフォーマットは `## [DATE] action | detail`。

## 関連概念

- [[LLM Wikiのスケーラビリティ]] — index.mdの有効範囲と限界
- [[LLM Wikiの実運用データ]] — 実測値
- [[qmd]] — indexベースを超えた後の検索ソリューション
- [[Ingest]] / [[QueryとFile-back]] — 両方を更新する操作
