---
raw: raw/karpathy-llm-wiki-gist.md
source_url: https://gist.github.com/karpathy/35b05cd0f028f4acc9d7c9c2be52e5d0
tags: [template-design, llm-wiki-pattern]
---

# 2026-08-11 Karpathy LLM Wiki Gist

Karpathyが提唱するLLM Wikiパターンの原典。LLMが永続的なMarkdown wikiを段階的に構築・保守し、人間はソースのキュレーションと問いを担う。RAGのようなクエリ時検索ではなく、知識があらかじめ構造化・相互リンクされた状態で蓄積する点が核心。

## 要点

1. **RAG vs 永続Wiki**: RAGは毎回生ドキュメントから知識を再発見する。永続Wikiは知識を一度コンパイルし、最新に保つ。クロスリファレンスも矛盾フラグも合成知見も、すでにwiki上にある（[[永続Wikiと複利効果]]）。

2. **3層アーキテクチャ**: `raw/`（不変のソース）→ `wiki/`（LLM管理のMarkdown）→ Schema（[[Schema（AGENTS.md）]]）の3層。後述のテンプレート設計の中核構造。

3. **3つの操作**: [[Ingest]]（ソース取り込み）・[[QueryとFile-back]]（質問応答＋回答のwiki化）・[[Lint]]（健全性チェック＋新調査課題提案）。

4. **Obsidian as IDE**: [[Obsidian]]をwikiのIDEに見立て、Graph View・Web Clipper・[[Dataview]]・[[Marp]]などのエコシステムを活用する発想。LLMがプログラマ、wikiがコードベース。

5. **Memexへの接続**: [[Vannevar Bush]]の[[Memex]]（1945）を引用し、「文書間の連想的な繋がりの保守」をLLMが肩代わりする点にLLM Wikiの歴史的位置づけを与えている。

6. **意図的に抽象的**: このgist自体が「パターンを伝えること」だけを責務とし、具体的なディレクトリ構成やページフォーマットはユーザーとLLMが共進化させる前提。[[LLM WikiテンプレートのOptionality]]にも通じる。

## 触れている概念・実体

- 概念: [[LLM Wiki]] / [[永続Wikiと複利効果]] / [[3層アーキテクチャ]] / [[Schema（AGENTS.md）]] / [[Ingest]] / [[QueryとFile-back]] / [[Lint]] / [[Post-ingestレビューループ]] / [[バッチIngest]] / [[IndexとLog]] / [[Obsidian as IDE]] / [[Memex]] / [[連想トレイル]] / [[LLM Wikiのスケーラビリティ]] / [[LLM Wikiの応用領域]] / [[LLM WikiテンプレートのOptionality]]
- 実体: [[Andrej Karpathy]] / [[Obsidian]] / [[Obsidian Web Clipper]] / [[qmd]] / [[Marp]] / [[Dataview]] / [[Vannevar Bush]] / [[Tolkien Gateway]] / [[NotebookLM]]
