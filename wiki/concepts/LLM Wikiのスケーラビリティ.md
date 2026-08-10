---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
tags: [template-design, llm-wiki-pattern]
---

# LLM Wikiのスケーラビリティ

LLM Wikiのファイルベースナビゲーション（[[IndexとLog|index.md]]）がどの規模まで有効か、それを超えた場合の対応策。

## Karpathyの見立て

- **中規模（〜100ソース、〜数百ページ）**: index.md + ファイル読みで十分機能する。"surprisingly well"。embeddingベースのRAGインフラは不要。
- **大規模（それを超える）**: 適切な検索が必要になる。

## スケールアップオプション

Karpathyが言及するツール:
- **[[qmd]]**: Markdownファイル用のローカル検索エンジン。BM25/ベクトル検索のハイブリッド + LLMリランキング。すべてオンデバイス。CLI（LLMがshell out）とMCPサーバー（LLMがネイティブツールとして利用）の両方を提供。
- **自作**: LLMに手伝ってもらい、必要に応じて単純な検索スクリプトをvibe-codingすることもできる。

## 設計含意

テンプレート設計において:
- 初期状態ではindexベースのシンプルな構成を提供し、検索は必要になったら追加する方針が合理的
- qmd等のツールとの統合はテンプレートの範囲外（ユーザー任せ）でよいか → [[LLM WikiテンプレートのOptionality]]

## 関連概念

- [[IndexとLog]] — 基本のナビゲーション基盤
- [[qmd]] — スケールアップ時の検索ソリューション
- [[LLM WikiテンプレートのOptionality]] — テンプレートにどこまで含めるか
