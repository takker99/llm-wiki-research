---
status: hypothesis
date: 2026-09-03
tags: [template-design, raw, knowledge-graph, main-value, provenance, raw-ssot-revisited]
sources:
  - raw/karpathy-llm-wiki-gist.md
  - "[[2026-08-11 Karpathy LLM Wiki Gist]]"
  - "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]"
  - "[[2026-08-11 AIを使った知識マネジメント (villagepump)]]"
  - "[[2026-08-11 KarpathyのLLM Wikiを1ヶ月運用してわかった繋げる力 (tsurubee)]]"
  - "[[2026-08-14 Cosenseのリンク概念 (villagepump+nishio)]]"
  - "[[2026-08-14 赤リンクとLLM Wiki (nishio+villagepump)]]"
  - "[[3層アーキテクチャ]]"
  - "[[rawディレクトリの取り扱い]]"
  - "[[LLM Wikiの作文リスク]]"
  - "[[永続Wikiと複利効果]]"
  - "[[Wikiはワークショップ]]"
  - "[[fact-wiki-separation]]"
  - "[[理解のボトルネック]]"
  - "[[読まれなくてよい中間産物]]"
  - "[[注意の足場]]"
  - "[[LLM Wikiは要約の改良版ではない]]"
  - "[[コンテキスト外部化の歴史]]"
  - "[[連想トレイル]]"
  - "[[テンプレート草案ver.1]]"
  - "[[claims対応表]]"
  - "[[配布形式の決定とテンプレートの動機]]"
  - "[[リポジトリ分析 llm-wiki-about-nishio]]"
  - "[[リポジトリ分析 grasp]]"
  - "[[リポジトリ分析 AMME-2026S-report]]"
  - "[[パイロット分析 横断所見]]"
  - "[[Microsoft llmwiki]]"
---

# raw/ SSOT原則への根本検証

ユーザー（2026-09-03提起）の根本的疑問 — 「provenance 原則は Karpathy 元設計と整合するか。raw/ の存在理由は何か。LLM Wiki の main value は raw/ SSOT か、knowledge graph か」— に対する subagent 相談の統合報告書。

形式論争（frontmatter の書き方、AGENTS.md の長さ等）には立ち入らず、**本質・価値・位置づけ** レベルの議論に集中する。

---

## 1. Karpathy の元設計における raw/ の位置づけ

### 1.1 raw/ SSOT の明示度

Karpathy の gist（`raw/karpathy-llm-wiki-gist.md`）の関連箇所は3箇所のみ:

> "**Raw sources** — your curated collection of source documents. Articles, papers, images, data files. **These are immutable — the LLM reads from them but never modifies them. This is your source of truth.**" (line 29)

> "There are three layers:" (line 27)

> "The wiki is a persistent, compounding artifact." (line 13)

**書かれていること**:
1. raw/ は **immutable**（LLM は読むだけで変更しない）
2. raw/ は **source of truth**
3. 3層構造（raw / wiki / Schema）

**書かれていないこと**（過剰解釈の温床）:
1. raw/ が wiki 全体の「唯一の source」
2. raw/ が wiki の価値の中心

**「source of truth」の正確な意味**: Karpathy は「source of truth」という語を **生ドキュメントの不変性** を説明するために使しており、**wiki 情報の唯一の供給源** を意味していない。むしろ、すぐ後で「query の file-back」が wiki を育てると書いている。

### 1.2 Query 情報の wiki 取り込み — 設計上は2つ目の source として明示

gist の Query セクション（line 39）:

> "The important insight: **good answers can be filed back into the wiki as new pages.** ... This way **your explorations compound in the knowledge base just like ingested sources do.**"

ここが **ユーザー指摘の核心** に対する直接回答である。Karpathy は明示的に:
1. Query 回答を wiki に file-back する
2. それらは **ingested sources と同じ複利効果** で knowledge base を育てる

つまり **Karpathy の元設計には2つの source がある**:
- **raw/（immutable な生ドキュメント、source of truth として扱う）**
- **file-back された派生知見（wiki の複利成長を支える）**

