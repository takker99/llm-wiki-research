---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
tags: [template-design, llm-wiki-pattern]
---

# Schema（AGENTS.md）

LLM Wikiの3層アーキテクチャにおける第3層。LLMにwikiの構造・規約・ワークフローを伝える設定ドキュメント。Claude Codeでは `CLAUDE.md`、OpenAI Codexでは `AGENTS.md` というファイル名が使われる。

Karpathyの定義: 「LLMをしつけられたwiki保守者にするための鍵。これがあることでLLMは単なる汎用チャットボットではなくなる」

## 役割

- wikiのディレクトリ構造を定義する
- ページの規約（命名、フォーマット）を定める
- Ingest / Query / Lint のワークフローを指示する
- 人間とLLMが時間をかけて共進化させる（ドメインに合わせて調整）

## Schemaの二層性

Karpathy gist自身が指摘するように、Schemaには2つのレベルがある:
1. **パターン文書**（Karpathy gistのような抽象レベル）— アイデアを伝える
2. **運用Schema**（各wikiのAGENTS.md）— 具体的なルールを定める

この分離がLLM Wikiテンプレート設計の核心課題の一つ → [[LLM WikiテンプレートのOptionality]]

## 関連概念

- [[3層アーキテクチャ]] — Schemaが属する構造
- [[LLM Wiki]] — 全体パターン
- [[LLM WikiテンプレートのOptionality]] — 何をテンプレート化し何をユーザー任せにするか
