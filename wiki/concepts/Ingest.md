---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
tags: [template-design, llm-wiki-pattern]
---

# Ingest

LLM Wikiの3基本操作の1つ。新しいソースをraw/から読み取り、wikiに統合するプロセス。

## Karpathyの定義するフロー

1. LLMがソースを読む
2. 人間と重要なポイントを議論する
3. wikiに要約ページを書く（sources/）
4. indexを更新する
5. 関連する実体・概念ページをwiki全体にわたって更新する
6. ログにエントリを追記する

1ソースが10〜15ページに触れることもある。これは孤立した要約を作るのではなく、既存ネットワークに織り込む作業だから。

## 運用スタイルのバリエーション

Karpathy自身の好み:
- ソースを1つずつingestし、関与し続ける
- 要約を読み、更新をチェックし、何を強調するかLLMをガイドする（[[Post-ingestレビューループ]]）

代替:
- 多数のソースを一度に[[バッチIngest]]し、監視を減らす
- どちらのスタイルを取るかはユーザーが決め、Schemaに明文化する

## 当wikiでの実装

当wikiのAGENTS.mdでは、Karpathyのフローを以下のように具体化している:
1. `raw/` の新ファイルを読む
2. 人間と3-5つの要点を議論、何を重視するか聞く
3. sources/ページ作成、concepts/・entities/更新、矛盾の明示、新規概念ページ作成
4. index.md更新
5. log.md追記

⚠ Contradiction: 当wikiのAGENTS.mdには[[Post-ingestレビューループ]]（作成後の人間チェック＋再調整）が明示されていない。Karpathyの記述にはある。

## 関連操作

- [[QueryとFile-back]] — もう1つの知識流入経路
- [[Lint]] — 健全性チェック
- [[IndexとLog]] — ingest時に更新される2つの特殊ファイル