両者は **性質が異なる**（生ドキュメント vs 派生知見）が、どちらも wiki を育てる source として等価に扱われている。

### 1.3 「raw が唯一の source」は派生解釈

「raw/ が唯一の source」という主張は **gist に書かれていない**。以下の連想から派生した過剰解釈である:

1. raw/ は immutable → 「他の場所にも情報源があってはならない」と読み替え
2. raw/ は source of truth → 「source of truth = 唯一の source」と読み替え
3. 3層構造 → 「3層以外は存在しない」と読み替え

**正しい読み**: raw/ は「LLM が変更せず参照する不変の生ドキュメント層」であり、wiki の他の source（file-back）を排除する規定ではない。**この過剰解釈を撤回すると、ユーザーの「query 情報は明示せずに wiki に入れている」指摘は設計と整合する。**

### 1.4 派生解釈が広まった経路の推定

当 wiki 内でも [[3層アーキテクチャ]] は Karpathy の定義を引用しているが、その説明は:

> "raw/（不変のソース）→ wiki/（LLM管理のMarkdown）→ Schema（AGENTS.md）の基本構造。不変性は入場時の誓約へ再解釈"

「不変性は入場時の誓約へ再解釈」は当 wiki の発展であり、Karpathy の原文にはない再解釈である。これは「過剰な厳密さ」を自覚的に弱めた健全な方向だが、**過剰な厳密さの上限値（=raw  SSOT を wiki 全体の唯一 source と扱う）を前提にして初めて意味を持つ議論だった**。

---

## 2. nishio の raw/ への態度変遷

### 2.1 3段階の態度変遷（時系列）

#### 第1段階: 初期（2026-04、Karpathy 直輸入）

- 2026-04-17（最初のページ）: 「raw/ に投入」（nishio-KarpathyのLLM_Wiki L43）
- 2026-04-22: 「ポケット一つ原則」、種→カオス→株分け（villagepump L107-110）
- 2026-04-30 (猫 Wiki): 「生データは失われない安心感」「何も消えない」（勉強会 L375）

→ **この時点では raw/ を source of truth として厳格視**。

#### 第2段階: 中期（2026-04-26 〜 2026-05、source of truth の外部化）

- 2026-04-26: 「Wiki を source of truth にしない」「外部の主宅地（人間の Cosense/グループウェア）とは境界で区別」（villagepump L237-247）— **source of truth が wiki の外にも存在しうる** と認識
- 2026-05 (grasp 実践): **SQLite-authority パターン** — Markdown は projection、SQLite が authority → **raw/ の役割を Markdown wiki の外** に取り出す構造的決定
- 2026-05-15 (dd2030-wiki): 「リポジトリを raw の中に clone して分析させた」 → **raw/ の中身が文書から clone されたリポジトリに拡張**

→ **source of truth の階層化・分散化** を認識。

#### 第3段階: 現在（2026-06以降、コーパスモードの導入）

- 2026-06 (about-nishio): `raw/external_brain_in_markdown` を **gitignored で運用**。コメント「Large source corpus (**regeneratable**)」（`rawディレクトリの取り扱い` L31-33）
- 当 wiki での理論化: 「コーパスモード（ライブ型の条件付き正当化）」(`rawディレクトリの取り扱い` L128)

→ **「再生成可能なら gitignore 可」** という新原則の確立。raw/ は「source of truth」ではなく**「再生成可能な参照層」** として再定義。

### 2.2 態度変遷の本質: 「捨てた」ではなく「役割を変えた」

nishio は raw/ を **捨てたのではない**。**役割を変えた**:

| 時期 | raw/ の役割 |
|---|---|
| 初期 | source of truth（生ドキュメント） |
| 中期 | 参照可能な生ドキュメント層（ただし wiki 外にも source of truth 可） |
| 現在 | 2 種類（スナップショット型=source of truth として + ライブ型=再生成可能な参照層） |

