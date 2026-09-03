---
status: hypothesis
date: 2026-09-03
tags: [template-design, llm-wiki-pattern, knowledge-graph, main-value]
sources:
  - "[[raw SSOT原則への根本検証]]"
  - "[[3層アーキテクチャ]]"
  - "[[永続Wikiと複利効果]]"
  - "[[連想トレイル]]"
  - "[[繋げる力]]"
  - "[[LLM Wikiの作文リスク]]"
  - "[[rawディレクトリの取り扱い]]"
  - "[[理解のボトルネック]]"
  - "[[LLM Wikiは要約の改良版ではない]]"
  - "[[テンプレート草案ver.1]]"
  - "[[claims対応表]]"
  - "[[2026-08-11 Karpathy LLM Wiki Gist]]"
  - "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]"
---

# LLM Wiki の main value

LLM Wiki パターンにおいて中心的な価値（main value）は何か。
結論: **knowledge network (knowledge graph) である**。raw/ SSOT は補助装置。

## 結論

LLM Wiki の価値は **wiki/ の中で育つ knowledge network** にあり、raw/ SSOT ではない。
これは Karpathy の元設計・nishio の実装・全パイロットの観察・ユーザーの直感の全てが支持する。

- **value**: knowledge network（リンクで繋がり、合成され、探索可能になる知識の網）
- **補助装置**: raw/ SSOT・3層構造・Schema — value を**支える**が価値そのものではない

支えがなくても価値は成立しうる（純 file-back wiki も network として機能する）が、
支えがあると信頼性・検証可能性が増す。**正しい問いは「raw/ SSOT は必要か」ではなく「コストと利益は釣り合うか」**。

## Karpathy の元設計での位置づけ

`raw/karpathy-llm-wiki-gist.md` を精読すると、価値の中心として3回繰り返される主張:

- "compounding artifact"（蓄積する複利装置）
- "cross-references are already there"（相互参照が既に存在している）
- "synthesis already reflects everything"（合成が全てを反映する）

**raw/ に「価値の中心として」の言及は一度もない**。raw/ は "your curated collection... immutable" として
3層構造の **第1層を定義** するが、価値の説明文には現れない。

### 「raw/ が唯一の source」は派生解釈

Karpathy の gist で raw/ に言及しているのは3箇所のみ（line 29 ほか）:

> "Raw sources — your curated collection... These are immutable — the LLM reads from them but never modifies them. **This is your source of truth.**"

書かれていること: raw/ は immutable、source of truth、3層構造の第1層。
**書かれていないこと**: 「raw/ が wiki の唯一の source」。

逆に Karpathy は file-back を**明示的に 2 つ目の source として位置付け**ている
（gist line 39）:

> "good answers can be filed back into the wiki as new pages... your explorations compound in the knowledge base **just like ingested sources do**."

→ ユーザー指摘の「query 情報は明示せず wiki に入れている」は**設計と整合する**。矛盾ではない。

## nishio の態度変遷（再評価）

`raw/nishio-LLM_Wikiが何かのためのものか.md`・`raw/nishio-KarpathyのLLM_Wiki勉強会.md` 等の時系列から:

| 段階 | 時期 | 態度 | 観察源 |
|---|---|---|---|
| 第1 | 2026-04 | raw/ を source of truth として厳格視（Karpathy 直輸入） | 初期 nishio cosense・gist運用 |
| 第2 | 2026-04-26〜05 | 階層化・分散化（grasp の SQLite-authority、外部主宅地議論） | grasp 実装 |
| 第3 | 2026-06〜 | 「再生成可能なら gitignore 可」原則 | about-nishio の `external_brain_in_markdown` |

**nishio は raw/ を捨てたのではない**。役割を **2 種類に分けた**:

- **スナップショット型**: 引用時の固定アーカイブ、append-only、source of truth として扱う
- **ライブ型**: gitignored の clone、再生成可能、単なる参照層

about-nishio の 24,000 ページ（external_brain_in_markdown）はライブ型の代表例。
.gitignore コメント: "Large source corpus (**regeneratable** via `git clone ...`)"
→ 再生成可能を根拠に gitignore。

## パイロット実装での重心

