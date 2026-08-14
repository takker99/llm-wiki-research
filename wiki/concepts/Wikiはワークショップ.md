---
sources: [[2026-08-11 AIを使った知識マネジメント (villagepump)]], [[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]
tags: [template-design, llm-wiki-pattern]
---

# Wikiはワークショップ

LLM Wikiは「主宅地」（main repository）ではなく「ワークショップ」（処理場）であるという位置づけ。nishioの実践から導かれた。

## 含意

- **Wikiをsource of truthにしない**: より信頼できる情報源（raw/、外部ソース）と明瞭分離する。Wikiは動的な合成層として機能する
- **気軽に書き換え/削除できる**: source of truthがraw/にあるため、Wiki内容は安心して更新・整理・削除できる
- **株分け・移植・再構成が起きる**: Wikiが動的だからこそ、目的に応じた再編成が可能

## ページタイプ別の簡潔さ

| タイプ | 簡潔さ | 理由 |
|---|---|---|
| concepts/ | 強く簡潔（atomic） | リンクハブとして機能するため |
| entities/ | 簡潔 | 識別+最小限の文脈 |
| sources/ | 中程度 | 要旨を保持、原典は raw/ にある |
| analyses/ | 長め可 | 推論プロセスに価値があるため |

コンセプト部分だけ強く簡潔にしていき、それがリンクハブになっていく。

## nishioの考察

> 「『Wikiをsource of truthにしない』というポリシー、いい切り口。source of truthは勝手に書き換えてはいけない、Wikiにsource of truthがあるとWikiを書き換えていいのかどうかわからず、追記追記になってしまう」

これは[[Vault分離と人間-AIの境界|vault-separation]]（人間vaultとAI vaultの分離）の延長線上にあり、[[fact-wiki-separation]]（Wikiをsource of truthにしない）とも整合的。

## 関連概念

- [[3層アーキテクチャ]] — rawがsource of truth、wikiは派生
- [[Vault分離と人間-AIの境界]] — 外部主宅地があれば第三層不要
- [[株分け（kabuwake）]] — ワークショップから目的別に切り出す
- [[LLM Wikiは要約の改良版ではない]] — ワークショップ的性質の表れ
