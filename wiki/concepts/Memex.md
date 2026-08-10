---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
tags: [template-design, llm-wiki-pattern]
---

# Memex

Vannevar Bushが1945年の論文 "As We May Think" で提唱した、個人用の知識保存・検索装置。KarpathyはLLM WikiをMemexの精神的後継として位置づけている。

## Bushのビジョン

- 個人がキュレーションする私的な知識ストア
- 文書間の「連想的な繋がり（associative trails）」が文書そのものと同じくらい価値を持つ
- 後に来たWebよりも、このビジョンに近い

## LLM Wikiとの接続

Karpathyの論点: Bushが解決できなかった「誰がメンテナンスをするのか」という問題をLLMが解決する。Wiki保守の退屈な部分（クロスリファレンス更新、要約の最新化、数十ページの一貫性維持）は、飽きず、忘れず、1パスで15ファイルに触れられるLLMに任せられる。

人間の仕事は: ソースのキュレーション、分析の方向付け、良い質問、そして「それが何を意味するか」を考えること。LLMの仕事はその他すべて。

## 関連概念

- [[連想トレイル]] — Memexの中核概念
- [[Vannevar Bush]] — 提唱者
- [[LLM Wiki]] — 現代的実装
- [[永続Wikiと複利効果]] — LLM Wikiの価値蓄積モデル
