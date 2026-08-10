---
sources: "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]"
---

# 複数のLLM Wikiに共通のインプット

nishioが発見した、同じ資料を複数のLLM Wikiに投入した時の現象。[[Wikis-as-personas]]の具体的実証。

## 実験

MindTrellis論文を3つのWiki（LLM WikiについてのWiki / ConnectingDotsシステムのWiki / LENCHI Wiki）にingestし、同じ質問「どんな変化があった？」を投げた。

## 結果: 各Wikiの回答の違い

- **Wiki 1（メタwiki）**: 新概念structure-as-hypothesisの抽出、Kozaneba/MindTrellis/ConnectingDotsの三角測量
- **Wiki 2（ConnectingDots）**: 自システムのpositioningの変化、独自のanti-misattribution規律、AI役割タクソノミ
- **Wiki 3（LENCHI）**: 本書のプロジェクト構造の変化、Q番号付きバックログへの追加

同じ語「変化」が3つの違う対象を指している。これがWiki=人格化の最も基本的な現れ。

## 差分の構造

- 各Wikiは質問を自分の目的を通して読み替える
- 抽象度の階層が異なる: 転移可能な抽象 / スキーマ拡張の具体 / 個別意思決定
- 独自のartifact（Qバックログ等）が回答形式に影響

## 関連概念

- [[Wikis-as-personas]] — この現象の理論化
- [[株分け（kabuwake）]] — raw-source kabuwakeとの関係
- [[研究目的Wikiとプロジェクト目的Wiki]] — Wikiタイプによる回答の違い
