---
sources: "[[2026-08-11 AIを使った知識マネジメント (villagepump)]]"
tags: [template-design, llm-wiki-pattern]
---

# ChatGPT ProとLLM Wikiの併用

nishioの実践する、ChatGPT Pro（Deep Research）とLLM Wiki（Claude Code）の使い分けパターン。

## 使い分け

- **ChatGPT Pro**: クラウド側でWebSearch/PDFダウンロード/サーベイを実行し、Markdown1枚のレポートを「こちら側」に渡す。中間マテリアルは捨てる。
- **LLM Wiki（Claude Code）**: ローカルファイルシステム上でDeep Research相当のことを行い、結果が構造を持ったWikiになる。必要な論文を改めて取得してingest。

## 併用パターン

1. ChatGPT Proのサーベイ結果をingest
2. 参照先の論文をClaude Codeが取得して再ingest
3. Wikiの知識構造が育ってから再読すると新たな発見がある

## 設計含意

> 「クラウドの向こう側」で処理してレポートだけ渡すのと、「こちら側」でWikiとして蓄積するのは補完関係にある

## 関連概念

- [[LLM Wikiは要約の改良版ではない]] — 要約レポートとWikiの違い
- [[RAG]] — Deep Researchと対比される技術
