---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
tags: [template-design, llm-wiki-pattern]
---

# LLM WikiテンプレートのOptionality

Karpathy gistのメタ設計原則。パターン（抽象的なアイデア）と実装（具体的なディレクトリ構造・ページフォーマット・ツール）を明確に分離し、すべてを「オプショナルでモジュラー」と位置づける。

## Karpathyの定式

> "This document is intentionally abstract. It describes the idea, not a specific implementation. The exact directory structure, the schema conventions, the page formats, the tooling — all of that will depend on your domain, your preferences, and your LLM of choice. Everything mentioned above is optional and modular — pick what's useful, ignore what isn't."

## Optionalityの例

| 要素 | Optionalな理由 |
|---|---|
| 画像処理 | ソースがテキストのみなら不要 |
| 検索エンジン（[[qmd]]） | 小規模wikiでは[[IndexとLog\|index.md]]で十分 |
| スライドデッキ（[[Marp]]） | Markdownページだけで十分な場合がある |
| 出力フォーマット全般 | ユーザーのニーズ次第で完全に異なるセットでもよい |

## テンプレート設計への含意

この原則は、LLM Wikiテンプレートが答えるべき核心的問いを提起する:
- 汎用テンプレートとして**何を提供すべきか**（必須デフォルト）
- **何をユーザー任せにするか**（optionalな拡張ポイント）
- [[Schema（AGENTS.md）]]には**何を書くべきか、何を書かないべきか**

当wikiの研究課題そのもの → [[このWikiの目的と研究課題]]

## 関連概念

- [[LLM Wiki]] — 全体パターン
- [[Schema（AGENTS.md）]] — Optionalityを具体化する設定文書
- [[Obsidian as IDE]] — optionalなツールチェーンの一例
- [[このWikiの目的と研究課題]] — この原則をテンプレート設計にどう落とし込むか
