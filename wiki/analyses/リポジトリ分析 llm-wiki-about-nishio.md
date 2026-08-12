---
status: tentatively-adopted
date: 2026-08-12
tags: [template-design, repos, pilot-analysis, nishio]
source: subagent analysis of repo
sources: "[[GitHubリポジトリ分析の方法論]]"
repo_url: https://github.com/nishio/llm-wiki-about-nishio
commit: e6117d05432667968bd12947e059f36dfa8b75a8
clone_date: 2026-08-12
license: None
type: 個人成熟型
---

# リポジトリ分析: llm-wiki-about-nishio

パイロット分析1件目。nishioの個人LLM Wiki。自己紹介ページ更新を第一目的とする。

## 構造

| 項目 | 値 |
|---|---|
| AGENTS.md | 6,430 bytes / 104行 / 6セクション |
| CLAUDE.md | 同一内容のコピー（6,430 bytes） |
| wiki/ 総ページ数 | 48 |
| wiki/ 総行数 | 2,919 lines |
| index.md | 79行、ルート直下 |
| log.md | 313行、ルート直下 |
| sources/ | 14ファイル、ルート直下 |
| 運用期間 | 2026-05-27 〜 2026-07-28（約2ヶ月） |
| raw/ | `.txt` bundleファイルはcommit対象、`external_brain_in_markdown/`はgitignored |

### wiki/ ディレクトリ構成（研究wikiとの差異）

| 本Wiki | 研究テンプレート | 備考 |
|---|---|---|
| `concepts/` (16) | concepts/ | 一致 |
| `topics/` (3) | entities/ | 人間以外の関心テーマ |
| `projects/` (2) | なし | 独自追加 |
| `syntheses/` (6) | analyses/ | 名称違い、用途は同じ |
| `meta/` (2) | なし | Wiki編集方針・マッピング |
| `dots/` (1) | なし | Dot候補管理（目的特化） |

## AGENTS.mdの主要セクション

1. **このプロジェクトの目的** — 第一目的「自己紹介ページ更新」を明示。全操作に寄与記述を義務付け
2. **ディレクトリ構成** — `private ⊃ public` 原則
3. **新規ページをどこに置くか** — テーブル形式の種別→場所マッピング
4. **ページ規則** — frontmatter必須(`type`, `summary`, `sources`)、`## Updates`追記
5. **ワークフロー** — キーワード駆動grep ingest、Query、Lint
6. **編集方針** — 時系列文脈保持、推測の明示

## 特徴的運用パターン

### 目的駆動 + purpose-hoist
運用開始直後にユーザーから「Wikiの目的が明瞭でない、迷走している」と指摘され、
AGENTS.md冒頭に目的セクションが追加された（2026-05-31）。
この修正以降、全ingestに「第一目的への寄与」を明示するルールが機能。

### キーワード駆動ingest
24,000+ページのexternal_brainをgrepで切り出し、
`sources/<keyword>-search.md` として束ねる。大規模ソース向けの実践的パターン。

### 徒歩（walker）レビュー設計
人間のレビュー負荷最小化: AIが5-10件にフィルタ → 本人は❌/違和感のみ指摘。
feedback memoryとして形式化され、過剰解釈の修正記録が蓄積。

### Deliverableパイプライン
Wiki → Dot候補 → 本人レビュー → JSON変換 → entrypoint import の明示的成果物チェーン。

## 破綻・修正の痕跡

| 事象 | 日付 |
|---|---|
| purpose-hoist: 目的不在による迷走を修正 | 2026-05-31 |
| 過剰解釈: 主語の取り違えで全ページ誤訂正 → feedback memory化 | 2026-05-31 |
| 事実誤認: 本人実績でないものを帰属 → 本人訂正 | 2026-07-28 |

## テンプレート研究への示唆

### 取り込める要素
- **目的明示 + 接続チェック**: 迷走防止に有効。AGENTS.mdテンプレートに目的セクション必須化
- **`## Updates` 追記 + `## Open Questions`**: 履歴保持と未解決可視化のシンプルな仕組み
- **徒歩レビュー設計**: 人間のレビュー負荷を下げる設計原則
- **index.md/log.md ルート直下配置**: 即時参照性が高い

### 一般化できない要素
- `dots/` ディレクトリ（特定目的依存）
- 第一目的の強制（プロジェクト駆動型限定）
- Scrapbox本人レビュー運用（特定状況依存）
- 24,000+ページgrep駆動ingest（一般のWikiには不要）

### 課題
- AGENTS.md=CLAUDE.md のコピー管理は同期リスクあり
- `entities/` 不在（長期的には必要になる可能性）

## 関連

- [[リポジトリ分析 grasp]] — 同nishio系、Code+Wikiハイブリッド
- [[リポジトリ分析 AMME-2026S-report]] — takker99系、最薄AGENTS.md
- [[パイロット分析 横断所見]] — 3件の横断比較
- [[GitHubリポジトリ分析の方法論]]
