---
status: tentatively-adopted
date: 2026-08-11
sources: "[[2026-08-11 Karpathy LLM Wiki Gist]]", "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]"
tags: [template-design, llm-wiki-pattern]
---

# ingestにおける編み込みの実際

ingest操作において「1ソースが10〜15ページに触れる」とは具体的に何を意味するか。当wikiの2回のingest実績とnishioの定義から得られた運用知見。

## 編み込みの構成要素

nishioの定式（`KarpathyのLLM Wiki`）:
> 1. raw/の新ファイルを読む
> 2. 既存wikiページと照合
> 3. 関連ページを更新 or 新規作成

つまり「編み込み」は新規ページ作成と既存ページ更新の**両方**から成る。Karpathy gistでも「writes a summary page」と「updates relevant entity and concept pages across the wiki」が併記されている。

## 当wikiの実績

### 1回目: Karpathy LLM Wiki Gist

| 種別 | 数 |
|---|---|
| sources（新規） | 1 |
| concepts（新規） | 17 |
| entities（新規） | 9 |
| 既存ページ更新 | 4 |
| index/log更新 | 2 |
| **計** | **33** |

→ 新規作成に偏り（26新規/4既存更新）、後日修正で11既存ページを追加更新。

### 2回目: Cosense議論 (villagepump + nishio 勉強会 + 2-hop)

| 種別 | 数 |
|---|---|
| sources（新規） | 2 |
| concepts（新規） | 23 |
| entities（新規） | 15 |
| 既存ページ更新 | 6（初回）→ 11（修正後） |
| index/log更新 | 2 |
| **計** | **53** |

→ 同様に新規偏重。修正後、11既存ページにクロスリンク追加。

## 教訓

1. **新規作成だけでは「孤立した要約の集合」になる。** 既存conceptページへのリンク追加（編み込み）があって初めてネットワークに統合される。
2. **ingest時に「まず既存wikiと照合」するステップを明示的に踏むべき。** 新規ページ作成に集中していると、この照合が抜けがち。
3. **logの `(touched N pages)` は新規+既存更新の合計。** 内訳の偏り（新規偏重/既存偏重）を自己検知できるとよい。
4. **nishioの「事前にやろうとしない」哲学**: ingest後の全ページ検証はしない。ただし偏りに気づいたら一括修正すればよい（事後修正コストが低い）。

## 波及の3層構造

nishioの `複数のLLM Wikiに共通のインプット` にあるMindTrellis論文ingestの分析:

1. **直接産物**: 新概念ページ + 新エンティティページ（構造的に増えたもの）
2. **カスケード**: 後続ingestが新概念を解釈の足場として利用（"structure-as-hypothesis"概念が図解/マルチエージェント/LLM Wiki設計の3ドメインに波及）
3. **メタ効果**: 既存ページの被リンク数増加、新しい比較軸の確立（fact-wiki-separation 15→22）

この3層すべてが「編み込み」の実体であり、層1だけでは不十分。

## 関連

- [[Ingest]] — 基本操作
- [[2026-08-11 Karpathy LLM Wiki Gist]] — 「10〜15ページ」の原典
- [[事前にやろうとしない運用哲学]] — 検証省略の哲学
- [[LLM Wikiは要約の改良版ではない]] — 編み込みの対極（単発要約）
