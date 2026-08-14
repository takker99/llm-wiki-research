---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[リポジトリ分析 microsoft-llmwiki]]"
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

tsurubee（2026-08-11 ingest）は別の理由で自動化を拒否する: 自動ingestは「自分が気づかない場所で概念ページが勝手に育ち、いつの間にこんなページができたんだという状態になる」として、理解のボトルネック（[[理解のボトルネック]]）を深刻化させると警戒。ソース選定を自分の手で行い、量より質を採る。これは「読む前提」の設計思想の帰結であり、[[AIによるingest停止判断]]（AI側の取捨選択）とは対照的な解決策。

## ソフトウェア実装例（Microsoft llmwiki）

[[Microsoft llmwiki]] はバルクIngestをコマンドとして製品化:
フォルダ再帰walk（`.`プレフィックス・`node_modules`等スキップ）、20ファイル超で確認ダイアログ、
raw/へのdrag&dropをfile watcherが自動ingest、外部ファイルは `.wiki/raw/` にコピーしてからingest。
監視を自動化しつつ、**量の上限で人間の確認を残す**設計（>20件でconfirmation）。
→ [[リポジトリ分析 microsoft-llmwiki]]。これは「自動化しつつ[[Post-ingestレビューループ]]を残す」1つの解。

## 当wikiでの位置

当wikiのAGENTS.mdでは1つずつingestがデフォルトであり、バッチingestへの言及はない。Karpathy gistでは両方を選択肢として提示している。

## 関連概念

- [[Ingest]] — 基本のingest操作
- [[Post-ingestレビューループ]] — 1つずつingestと相性が良い
- [[Lint]] — バッチingest後の品質回復手段
- [[LLM WikiテンプレートのOptionality]] — どちらをデフォルトにするかはテンプレート設計の判断ポイント
- [[ingestの監視頻度とソース数の2軸]] — バッチの本質は「多数のソース」ではなく「少ない監視」にあるという整理
