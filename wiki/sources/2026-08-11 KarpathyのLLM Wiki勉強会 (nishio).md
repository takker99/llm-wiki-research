---
raw: raw/nishio-KarpathyのLLM_Wiki勉強会.md
source_url: https://scrapbox.io/nishio/KarpathyのLLM_Wiki勉強会
accessed: 2026-08-11
tags: [template-design, cosense, llm-wiki-pattern]
---

# 2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)

nishioによるKarpathyのLLM Wiki勉強会の講義資料。20+ Wikiの実運用データに基づく体系的な知見がまとめられている。

## 要点

1. **Ingest/Query/Lint の詳細**: Karpathy gistの各操作を翻訳＋nishioの追加ルール付きで解説。1ソースが10〜15ページに触れることの意味、file-backの3パターン（人間指示/AI提案/人間が問う）、Lintが成長方向の提案まで行うこと（[[Ingest]]、[[QueryとFile-back]]、[[Lint]]）。

2. **「事前にやろうとしない」運用哲学**: ingest検証の省略、Wiki配分は迷ったら両方、凍結は自然停止。成立条件は事後修正コストの低さ（[[事前にやろうとしない運用哲学]]）。

3. **Wikis-as-personas**: 各Wikiが仮想的人格として振る舞い、同じ問いに対しても自分の目的を通して読み替える。複数Wiki間の情報交換・手動orchestratorパターン（[[Wikis-as-personas]]）。

4. **研究目的Wikiとプロジェクト目的Wiki**: 前者は抽象化・整合性のあるネットワークが目的、後者は具体レイヤーに接続し作業知識をfile back。抽象度・Q層・attribution管理のパターンが異なる（[[研究目的Wikiとプロジェクト目的Wiki]]）。

5. **raw-source kabuwake**: 既存wikiページをコピーせず、raw/原資料だけを新wikiに複製して再ingestする手法。broken wikilinkが構造上0件。page-source kabuwakeより優れる（[[株分け（kabuwake）]]）。

6. **実運用データ（20+ Wiki）**: 対象固定Wikiは1日で立ち上げ凍結、個人系が最も価値を出す、同時activeは6件のみ、188ページでindexは約12K tokens（Opus 4.7の1.2%）（[[LLM Wikiの実運用データ]]）。

7. **Coding Agentの歴史とLLM Wikiの位置づけ**: Agent Skillsを一般化したものとしてLLM Wikiを位置づける。why/what/howの3層で知識を外部化（[[Coding Agentの歴史とLLM Wikiの位置づけ]]、[[Wiki駆動開発]]）。

8. **LLM Wikiがなんのためのものか**: 文脈情報をファイル化しindexで分割、AI自身がメンテナンスする仕組み。これがLLM Wikiの本質定義（[[LLM Wikiの本質定義]]）。

9. **家計Wiki・猫Wiki・dd2030-wikiの具体的事例**（[[家計LLM-wiki]]、[[猫LLM Wiki]]、[[dd2030-wiki]]）

## 触れている概念・実体

- 概念: [[事前にやろうとしない運用哲学]] / [[Wikis-as-personas]] / [[研究目的Wikiとプロジェクト目的Wiki]] / [[株分け（kabuwake）]] / [[LLM Wikiの実運用データ]] / [[Coding Agentの歴史とLLM Wikiの位置づけ]] / [[Wiki駆動開発]] / [[LLM Wikiの本質定義]] / [[コンテキスト外部化の歴史]] / [[AIによるingest停止判断]]
- 実体: [[Andrej Karpathy]] / [[家計LLM-wiki]] / [[猫LLM Wiki]] / [[dd2030-wiki]] / [[ブロードリスニング本Wiki]] / [[Karwi]] / [[Devin]] / [[Agent Skills]] / [[Codex Mobile]] / [[注釈駆動Wiki]] / [[LENCHI]] / [[Kozaneba]] / [[ConnectingDotsシステム]] / [[MindTrellis]]
