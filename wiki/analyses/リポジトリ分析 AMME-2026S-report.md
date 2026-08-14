---
status: tentatively-adopted
date: 2026-08-12
tags: [template-design, repos, pilot-analysis, takker99, thin-agents]
source: subagent analysis of repo
sources: "[[GitHubリポジトリ分析の方法論]]"
repo_url: private (takker99/AMME-2026S-report)
commit: d3f10b83d9da1e24dd733e7aea88a2d0e1d237e1
clone_date: 2026-08-12
license: (private repo)
type: 研究レポート型 / 最薄AGENTS.md
---

# リポジトリ分析: AMME-2026S-report

パイロット分析3件目。takker99の研究レポート用LLM Wiki。
AGENTS.mdが1.9KBと極限的に薄いが、wiki/に100ページ・785リンクを生成している。
「AGENTS.mdはどこまで薄くできるか」への下限値を示す最重要事例。

## 構造

| 項目 | 値 |
|---|---|
| AGENTS.md | **1,925 bytes / 42行**（最小） |
| SKILL.md (llm-wiki) | 3,666 bytes / 68行 |
| 追加skills | `lean-review` (7.8KB), `lean-latex-alignment` (7.0KB) |
| wiki/ 総ページ数 | **100** |
| wiki/ 総行数 | 5,228行（平均52行/page） |
| frontmatter使用率 | 8%（ソースページの `source:` 行のみ） |
| wikilink使用率 | **0%**（すべて標準Markdownリンク） |
| 総リンク数 | 785 |
| raw/ ソース数 | 5ファイル |
| 運用期間 | 2026-06-22 〜 07-12（約3週間） |
| lean-review skill | 7.8KB |
| lean-latex-alignment skill | 7.0KB |

### wiki/ ディレクトリ構成

| カテゴリ | ページ数 | 内容 |
|---|---|---|
| `concepts/` | 40 | 数学概念 + 運用概念 |
| `entities/` | 24 | ツール・モデル・人物・論文 |
| `sources/` | 5 | raw/ ソース要約 |
| `proofs/` | 14 | 7問の証明方針 + proof log |
| `project/` | 4 | overview, roadmap, tooling-decisions |
| `synthesis/` | 11 | 設計判断、レビュー基準、監査レポート |
| メタ | 2 | index.md, log.md |

## AGENTS.mdの内訳（42行）

| セクション | 行数 | 内容 |
|---|---|---|
| 三層アーキテクチャ | 6行 | `raw/`と`wiki/`と`AGENTS.md`の定義 |
| ディレクトリ構造 | 2行 | 一覧 |
| ページ規約 | 3行 | kebab-case英語、日本語見出し、`source:`行 |
| コミット規約 | 2行 | Conventional Commits |
| Quick Operations | 7行 | Ingest/Query/Lint 各1-3行サマリ |
| 禁止事項 | 4行 | raw/変更禁止、sorry残留禁止、出典なき主張禁止 |
| ヘッダ・スキル参照 | 3行 | 「詳細はllm-wiki skillを読め」 |

## なぜ1.9KBで運用できているか

### 要因1: AGENTS.md + SKILL.md の二層設計
- AGENTS.md = スキーマ（構造・命名・禁止事項）+ 保険（Quick Operations Summary）
- SKILL.md = 完全操作手順
- AgentがskillをloadできなくてもQuick Operations Summaryで最低限動作する耐障害性
- 設計判断は `synthesis/design-rationale.md` に記録

### 要因2: ドメイン特化による前提共有
- 「Lean 4で数学レポートを書く」という共有ゴール
- raw/ 5ファイルのみ（ingestの複雑性が低い）
- 単一ユーザー、7問の数学課題という明確なタスク構造

### 要因3: LLMの事前知識への依存
- 「Ingest」「Query」「Lint」の概念自体は説明不要
- opencodeのskill systemの挙動はモデルが既知
- AGENTS.mdは「このプロジェクトでの具体的なやり方」だけ書けばよい

## テンプレート研究への示唆

### 「AGENTS.mdはどこまで薄くできるか」への回答

**下限は約1.5KB/35行。** これ以下にするとLLMが自力で構造を発明しなければならず、一貫性が失われる。

必須要素:
1. アーキテクチャ定義（三層構造）
2. ディレクトリ構造一覧
3. 命名規約
4. 操作の1文サマリ（skill非ロード時の保険）
5. 禁止事項（最小3つ）
6. コミット規約（プロジェクト次第）
7. skillへの委譲指示（skillが存在する場合のみ）

### 汎用テンプレートに取り込める要素

| 要素 | 可否 | 備考 |
|---|---|---|
| **AGENTS.md + SKILL.md 二層設計** | ✅ 強く推奨 | 責務分離・耐障害性・context節約 |
| **Quick Operations Summary（保険）** | ✅ 必須 | skill非ロード時のフォールバック |
| **禁止事項を最低限に** | ✅ 有効 | AGENTS.mdの膨張防止 |
| **synthesis/ ディレクトリ** | ✅ 推奨 | analyses/の代替として有効 |
| frontmatter不使用 | ❌ | 長期・多人数ではメタデータが必要 |
| 英語kebab-case + 日本語見出し | ⚠️ 条件付き | 日本語ユーザー向け。国際化では要検討 |
| proofs/ + project/ ディレクトリ | ❌ | プロジェクト固有。analyses/に吸収 |

### 欠けているもの（テンプレートとして見た場合）

1. **「なぜこの構造なのか」の説明** — カスタマイズ時の判断基準がない
2. **対話ガイドラインの不在** — 提案主義、file-back提案等の運用哲学がskillにも書かれていない
3. **skill非存在時のフォールバックが貧弱** — Quick Operations Summaryは1-3行で不十分
4. **frontmatter規約の完全放棄** — 長期知識管理にはstatus/tagsが必要
5. **raw/ファイル名の制約がない** — 移植性の課題

### 研究wikiへの示唆

**skillの有無がAGENTS.mdのサイズを決定する主要因。**
本wikiにskill層を導入すれば、AGENTS.mdを大幅に削減できる可能性がある。
テンプレートの配布形式を考える上で「skill同梱か否か」が最初の設計判断になる。

## 成果物連携

wikiは品質管理システムとして機能:
- `wiki/proofs/qN-*.md` → LaTeX (`tex/subfiles/Q*.tex`) + Lean (`AMME2026S/QN.lean`)
- `concepts/lean-tips.md` (356行) — Lean実装の罠・パターン集約
- `synthesis/proof-review-criteria.md` — 証明品質基準を形式化
- `synthesis/correctness-audit.md` — 全証明の課題文適合性監査

## 関連

- [[リポジトリ分析 llm-wiki-about-nishio]] — nishio系、個人成熟型
- [[リポジトリ分析 grasp]] — nishio系、Code+Wikiハイブリッド
- [[パイロット分析 横断所見]] — 3件の横断比較
- [[GitHubリポジトリ分析の方法論]]
- [[Schema（AGENTS.md）]] — AGENTS.mdの薄さの限界に関する概念
