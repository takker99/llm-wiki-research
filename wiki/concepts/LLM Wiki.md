---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
tags: [template-design, llm-wiki-pattern]
---

# LLM Wiki

LLMが永続的なMarkdown wikiを段階的に構築・保守するパターン。人間はソースのキュレーション・問い・方向付けを担い、LLMが要約・相互参照・ファイリング・帳簿管理をすべて行う。

Karpathyの定式化: 「Obsidian が IDE、LLM がプログラマ、wiki がコードベース」。つまり:
- 人間は wiki を直接書かない（または稀にしか書かない）
- LLMが会話に基づいて編集し、人間はリアルタイムで結果をブラウズする
- リンクを辿り、グラフビューを見て、更新されたページを読むのが人間の役割

## 関連概念

- [[永続Wikiと複利効果]] — RAGとの対比で「compounding artifact」を説明
- [[3層アーキテクチャ]] — raw / wiki / Schema
- [[Ingest]] / [[QueryとFile-back]] / [[Lint]] — 3つの基本操作
- [[Obsidian as IDE]] — 具体的なツールチェーン
- [[Memex]] — Vannevar Bush の先駆的ビジョンとの接続
- [[LLM Wikiの応用領域]] — 個人・研究・読書・ビジネス等
- [[LLM WikiテンプレートのOptionality]] — パターンと実装の分離
