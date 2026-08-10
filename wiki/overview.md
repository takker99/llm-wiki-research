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
- 配布形式はどうするか？（別リポジトリ？ template/ ディレクトリ？
  GitHub Template Repository？ npx initコマンド？）
- 既存の実装（Microsoft llmwiki, llm-wiki.app, 各種CLIツール）との差別化は？
- AGENTS.mdはどこまで薄くできるか？（このwiki自身が実験台）

## 現在のソース

- `raw/karpathy-llm-wiki-gist.md` — Karpathyの原典

> ⚠ 2026-08-11時点で実在するraw/ソースは上記1件のみ。
> nishio・villagepumpのソース（6件: nishio 4 + villagepump 2）はユーザーによる誤削除で失われたため、再取得予定。
> 詳細は [[LLM Wikiの作文リスク]] と [`wiki/log.md`](log.md) を参照。

## 次のステップ

- [x] Karpathy gist のingest（→ [[2026-08-11 Karpathy LLM Wiki Gist]]、concepts/多数、entities/多数）
- 誤削除されたソース（nishio 4件、villagepump 2件）の再取得
- テンプレート草案ver.1のclaims検証（AGENTS.mdとの運用乖離検出等）
