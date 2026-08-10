---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
---

# qmd

Markdownファイル用のローカル検索エンジン。KarpathyがLLM Wikiのスケールアップ時に推奨するツール。

## 特徴

- BM25/ベクトル検索のハイブリッド
- LLMリランキング
- 完全オンデバイス（データが外部に出ない）
- CLIインターフェース（LLMがshell outして使える）
- MCPサーバー（LLMがネイティブツールとして使える）

## LLM Wikiでの位置

[[LLM Wikiのスケーラビリティ|index.mdが限界を迎えた]]後の検索ソリューション。中規模（〜100ソース）まではindexベースで十分だが、それを超えたらqmdのような専用ツールが必要になる。

## 関連概念

- [[LLM Wikiのスケーラビリティ]] — どの段階で必要になるか
- [[IndexとLog]] — 基本のナビゲーション（qmd導入前）
- [[LLM WikiテンプレートのOptionality]] — テンプレートに含めるかどうか
