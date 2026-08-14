---
sources: [[2026-08-11 AIを使った知識マネジメント (villagepump)]]
tags: [template-design, llm-wiki-pattern]
---

# fact-wiki-separation（Wikiをsource of truthにしない）

「Wikiをsource of truthにしない」というポリシー。nishioが評価し、このWikiの[[3層アーキテクチャ]]と[[Vault分離と人間-AIの境界]]の延長線上にある概念。

## 要点

- **source of truthは勝手に書き換えてはいけない**。Wikiにsource of truthがあると「Wikiを書き換えていいのかどうかわからず、追記追記になってしまう」→ Wikiは動的合成層として気軽に書き換え・削除できる状態を保つ
- **より信頼できる情報源がLLM Wikiと明瞭分離されていることに意味がある**。外部の主宅地（人間のCosense/グループウェア）とは境界で区別し、ingest/file-backが境界での輸入・保存操作になる
- **Wikiを簡潔に保つ**。source of truthを置かないことで、Wiki内容は気軽に書き換え/削除できる → [[株分け（kabuwake）]]（株分け）、移植、再構成が起き、Wikiが動的な合成層として機能する → [[Wikiはワークショップ]]
- 3層アーキテクチャでは `raw/` がsource of truth（不変・append-only）であり、`wiki/`が派生層 → このWiki自身が本概念の実装例

## 設計上の意義

- 「書き換え自由の担保」という3層アーキテクチャの機能の1つを、概念レベルで独立させたもの → [[rawディレクトリの取り扱い]]
- Vault分離（人間vaultとAI vaultの分離）を「どの情報を真実の源とするか」の設計選択として捉え直す: 真実の源を外部に置けば置くほど、Wikiは自由に書き換えられる作業場になる

## 関連概念

- [[3層アーキテクチャ]] — raw/wikiの分離が本概念の構造的基盤
- [[Vault分離と人間-AIの境界]] — 人間vault/AI vault分離の延長線上
- [[Wikiはワークショップ]] — Wikiを加工場として捉える
- [[LLM WikiテンプレートのOptionality]] — 外部ソースとの連携方法はユーザー任せ
