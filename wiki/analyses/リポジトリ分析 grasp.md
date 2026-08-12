---
status: tentatively-adopted
date: 2026-08-12
tags: [template-design, repos, pilot-analysis, nishio, code-wiki-hybrid]
source: subagent analysis of repo
sources: "[[GitHubリポジトリ分析の方法論]]"
repo_url: https://github.com/nishio/grasp
commit: a7ff7d339a610db02d7d5ee9651bbe9b89092ea3
clone_date: 2026-08-12
license: MIT
type: Code+Wikiハイブリッド型
---

# リポジトリ分析: grasp

パイロット分析2件目。nishioのgrasp。Python CLIツール（Cosenseデータ処理）とLLM Wikiのハイブリッド。
Code+Wiki同居パターンかつSQLite-authorityの先鋭的設計。

## 構造

| 項目 | 値 |
|---|---|
| AGENTS.md | 12,513 bytes / 77行 |
| CLAUDE.md | 9,706 bytes / 72行（claude差分のみ分離、共通部分はコピー） |
| wiki/ 総ページ数 | 49 |
| index.md | 74行、wiki/配下、説明付きテーブル形式 |
| log.md | **334,787 bytes / 2,018行**（file-back自動化の帰結） |
| Pythonコード | `grasp/` 9ファイル（CLI本体） |
| skills/ | `grasp/SKILL.md` 213行（全agent共通のCLI操作定義） |
| scripts/ | 10個の運用スクリプト（lint, preflight, postwrite等） |
| 運用期間 | 長期間（log.md 2,018行が示す） |
| raw/ | gitignored |

### ハイブリッド構造

```
grasp/
├── AGENTS.md / CLAUDE.md    — Wiki運用+開発スキーマ
├── grasp/                    — Python CLI本体
├── wiki/                     — 構造化Markdown Wiki
├── skills/grasp/SKILL.md     — 全agent共通skill
├── plugins/grasp-next/       — Codex用slash command
├── scripts/                  — 運用スクリプト
├── examples/persona2a-vault/ — デモWiki（9ページ）
└── pyproject.toml             — Pythonプロジェクト設定
```

## 設計上の核心的特徴

### SQLite-authorityパターン
Markdown=SSoT（通常のLLM Wiki）とは真逆。
SQLiteがauthority、Markdownはprojection。矛盾時はSQLite優先。
Markdown編集の競合・不整合を根本から防止するが、複雑なfile-back guardが必要。

### 分業モデル
「Wiki=設計/Codex=実装」の分業。Wikiがコードの「なぜ」を保持し、
Codexがcontextとして読める。三重のdogfood:
1. AIが使う道具（CLI graph reader）
2. AIが作る道具（wikiを読んで実装）
3. 知見をwikiに戻す（file-back loop）

### マルチエージェント構成

| 層 | 場所 | 役割 |
|---|---|---|
| 全agent共通 | `skills/grasp/SKILL.md` | grasp CLIの使い方 |
| Claude Code専用 | `.claude/commands/ship-next.md` | ship loop |
| Claude Code専用 | `.claude/settings.json` | 権限 |
| Codex専用 | `plugins/grasp-next/` | `/next` コマンド |

AGENTS.mdとCLAUDE.mdの差異はclaude-specificな部分のみ。
ship loop（`/ship-next`と`/next`）はほぼ同一内容で、二重メンテナンスの構造的リスクがある。

### 極度の自動化

file-back→verify→commit→push→次候補 が1コマンドで閉じる。
就寝中にCodexがPR #7→#36まで17時間47分で自動実行した実績あり。

file-backのguard: preflight→lock→write-start→write→postwrite の5段階。
スクリプトによるlint（孤立リンク・壊れリンク・重複stem検出）。

## examples/persona2a-vault/

9ファイルのデモMarkdown wiki。`Agent Memory.md`, `Context Budget.md`, `Source Provenance.md` 等の概念ページ + `source/HN Reddit Digest.md` + `Log.md` + `Retrieval Plan.md`。
LLM Wikiテンプレートの具体例として再利用価値が高い。

## テンプレート研究への示唆

### 取り込める要素
- **skills/ディレクトリの汎用性**: CLIツールの使い方をSKILL.mdに切り出すパターン
- **examples/によるdemo vault**: テンプレート配布時に具体例を同梱する戦略
- **frontmatter必須セット**: `type`, `summary`, `sources` は有力な最小セット
- **index.mdの説明付きテーブル**: 1行カタログを超え、Agentのcontextとして有効

### 一般化が難しい要素
- **SQLite-authorityパターン**: 先鋭的すぎる。汎用テンプレートには時期尚早
- **5段guardのfile-back**: grasp CLI依存。ツール非依存テンプレートでは再現不可
- **分業モデル**: Code+Wiki同居パターン限定

### 課題
- AGENTS.md肥大化（ツール開発ルール+Wiki運用ルールの二重責務）
- ツール依存（grasp CLIなしではwiki運用の根幹にアクセス不能）
- log.md爆発（file-back自動化で334KB。肥大化抑制ルールが必要）
- Markdown投影の遅延（高密度グラフで25秒timeout）

## 関連

- [[リポジトリ分析 llm-wiki-about-nishio]] — 同nishio系、個人成熟型
- [[リポジトリ分析 AMME-2026S-report]] — takker99系、最薄AGENTS.md
- [[パイロット分析 横断所見]] — 3件の横断比較
- [[Wiki駆動開発]] — Code+Wiki同居パターンの概念ページ
- [[GitHubリポジトリ分析の方法論]]
