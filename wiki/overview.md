# Overview

このLLM Wikiは、**LLM Wikiテンプレートの研究・開発**を目的とする研究wikiです。
ここに書かれている構造は研究対象（仮説の実装）であり、テンプレート設計の主張は
[[テンプレート草案ver.1]]に集約されています。

## スコープ

KarpathyのLLM Wikiパターン、nishioの実践知（20+ Wikiから得た知見）、
villagepumpコミュニティの議論をingestし、以下の問いに答えていく：

- 自分のwiki群に提供すべきテンプレートの中身は何か？ 何をユーザー任せにするか？
- AGENTS.mdには何を書くべきか？何を書かないべきか？
- ディレクトリ構成のベストプラクティスは？
- 配布形式はどうするか？（`template/` ディレクトリ / 別repo / npx initコマンド？）
- AGENTS.mdはどこまで薄くできるか？（このwiki自身が実験台）

設計対象は作者本人のwiki群（2026-09-25再定義。詳細は [[このWikiの目的と研究課題]]）。

## 現状

- `template/` v0.1実装済み（M1達成、2026-08-14）。配布形式・検証方針の決定は
  [[配布形式の決定とテンプレートの動機]]、claimsの追跡は [[claims対応表]]
- M2進行中: 下流wiki 2件がtemplateから立ち上がりフィードバックを取り込み済み。
  M2は2026-09-25に「この研究wiki以外のwiki」へ再定義（外部=他人ではなくpurpose違いで足りる）
- ソースの一覧と研究の進捗は [[index]] と このWikiの目的と研究課題 を参照

## 次のステップ

- [x] Karpathy gist のingest（→ [[2026-08-11 Karpathy LLM Wiki Gist]]、concepts/多数、entities/多数）
- [x] Cosense議論のingest（→ [[2026-08-11 AIを使った知識マネジメント (villagepump)]]、[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]、concepts/多数、entities/多数）
- [x] template/ v0.1実装（M1）
- [ ] M2: この研究wiki以外のwikiをtemplateで立ち上げ・育て、このrepoが評価（下流wiki 2件で進行中）