| 実装 | main value | raw/ の扱い |
|---|---|---|
| about-nishio | 個人 mature wiki、knowledge network + 読書ログ | ライブ型 + bundle |
| grasp | code+wiki ハイブリッド、SQLite-authority | gitignored |
| AMME-2026S-report | 短期研究レポート（100ページ、知識の網） | frontmatter 8% のみ |
| BDL-2026S | 講義 knowledge network（330p、概念 rename-mapping） | gitignored（推定） |
| delite | 短期完了 + Quartz 公開 knowledge network | CLAUDE.md のみ |
| SMS-2026S-report | research report + 参照数分割 | gitignored |
| Microsoft llmwiki | 操作層のソフトウェア実装、weighted query (title 3x/summary 2x/body 1x) | 3層独立収束 |

全て knowledge network / graph を value center にしている。raw/ SSOT 中心の実装は存在しない。

## raw/ SSOT の 4 機能（補助装置として）

raw/ が LLM Wiki に**実際に**提供している機能を 4 つに分解:

| 機能 | 内容 | 重要度 | main value との関係 |
|---|---|---|---|
| **検証可能性** | wiki の事実が争われたら raw/ まで遡る | 中 | 補助 — knowledge network の**信頼性を増す** |
| **作文リスク防衛** | LLM の虚偽ソース作文を防ぐ | 高（防御機能） | 補助 — network の**完全性を保護** |
| **ライセンス・帰属台帳** | 論文 PDF 転載・private 情報管理 | 中 | 補助 — 法的・倫理的**境界の管理** |
| **LLM 範囲境界** | LLM がソースを「改善」する誘因への物理境界 | 中 | 補助 — **権限マップ** |

最も重要な機能2（作文リスク防衛）は、**sources frontmatter の `raw:` 必須化だけで大部分は防げる**。
3層構造を厳密に守る必要はなく、sources ページの frontmatter 検証 + lint チェックで実用上十分。

## 正しい問い

「raw/ SSOT は LLM Wiki に必要か?」ではなく
**「raw/ SSOT のコストと利益は釣り合うか?」** が正しい問い。

- **コスト**: private 情報混入・git log 残留・論文転載・サイズ・gitignore 起因の損失（2026-08-11 の 6ファイル誤削除）
- **利益**: 検証可能性・作文リスク防御・ライセンス管理

**バランスの結論**（[[rawディレクトリの取り扱い]] で既に整理済み）:

- **追跡デフォルト** が妥当（`raw/*` を ignore しない）
- 例外: 「公開予定 && 転載不可ソース → `raw/*` ignore + `!raw/manifest.md`」
- コーパスモード（ライブ型）は応用編として明示提供（条件付き正当化）

## 草案 ver.1 への影響

[[claims対応表]] の claim#1（3層アーキテクチャ）と claim#6（1ソースで10-15ページに触れる）に対する影響:

- **claim#1**: 「3層にする」と書く規範は維持。**「raw/ SSOT が価値の中心」ではない**ことを理解した上で規範化する
- **claim#6**: knowledge network モデルでも整合。1 raw ソースが複数 concept を生む = network の**種まき**として再解釈

新規 claim 候補:

- **「LLM Wiki の main value は knowledge network である」** — 記述的検証: Karpathy gist + nishio 勉強会 + 全パイロット実装 + ユーザー直感。規範的決定: ①実証済み知見として草案 ver.2 に追加検討

## 関連

- [[raw SSOT原則への根本検証]] — 本ページの根拠となる根本検証（605行）
- [[3層アーキテクチャ]] — raw/ を3層構造の第1層として定義（補助装置の物理的配置）
- [[rawディレクトリの取り扱い]] — raw/ の運用方針（gitignore・コーパスモード・入場時の誓約）
- [[永続Wikiと複利効果]] — knowledge network が複利を生む仕組み
- [[連想トレイル]] — wikilink による現代的実装
- [[繋げる力]] — 複数ソース横断で概念ページが組み上がる価値
- [[LLM Wikiの作文リスク]] — raw/ が防衛線として機能する補助機能
- [[理解のボトルネック]] — 知識の外部化が価値を支える構造
- [[LLM Wikiは摘要の改良版ではない]] — 圧縮ではなく足場の議論（network の質）
- [[テンプレート草案ver.1]] — 検証対象の設計
- [[claims対応表]] — 文種4分類での位置付け

## メタ

- このページは [[raw SSOT原則への根本検証]] の統合的結論として 2026-09-03 に作成。
- ユーザー指摘「knowledge graph の側面のほうが大事に思える」が議論の起点。
- 旧来の暗黙の前提（raw/ SSOT = main value）は**過剰解釈**であり、本ページで明文化。