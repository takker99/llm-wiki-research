---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
tags: [template-design, llm-wiki-pattern]
---

# Post-ingestレビューループ

Karpathyが自身のingest運用スタイルとして記述しているパターン。LLMがingest作業を完了した後、人間が結果をレビューし、強調点や方向性について追加のガイダンスを与えるステップ。

## Karpathyの記述

> "I prefer to ingest sources one at a time and stay involved — I read the summaries, check the updates, and guide the LLM on what to emphasize."

つまり:
1. LLMがingestを実行（sources/ページ作成、concepts/entities/更新）
2. 人間が要約を読み、更新を確認する
3. 人間が「ここをもっと強調して」「この観点が足りない」とLLMをガイドする
4. LLMがフィードバックに基づいて修正する

## Ingestフローにおける位置

- Pre-ingestディスカッション: 「3-5つの要点を議論、何を重視するか聞く」→ 方向性の初期設定
- Post-ingestレビュー: 「要約を読み、更新を確認し、強調点をガイド」→ 結果の品質チェックと微調整

この2段階の人間関与がKarpathyの推奨する「関与し続ける（stay involved）」スタイルの具体化。

## 当wikiでの状況

⚠ Contradiction: 当wikiのAGENTS.md（[[Ingest]]参照）にはPost-ingestレビューループが明示されていない。Pre-ingestディスカッション（step 2）のみ。この乖離は2026-08-11時点で認識されており、対応は後回し（`wiki/log.md`参照）。

## 関連概念

- [[Ingest]] — このパターンが属する操作
- [[バッチIngest]] — 対極のスタイル（監視を減らす）
- [[LLM WikiテンプレートのOptionality]] — このような運用スタイルの選択をテンプレートに含めるかどうか
