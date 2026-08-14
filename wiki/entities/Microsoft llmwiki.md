---
tags: [entity, product, microsoft, tool]
sources: "[[リポジトリ分析 microsoft-llmwiki]]"
repo_url: https://github.com/microsoft/llmwiki
---

# Microsoft llmwiki

Microsoft製のLLM Wiki製品。VS Code拡張 + npmパッケージ（`@llmwiki/core`）+ MCPサーバのmonorepo。
LLM Wikiの[[操作層]]をソフトウェアとして完全実装した先鋭例（2026-08-12時点でv0.1.2、232 commits、MIT）。

特徴:
- 3層アーキテクチャ（raw / wiki / AGENTS.md）をKarpathyと独立に実装（構造の普遍性の証拠）
- initコマンドが7セクションのAGENTS.mdテンプレートを生成
- MCPサーバ14ツール + `@wiki`チャット（`/status` `/save` `/lint` `/fix`）
- lint 6分類・weighted query（title 3x / summary 2x / body 1x）・coverage %メトリクス
- GitHub Copilot必須（ingestにVS Code LM APIを使用）

詳細: [[リポジトリ分析 microsoft-llmwiki]]