**重要な点**: 第3段階で現在も、**スナップショット型 raw/**（citation 時の固定スナップショット、append-only）は source of truth として扱われている。**ライブ型 raw/**（gitignored の clone、再生成可能）は source of truth ではなく**単なる参照層**。

### 2.3 gitignore 採用の理由（複合）

`rawディレクトリの取り扱い` の整理から:

1. **再生成可能性**: 大規模コーパスは clone すれば再取得できる → git にコミットする必要がない
2. **サイズ**: 24,000 ページ 規模の external brain をコミットするのは現実的でない
3. **private 情報**: 個人データ・機密情報を git log に残せない
4. **著作権**: 論文 PDF の転載問題（[[rawディレクトリの取り扱い]] L19）

**核心**: ライブ型 raw/ の **source of truth 性は不要**。再生成可能なら**ライブ URL + commit hash + ハッシュ** で足りる。

---

## 3. raw/ の存在理由の再評価

raw/ が LLM Wiki に **実際に** 提供している機能を6つに分解する:

### 機能1: 検証可能性

- **内容**: wiki の事実が争われたら raw/ まで遡って検証できる
- **典拠**: [[3層アーキテクチャ]] L18, [[LLM Wikiの作文リスク]], `rawディレクトリの取り扱い`
- **代替手段**: ハッシュ（再取得）+ URL（ライブソース）+ コミットメッセージ
- **実測**:
  - Karpathy/AMME/about-nishio/grasp: raw/ を前提
  - AMME は raw 5 ファイルと極小 → 検証機能の実用性は小さい
  - grasp のライブ型 → 再取得 + ハッシュ照合で代替可能

### 機能2: 作文リスクの防衛線

- **内容**: wiki ページに存在しないソースを LLM が作文するリスクを防ぐ
- **典拠**: [[LLM Wikiの作文リスク]]
- **代替手段**: sources ページの frontmatter `raw:` 必須化、lint による raw/ 参照チェック
- **実測**:
  - 当 wiki の事件（2026-08-11、overview に7件列挙→実在1件のみ）は LLM の作文ではなくユーザー誤削除だが、**リスク形態は同型**
  - template の lint.sh には raw/ 検証なし（研究 repo 版で削除済み）→ template では防衛線が弱い
  - **ただし**: sources frontmatter `raw:` 必須化だけでも大部分は防げる（template で実装済み）

### 機能3: ライセンス・帰属の台帳

- **内容**: 論文 PDF・private 情報の転載問題を制御する
- **典拠**: `rawディレクトリの取り扱い` L19「論文 PDF をそのまま入れると転載になる（著作権）」
- **代替手段**: sources ページの frontmatter `source_url`, `accessed:` だけ
- **実測**: template の sources ページ frontmatter で `raw:` 必須 + `source_url:` 任意 — **十分機能している**

### 機能4: LLM 範囲境界の宣言

- **内容**: LLM がソースを「改善」する誘因への物理的・構造的境界
- **典拠**: `rawディレクトリの取り扱い` L108「LLM がソースを『改善』したくなる誘因へのカテゴリ境界」
- **代替手段**: AGENTS.md での禁止事項記述
- **実測**: AGENTS.md 指示だけでも一定程度機能するが、LLM は禁止を忘れうる。**物理的・構造的な境界がより強力**

### 機能5: ingest のための素材保管

- **内容**: ingest 時に raw/ から読み込む（物理的にそこにある）
- **典拠**: ingest SKILL.md L19「ソースを読む」が raw/ のファイルを前提
- **代替手段**: ライブ URL、引用、コピー & ペースト
- **実測**: 実用上 raw/ は便利だが**必須ではない**。ライブソースからの直接読み込みは AMME や grasp で機能している

### 機能6: コーパスモード（ライブ型、再生成可能）

- **内容**: 大規模な参照用コーパスを保持（再生成可能を条件に）
- **典拠**: `rawディレクトリの取り扱い` L128-138「コーパスモード」
- **代替手段**: ライブソース + 検索インデックス
- **実測**: about-nishio のみ。再生成可能な大規模データでのみ正当化される

### 機能の重要度ランキング

私の評価:

| 順位 | 機能 | 重要度 | 代替可能性 |
|---|---|---|---|
| 1 | 検証可能性 | 中 | ハッシュ + URL で代替可 |
| 2 | 作文リスク防衛 | 高（ただし sources frontmatter で大部分カバー） | frontmatter 必須で代替可 |
| 3 | ライセンス・帰属台帳 | 中 | sources frontmatter で十分 |
| 4 | LLM 範囲境界 | 中 | AGENTS.md 指示で代替可（弱） |
| 5 | ingest 素材保管 | 低 | ライブソース可 |
| 6 | コーパスモード | 低（特殊用途） | 検索インデックス可 |

### 「再生成可能なら gitignore 可」の含意

`rawディレクトリの取り扱い` が提示した原則:

> 「再生成可能なら gitignore 可」

これは raw/ を **「source of truth として扱うかどうかの問い直し**」 を含意する。raw/ の本質は:
- **不変な生ドキュメントの存在**（スナップショット型）
- **再生成可能な参照層**（ライブ型）

の 2 種類であり、**どちらも「wiki 全体の source of truth」ではない**。wiki 全体の source of truth は **wiki/ + file-back の蓄積** である。

---

## 4. LLM Wiki の main value は何か

### 4.1 判断軸

**判断軸A: Karpathy の意図** — 彼は何を最も価値があると言ったか

gist で **3 回繰り返される価値主張**:
1. "the wiki is a **persistent, compounding artifact**" (line 13)
2. "**The cross-references are already there. The contradictions have already been flagged. The synthesis already reflects everything you've read.**" (line 13)
3. "The wiki keeps getting richer with every source you add and every question you ask." (line 13)

**ここには raw/ は一度も言及されていない**。価値の中心として語られているのは:
- 複利的に成長する
- クロスリファレンスが既に存在する
- 矛盾が既にフラグされている
- 合成知見が既に反映されている
- 質問と取り込みで豊かになる

**結論**: Karpathy の価値主張の中心は **knowledge network** である。raw/ は **その原料** であり、価値の中心ではない。

**判断軸B: nishio の実装での重心** — 何が運用の中心にあるか

勉強会資料全体を読むと、nishio の価値主張は明確に **knowledge network**:

- "LLM Wiki は、この『知識のネットワーク』を人間の外側で作っている"（勉強会 L189）
- "**ハブ的になっているページや頻繁に更新されるページ** を繰り返し読むことは効率良い知識獲得につながりそう"（勉強会 L190）

**ハブ的になっているページ** = **knowledge network の中心ノード**。nishio の value の中心も knowledge network にある。

**判断軸C: 観察結果**

| repo | 価値の中心の所在 |
|---|---|
| AMME | 100 ページ・785 リンク — リンク密度で機能 |
| grasp | SQLite が authority、Markdown は projection → **knowledge graph が SSOT** |
| about-nishio | 48 ページ + purpose-hoist で目的駆動ネットワーク |
| BDL-2026S | 330 ページ、概念間のクロスリファレンスが価値 |
| delite | Quartz で公開 → 公開 knowledge network |
| Microsoft llmwiki | weighted query で索引付けされた knowledge graph |

**全実装で knowledge network / graph が価値の中心**。

**判断軸D: ユーザーの直感**

> 「自分は knowledge graph の側面のほうが大事に思える」

**ユーザーの直感は正しい**。すべての判断軸で支持される。

### 4.2 私の判断

**LLM Wiki の main value は knowledge network (knowledge graph) である**。

raw/ は **原料** であり、**補助装置** である。LLM Wiki の価値は raw/ の中身にではなく、**wiki/ の中で raw/ と file-back が編み込まれて育つ network** にある。

**raw/ SSOT は main value ではない**:
- raw/ SSOT は wiki の信頼性に寄与する（検証可能性、作文リスク防衛）
- ただし wiki が信頼できる knowledge network であるための十分条件ではなく、**必要条件ですらない**
- knowledge network は raw/ がなくても file-back だけで育つ（質問と回答の蓄積だけでも価値を生む）

### 4.3 「複合」可能性の評価

「main value は raw/ SSOT か、knowledge graph か」と二者択一で問われたが、**両者は直交していない**:

```
       knowledge network (value)
              |
              |  ← 支え
              |
       raw/ SSOT (補助)
```

- knowledge network は **価値**
- raw/ SSOT は **支え**（補助機能）
- 支えがなくても価値は成立しうる（純 file-back wiki も network として機能）
- 支えがあるほど価値の **信頼性** が増す（誤情報検出、ライセンス保護）

**正しい問い**は「raw/ SSOT は必要か」ではなく、「**raw/ SSOT のコストと利益は釣り合うか**」である。コストは:
- バックアップ・同期のコスト
- private 情報の取扱コスト
- 著作権の取扱コスト
- gitignore の判断コスト

利益は:
- 検証可能性
- 作文リスク防衛
- LLM 範囲境界の物理的保証

→ **低コスト・低利益** な領域では raw/ SSOT は不要、**高コスト・低利益** な領域でも別途仕組みで代替可能。**高利益（信頼性が critical）** な領域でのみ raw/ SSOT は正当化される。

---

## 5. 「provenance 原則」の再評価

### 5.1 前回提案された原則の内容

前回議論（2026-08-14 周辺）で提案された原則:

> wiki の主張は依拠を意識する。形式は自由、認識は義務。

**「認識は義務」の中身**: 各 wiki ページの記述が出典（source）に依拠していることを、LLM も人間も認識している状態を保つ。

### 5.2 2 つのモデルでの位置づけ

#### raw/ SSOT 中心モデルでの位置づけ

- **中核価値に直結**: SSOT がなければ wiki の主張は信頼できない → provenance は中核
- 「wiki 全体の source of truth = raw/」が成立する前提で、依拠は必然的に raw/ への参照になる

#### knowledge network 中心モデルでの位置づけ

- **補助的価値に降格**: knowledge network 自体が価値の中心 → provenance は衛生機能
- 衛生機能として最低限は保つべきだが、過剰な強制は template の複雑化を招く

### 5.3 新しいモデルでの位置づけ

**provenance 原則は template には不要**。理由:

1. **強制力の問題**: AGENTS.md で「frontmatter の `raw:` を意識する」と書いても、LLM は忘れる。lint で機械チェックすると過剰
3. **実害の限定**: 作文リスクの主要事案例（overview のソース一覧）はユーザー操作由来であり、frontmatter 強制では防げない
4. **コスト・ベネフィット**: 強制コスト（AGENTS.md 肥大化・LLM 認知負荷）>> 利益（軽微な検証可能性向上）

### 5.4 維持すべき最低限

「provenance 原則」の全面撤回ではなく、**衛生機能としての最小限** は維持:

- ✅ sources ページの frontmatter `raw:` 必須化（template で実装済み）
- ✅ AGENTS.md での「wiki/ の事実が争われたら raw/ まで遡る」記述（template に既にある）
- ✅ `raw/` は変更しない（template AGENTS.md L16）
- ❌ 「wiki ページにも frontmatter 推奨」は不要（template AGENTS.md「frontmatter は任意」が正解）

### 5.5 過剰な原則を AGENTS.md に書き込もうとした経緯

この研究wiki では、過去に「provenance 原則」を template に書き込もうとする議論があった（推測: 2026-08-11 付近の討論）。これは:

1. raw/ SSOT 中心モデルの暗黙的採用
2. [[LLM Wikiの作文リスク]]（過剰反応の温床）
3. 前回 subagent 相談での「形式 vs 認識」の分離（形式的強制を諦めたが認識レベルでは保持しようとした）

の 3 つの過剰が重なった結果。**過剰の根源は raw/ SSOT の過剰視** であり、main value を knowledge network と見なす本議論で **自然に解消される**。

---

## 6. template への含意

### 6.1 main value が knowledge network に移った場合の含意

#### raw/ の扱い

- **維持**: 追跡デフォルト（`.gitignore` に `raw/*` を含めない）。これは妥当（[[rawディレクトリの取り扱い]] の判断）
- **修正**: AGENTS.md の文言を弱める。「LLM は読むだけで、絶対に変更しない」→「LLM は変更しない（人間が依頼した場合を除く」に弱める余地
- **維持**: sources ページ frontmatter `raw:` 必須化（最低限の衛生）

#### AGENTS.md の文言

| 項目 | 現状（過剰） | 修正案 |
|---|---|---|
| raw/ 不変性 | 「LLMは読むだけで、絶対に変更しない」 | 「LLMは変更しない。例外: 人間が明示的に依頼した場合の追加」 |
| 検証 | 「wiki/の事実が争われたら raw/ まで遡る」 | 維持（意味のある保証） |
| frontmatter | 「書く場合はページ種別に応じてメタを付加してよい」 | 維持（既に適正） |
| 書き換え | 「wiki/のページは追記ではなく書き換えで更新する」 | 維持（既に適正） |

#### ingest SKILL.md

| 項目 | 現状 | 修正案 |
|---|---|---|
| ソースの取得 | 「raw/ にない場合、追加できるのは**人間が明示的に依頼した場合のみ**」 | 維持（適正） |
| 代替経路 | （明文なし） | 「URL、引用、発見層からの直接読み込みも可」を明文化 |

#### provenance 原則

- **AGENTS.md から削除**: 「wiki の主張は依拠を意識する」関連の記述
- **sources frontmatter `raw:` 必須化は維持**: 衛生機能として
- **provenance 検証 lint は不採用**: 過剰防衛

### 6.2 template v0.2 への反映候補

1. AGENTS.md L16「raw/ 不変」の文言を弱める（必須/任意の表現調整）
2. ingest SKILL.md にライブソース・引用対応の 1 行追加
3. lint.sh から（もしあれば）raw/ 検証機能を確認、過剰なら削除
4. 草案ver.2 への展開: claim 9「操作層は ...」以外に影響なし（MCP 不採用決定とは独立）

### 6.3 研究 wiki 自体への含意

- [[rawディレクトリの取り扱い]] の「不変性の 3 機能」「入場時の誓約」は **維持** してよい（スナップショット型 raw/ には妥当）
- [[LLM Wikiの作文リスク]] の防衛線記述は **より軽量化** してよい（lint による raw/ 検査は過剰）
- 新規概念ページ「**LLM Wiki の main value**」を作成（knowledge network が中心であることを明文化）

---

## 7. 知識の外部化 vs 知識のネットワーク

### 7.1 二つの軸の定義

**知識の外部化**（[[コンテキスト外部化の歴史]], [[理解のボトルネック]]）:
- 人間の認知負荷を下げる
- 人間の記憶を代替する
- 個人が読んで把握できるようにする
- 系譜: PLAN.md → Devin Knowledge → Agent Skills → LLM Wiki

**知識のネットワーク化**（[[連想トレイル]], [[繋げる力]], [[永続Wikiと複利効果]]）:
- 概念間の結びつきを発見・蓄積する
- 異なる文脈の知識を結合する
- 合成知見を生成する
- 系譜: Memex → Hypertext → Web → LLM Wiki

### 7.2 二軸の関係

LLM Wiki は **両方を志向**しているが、関係は:

```
       知識のネットワーク化
              ↑
              │  志向
              │
       LLM Wiki
              │
              │  前提
              ↓
       知識の外部化
```

- **外部化は前提**（wiki = 人間の外側にある、LLM が読むために存在する）
- **ネットワーク化が価値の本体**（ネットワークの質が wiki の質を決定する）

外部化だけでは wiki ではなく単なるデータベース。ネットワーク化を加えて初めて wiki。

### 7.3 ユーザー指摘の本質

> 「自分は knowledge graph の側面のほうが大事に思える」

これは **ネットワーク化** 軸への注目。**正しい**。

ただし、ユーザーは**外部化を否定していない**（前提として受け入れている）。両者を対立軸として扱うのは誤りで、**直交する二つの関心軸のうち価値軸はネットワーク側にある** と言っている。

### 7.4 tsurubee vs nishio の対立との関係

この対立（[[理解のボトルネック]], [[読まれなくてよい中間産物]]）も実は:

- **tsurubee**: 外部化の完成形として **人間可読** を重視（ネットワークの**入口**の最適化）
- **nishio**: ネットワークの**成長**を重視（ネットワークの**質**の最適化）

対立ではなく、**異なる段階の最適化目標** の差異。両者は直交する:
- tsurubee の問題は「ネットワークの入口が悪く、人間が利用できない」場合
- nishio の問題は「ネットワークが育たない」場合

→ **両方を意識すべきだが、template としては network の成長を主目標に据える**（[[claims対応表]] の claim#7 議論と整合）。

---

## 8. 研究 wiki への統合的

### 8.1 良かった点

この議論は実は過去の発見と連続している:

1. **[[rawディレクトリの取り扱い]]** で既に「raw/ の機能を 3 つに分解」「ライブ型/スナップショット型の混在」「コーパスモードの条件付き正当化」を行っていた
2. **[[Wikiはワークショップ]], [[fact-wiki-separation]]** で「wiki を source of truth にしない」を確立していた
3. **[[理解のボトルネック]]** で「read-optional と read-involved の対立」を記録していた
4. **[[複数のLLM Wikiに共通のインプット]]** で「同じソースを複数 Wiki に投入→異なる切り出し方が生まれる」 = **knowledge network が育つ** ことの実証データがあった

**これら全てが「main value = knowledge network」を支持していた** が、明示的に統合されていなかった。

### 8.2 過剰だった議論

過剰だったのは:

1. **provenance 原則の強制** — sources frontmatter `raw:` 必須化で十分。wiki ページ全体への frontmatter 推奨は過剰
3. **「wiki の主張は依拠を意識する」式の精神論** — 衛生機能を精神論で実装しようとした

これらは raw/ SSOT の過剰視から来ていた。**過剰の根源を取り除けば、自然に解消される**。

### 8.3 template v0.1 の評価

template v0.1 は **ほぼ妥当** だった:

- ✅ 3 層構造
- ✅ AGENTS.md+SKILL.md 二層
- ✅ sources frontmatter `raw:` 必須化（衛生機能の最低ライン）
- ✅ raw/ 不変記述（弱める余地はあるが妥当）
- ✅ wiki ページ frontmatter 任意（過剰でない）
- ❌ 軽微な過剰: AGENTS.md の「絶対に変更しない」表現

**template v0.1 への大きな変更は不要**。議論を反映するなら v0.2 への minor 反映で足りる。

### 8.4 議論の位置付け: 草案ver.1 の claims への影響

[[テンプレート草案ver.1]] の claims（[[claims対応表]]）への影響:

| claim | 影響 |
|---|---|
| 1: 3 層アーキテクチャ | 影響なし（不変） |
| 2: 4 分類 | 影響なし |
| 3: ファイル名 | 影響なし |
| 4: index.md カタログ | 影響なし |
| 5: Cosense の 6 原理 | 影響なし |
| 6: 1 ソース 10-15 ページ | 影響なし |
| 7: read-optional | 影響なし（既に read-involved 前提の修正済み） |
| 8: wikilink first-class | 影響なし |
| 9: 操作層 | 影響なし（MCP 不採用維持） |

**新規 claim 候補**: 「LLM Wiki の main value は knowledge network である」 — 草案 ver.2 で追加検討。

---

## 9. 私の見解（明示）

### 9.1 main value について

**main value は knowledge network である**。これは Karpathy/nishio のテキスト・実装・観察すべてが支持する。raw/ は補助装置であり、価値の中心ではない。ユーザーの直感は正しい。

### 9.2 provenance 原則について

**provenance 原則は template には不要**。AGENTS.md から関連記述を削除してよい。最低限の衛生機能（sources frontmatter `raw:` 必須化）は維持。これは出典の存在証明であって、provenance の厳密運用ではない。

### 9.3 raw/ の扱いについて

**raw/ の追跡デフォルトは維持**。ただし AGENTS.md の「絶対に変更しない」は「変更しない（人間依頼時を除く）」に弱める余地がある。ライブ型 raw/ の gitignore はコーパスモードとして正当化される。

### 9.4 template への反映

template v0.1 はほぼ妥当で、**大きな変更は不要**。v0.2 への minor 反映:
1. AGENTS.md L16「絶対に変更しない」の表現調整
2. ingest SKILL.md にライブソース対応の 1 行追加
3. 草案 ver.2 への claim 追加検討

### 9.5 wiki 自体への反映

1. **新規概念ページ「LLM Wiki の main value」** を作成
2. **[[rawディレクトリの取り扱い]]** の corpus mode 議論を knowledge network 観点で補強
3. **[[claims対応表]]** に新規 claim 候補として main value を記録

### 9.6 議論の根本的解決

ユーザー指摘の本質は **「LLM Wiki の value 中心を見誤っていた可能性」**。

この wiki は raw/ SSOT の過剰視から出発したが、実装と観察の蓄積により knowledge network が中心であることが見えてきた。**過剰視の解消 = value 中心の明文化**。

これは template 設計にとって **重要な方針転換** であり、ver.2 以降の claims に反映する価値がある。

---

## 10. 結論

**3 つの根底的問いへの回答**:

1. **raw/ SSOT は Karpathy の元設計と整合するか** → **いいえ、完全には整合しない**。Karpathy は raw/ を「immutable な source of truth」と書いたが「wiki の唯一の source」とは書いていない。query 情報の file-back も明示的に設計に含まれている。「raw が唯一の source」は派生解釈。

2. **raw/ の存在理由は何か** → **補助装置**。検証可能性・作文リスク防衛・ライセンス・LLM 範囲境界の 4 機能を果たすが、**価値の中心ではない**。再生成可能な raw/ は単なる参照層。

3. **LLM Wiki の main value は何か** → **knowledge network**。Karpathy/nishio/全実装/ユーザーの直感が全て支持する。raw/ SSOT は補助。

**template への含意**: provenance 原則の強制は撤回。sources frontmatter `raw:` 必須化のみ残す。template v0.1 はほぼ妥当で、v0.2 への minor 反映で足りる。

**研究 wiki への含意**: 新概念「LLM Wiki の main value」を作成し、knowledge network が中心であることを明文化。

---

## 関連

- [[2026-08-11 Karpathy LLM Wiki Gist]] — 原典の精読対象
- [[3層アーキテクチャ]] — raw/ 不変性の理論的基盤
- [[rawディレクトリの取り扱い]] — 不変性の再解釈、コーパスモード
- [[LLM Wikiの作文リスク]] — 防衛線議論の出発点
- [[永続Wikiと複利効果]] — knowledge network の複利的蓄積
- [[Wikiはワークショップ]], [[fact-wiki-separation]] — wiki を source of truth にしない設計
- [[理解のボトルネック]], [[読まれなくてよい中間産物]] — read-optional vs read-involved 対立
- [[注意の足場]] — 入口設計
- [[LLM Wikiは要約の改良版ではない]] — 圧縮しないアプローチ
- [[コンテキスト外部化の歴史]] — 知識の外部化軸
- [[連想トレイル]] — 知識のネットワーク化軸
- [[複数のLLM Wikiに共通のインプット]] — knowledge network の実証データ
- [[テンプレート草案ver.1]], [[claims対応表]] — claim との接続
- [[配布形式の決定とテンプレートの動機]] — v0.2 への反映先
- [[Microsoft llmwiki]] — 独立実装での knowledge graph 重視