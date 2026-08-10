---
sources: "[[2026-08-11 AIを使った知識マネジメント (villagepump)]]", "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]"
tags: [template-design, llm-wiki-pattern]
---

# AIによるingest停止判断

LLM Wikiの運用において、AIが自ら外部サーベイのingest停止を判断した事例。nishioのLLM Wiki自体のLLM Wikiで発生。

## 事例

- LLM Wikiを知ったとき、まずGrokでKarpathyの投稿に対する反応をかき集めてingest
- 1週間後、2週間後にも追加で外部サーベイをingest
- AIの判断: 「あんまり新規の情報が増えないから外サーベイはもう要らない、あなた個人の実験からの知見の方がウェイトが大きい」
- 以降、AIの自己評価に従って外部サーベイのingestを停止

## 含意

- Lintが「成長方向の提案」まで行う（Karpathyの定義）の具体的実現
- AIがソースの質を評価し、取捨選択を提案できる
- 質の低いものでWikiを埋めるとよくない（コンテキストの有限性）

## 関連概念

- [[Lint]] — ingest停止判断の基盤となる操作
- [[LLM Wikiの実運用データ]] — この事例が含まれる20件の観察
- [[事前にやろうとしない運用哲学]] — 凍結を自然に任せる発想と共通
