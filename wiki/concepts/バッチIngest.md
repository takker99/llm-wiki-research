---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
tags: [template-design, llm-wiki-pattern]
---

# バッチIngest

Karpathyが[[Ingest]]の代替スタイルとして言及する運用モード。多数のソースを一度にingestし、人間の監視を減らす。

## Karpathyの記述

> "But you could also batch-ingest many sources at once with less supervision. It's up to you to develop the workflow that fits your style and document it in the schema for future sessions."

## トレードオフ

| 1つずつIngest（Karpathy推奨） | バッチIngest |
|---|---|
| 人間が各ソースの要約と更新を確認 | 監視が少ない |
| 強調点をきめ細かくガイドできる | LLMの判断に委ねる部分が大きい |
| 時間がかかる | 高速 |
| 品質が高い | 後でLintで品質を回復できる |

## 当wikiでの位置

当wikiのAGENTS.mdでは1つずつingestがデフォルトであり、バッチingestへの言及はない。Karpathy gistでは両方を選択肢として提示している。

## 関連概念

- [[Ingest]] — 基本のingest操作
- [[Post-ingestレビューループ]] — 1つずつingestと相性が良い
- [[Lint]] — バッチingest後の品質回復手段
- [[LLM WikiテンプレートのOptionality]] — どちらをデフォルトにするかはテンプレート設計の判断ポイント
