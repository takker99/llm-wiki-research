# Overview

このLLM Wikiは、**LLM Wikiテンプレートの研究・開発**を目的とする研究wikiです。
ここに書かれている構造は研究対象（仮説の実装）であり、テンプレート設計の主張は
[[テンプレート草案ver.1]]に集約されています。

## スコープ

KarpathyのLLM Wikiパターン、nishioの実践知（20+ Wikiから得た知見）、
villagepumpコミュニティの議論をingestし、以下の問いに答えていく：

- 汎用的なテンプレートとして何を提供すべきか？
- AGENTS.mdには何を書くべきか？何を書かないべきか？
- ディレクトリ構成のベストプラクティスは？
- 配布形式はどうするか？（`template/` ディレクトリ / 別repo / npx initコマンド？）
- 既存の実装（Microsoft llmwiki, llm-wiki.app, 各種CLIツール）との差別化は？
- AGENTS.mdはどこまで薄くできるか？（このwiki自身が実験台）

## 現状

- `template/` v0.1実装済み（M1達成、2026-08-14）。配布形式・検証方針の決定は
  [[配布形式の決定とテンプレートの動機]]、claimsの追跡は [[claims対応表]]
- 次はM2: templateで外部wikiを立ち上げ・育て、このrepoが読んで評価する
- ソースの一覧と研究の進捗は [[index]] と [[このWikiの目的と研究課題]] を参照

## 次のステップ

- [x] Karpathy gist のingest（→ [[2026-08-11 Karpathy LLM Wiki Gist]]、concepts/多数、entities/多数）
- [x] Cosense議論のingest（→ [[2026-08-11 AIを使った知識マネジメント (villagepump)]]、[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]、concepts/多数、entities/多数）
- [x] template/ v0.1実装（M1）
- [ ] M2: 外部wikiをtemplateで立ち上げ・育て、このrepoが評価