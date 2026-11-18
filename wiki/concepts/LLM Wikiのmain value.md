---
summary: "LLM Wikiの価値の中心はknowledge network（knowledge graph）。raw/ SSOT・3層・Schemaは価値を支える補助装置で、価値そのものではない"
status: hypothesis
date: 2026-09-03
tags: [template-design, llm-wiki-pattern, knowledge-graph, main-value]
sources:
  - "[[raw SSOT原則への根本検証]]"
  - "[[rawディレクトリの取り扱い]]"
  - "[[claims対応表]]"
---

# LLM Wiki の main value

LLM Wiki の中心的な価値（main value）は、**wiki/ の中で育つ knowledge network（knowledge graph）** である。raw/ SSOT は価値そのものではなく、network の信頼性を支える補助装置である。

- **value**: リンクで繋がり、合成され、探索可能になる知識の網
- **補助装置**: raw/ SSOT・3層構造・Schema。value を支えるが、value の中心ではない
- 支えがなくても純 file-back wiki は network として機能する。支えがあると信頼性・検証可能性が増す

## 根拠

Karpathy gist の価値主張、nishio の3段階の態度変遷、パイロット7実装の観察、raw/ の6機能分解は [[raw SSOT原則への根本検証]] に集約している。要点:

- Karpathy が価値として繰り返すのは compounding artifact・cross-references・synthesis で、raw/ は価値説明に登場しない
- nishio は raw/ を捨てたのではなく、スナップショット型（source of truth）とライブ型（再生成可能な参照層）に役割を分けた
- 全パイロット実装で knowledge network / graph が価値の中心にある
- raw/ の機能（検証可能性・作文リスク防衛・ライセンス・LLM範囲境界・素材保管・コーパスモード）は補助装置として整理できる

## 正しい問い

「raw/ SSOT は必要か」ではなく、**「raw/ SSOT のコストと利益は釣り合うか」** が正しい問い。高信頼性が critical な領域では正当化され、低コスト・低利益な領域では不要になる。バランスの結論は [[rawディレクトリの取り扱い]] を参照。

## テンプレートへの含意

- 3層構造は維持するが、「raw/ SSOT が価値の中心」という前提は置かない
- 「1ソースで10-15ページに触れる」は、network の種まきとして再解釈する
- 新規 claim「LLM Wiki の main value は knowledge network である」は [[claims対応表]] の claim#10 として追跡する

## 関連

- [[raw SSOT原則への根本検証]] — 根拠となる調査レポート
- [[rawディレクトリの取り扱い]] — raw/ のコストと利益、追跡デフォルトの判断
- [[3層アーキテクチャ]] — raw/ を3層の第1層として定義
- [[永続Wikiと複利効果]] — knowledge network が複利を生む仕組み
- [[連想トレイル]] — wikilink による現代的実装
- [[繋げる力]] — 複数ソース横断で概念ページが組み上がる価値
- [[LLM Wikiの作文リスク]] — raw/ が防衛線として機能する補助機能
- [[理解のボトルネック]] — 知識の外部化が価値を支える構造
- [[LLM Wikiは要約の改良版ではない]] — 圧縮ではなく足場の議論
- [[テンプレート草案ver.1]] — 検証対象の設計

## メタ

- 2026-09-03に [[raw SSOT原則への根本検証]] の統合的結論として作成。2026-11-17に根拠の重複を分析ページへ委譲し、conceptとして圧縮した。
