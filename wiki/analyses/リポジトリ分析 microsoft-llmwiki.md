---
status: tentatively-adopted
date: 2026-08-14
tags: [template-design, repos, implementation, tool, microsoft]
source: direct repo analysis (clone @ commit b44df6ae95138d0edcbcc79b5b1d099c78bce5e0)
sources: "[[GitHubリポジトリ分析の方法論]]", "[[操作層]]"
repo_url: https://github.com/microsoft/llmwiki
commit: b44df6ae95138d0edcbcc79b5b1d099c78bce5e0
clone_date: 2026-08-14
license: MIT
type: 実装repo（製品型ツール）
---

# リポジトリ分析: microsoft/llmwiki

LLM Wikiをソフトウェア製品として実装した**ツールrepo**の分析。
運用repo5件のパイロット分析（[[パイロット分析 横断所見]]）とは性質が異なり、
「LLM Wikiの操作層をコードで実装するとどうなるか」の設計判断が抽出対象。
引用は発見層 `~/git/llm-wiki-samples/microsoft-llmwiki@b44df6ae` から（raw/コピーなし）。

## 位置づけ

- VS Code拡張 + npmパッケージ（`@llmwiki/core`）+ MCPサーバの npm workspaces monorepo
- 2026-08-12時点: 232 commits、v0.1.2、22 stars / 4 forks。開発継続中
- MITライセンス。README・ARCHITECTURE.mdで設計根拠を明文化

## 構造

| 項目 | 値 |
|---|---|
| repo構成 | `packages/core`（wiki操作+MCPサーバ）+ `packages/vscode`（拡張機能） |
| 配布形式 | `.vsix` + npm（`@llmwiki/core`、`npx -p @llmwiki/core llmwiki-mcp`）+ MCP |
| wiki root | `<workspace>/.wiki/`（プロジェクト内埋め込み。`raw/`, `wiki/`, `AGENTS.md`） |
| AGENTS.md | initコマンドが生成する7セクションのスターターテンプレート |
| wiki/ 内部 | `index.md` + `log.md` + `entities/` + `concepts/` + `sources/` + `queries/` |
| frontmatter | `type` + `title` 必須（5種: entity / concept / source / summary / query） |
| 命名 | slugify（lowercase kebab-case） |
| 依存 | VS Code LM API（**GitHub Copilot必須**） |
| 言語 | TypeScript / Node.js ≥ 20 / Vitest / gray-matter |

## 設計上の核心的特徴

### 1. 3層アーキテクチャの独立収束

Karpathyの3層（`raw/`・`wiki/`・`AGENTS.md`）と同一構造を独立に実装。
`index.md` のカタログ形式（H2カテゴリ + `- [Title](path) — summary #tag`）と
`log.md` の追記形式（`## [YYYY-MM-DD] verb | subject`）も当wikiとほぼ同一。
→ 構造の普遍性の強い証拠（[[3層アーキテクチャ]]、[[IndexとLog]]）。

差異: wiki rootを `.wiki/` サブディレクトリに埋め込む（プロジェクト内wiki）。
これは同一repo型（[[Wikiとコードリポジトリの関係]]）の一形態で、ディレクトリ構成の選択肢データ点。

### 2. AGENTS.mdテンプレート（ガチガチ側の極）

initコマンドが7セクションを生成（`packages/core/src/init.ts`）:
Page Types / Directory Structure / Frontmatter Schema（type+title必須）/
Naming Conventions（slugify）/ Ingest Workflow / Lint Rules / Cross-Referencing Guidelines。

[[Schema（AGENTS.md）]]の「薄さの限界」表（最薄1.9KB AMME）の対極に位置する
「スターターとして配られるprescriptive schema」の実例。ただし「Starts minimal. Grows with use」と
共進化前提である点はKarpathy/nishioと同じ。

file-backを**ページ種別**として制度化している点が特徴: `queries/` ディレクトリ +
`type: query` ページ（original query・results_countをfrontmatterに保持）。

### 3. Lintの機械化（6分類）

`lintWiki` は6カテゴリ（`packages/core/src/lint.ts`）:

| カテゴリ | 重大度 | 内容 |
|---|---|---|
| broken-links | error | 存在しない.mdへのリンク |
| stale-entries | error | indexエントリ→削除されたファイル |
| orphan-pages | warning | 入リンクなし＆index未掲載 |
| index-completeness | warning | indexに載っていないページ |
| missing-pages | info | 参照されているが未作成のページ |
| frontmatter-validation | - | type/title/tags/createdの検証 |

当wikiの機械チェック（孤立ページ・壊れリンク・index未掲載・raw参照）との対応に加え、
**stale-entries**（indexエントリの陳腐化）と **index-completeness** の分離は参考になる。
broken-links=error は赤リンク許容派（[[OKF]] §9）と対立する設計選択（[[Lint]]赤リンク論争のデータ点）。

### 4. Queryのweighted検索

indexエントリの title 3x / summary 2x、本文 1x の重み付き全文検索（`query.ts`）。
「index.mdが個人規模で十分機能する」（[[IndexとLog]]）の実装版。
ARCHITECTURE.mdは「Why index.md instead of a search engine?」で
**upgrade path（規模が必要になったらローカル検索ツールを足す。indexは可読カタログとして残る）**を明言。

### 5. 操作層の完全ソフトウェア実装

MCPサーバに14ツール（7 read / 7 write: `wiki_read_page`, `wiki_write_page`,
`wiki_create_entity`, `wiki_add_crosslinks`, `wiki_ingest_with_context` 等）。
write系に安全モデル: path traversal防止、frontmatter必須（title+type）、
index更新のupsert（重複エントリ防止）、エラー分離。

`@wiki`チャット参加者: `/status` `/save` `/lint` `/fix` — **file-backが`/save`としてコマンド化**。
status: ページ数・ソース数・coverage %・最終ingest日をステータスバー常時表示（メトリクス管理）。

→ 文書指示（AGENTS.md）で実現してきた操作層をコード化した先鋭例。[[操作層]]を参照。

### 6. バルクIngestの製品化

フォルダ再帰walk（`.`プレフィックス・`node_modules`/`dist`等スキップ）、
20ファイル超で確認ダイアログ、raw/へのdrag&dropをfile watcherが自動ingest。
外部ファイルは `.wiki/raw/` にコピーしてからingest（[[rawディレクトリの取り扱い]]の実装版）。
→ [[バッチIngest]]のソフトウェア実装例。監視の自動化。

### 7. 依存性の設計判断

- **GitHub Copilot必須**: ingestのenrichmentと`@wiki`にVS CodeのLanguage Model APIを使用。
  モデル提供をプロプライエタリに依存する選択。
- UIはVS Code拡張のみ（CLIの独立UIなし）。「Single surface」を設計判断として明記。
- ARCHITECTURE.mdに設計根拠を網羅: Why not RAG（合成済みwikiがRAGの再導出を不要にする・個人規模ではembedding過剰）、
  Why git repo（ゼロインフラ・バージョン履歴・Markdown普遍性・agent-friendly）。

## テンプレート研究への示唆

### 取り込める要素

- **lintの機械チェック拡張**: stale-entries / index-completeness / frontmatter-validation の分類
- **weighted queryヒューリスティクス**: title 3x / summary 2x / body 1x
- **AGENTS.mdの7セクション骨格**: テンプレートに何を書くかのチェックリストとして
- **queries/ + type: query**: file-backの制度化案
- **initのscaffold内容**: 作成するのは dirs + index.md + log.md + AGENTS.md のみ（最小起動）

### 一般化が難しい要素

- VS Code + GitHub Copilot依存（モデル・IDEを固定）
- MCPサーバ・拡張機能の開発コスト（ソフトウェア実装）
- file watcherによる自動ingest（監視を人間から取り上げる設計 —
  [[Post-ingestレビューループ]]との緊張関係）
- `.wiki/`埋め込み（テンプレートとしては選択肢の1つであって強制できない）

### 差別化への示唆（研究課題への回答）

研究課題「既存の実装（Microsoft llmwiki、llm-wiki.app、各種CLIツール）との差別化は？」
（[[このWikiの目的と研究課題]]）への第一データ点。

- **方向性の違い**: Microsoftは操作層をソフトウェア（MCPツール・拡張機能）として自動化する方向。
  本テンプレートは操作層をAGENTS.md（文書指示）として提供し、ツール非依存・選択自由を保つ方向。
- 3層構造は同一 → **構造は普遍。差別化の軸は操作層の実現手段**（[[操作層]]）。
- ツール型は「操作の決定的実行・安全検証・メトリクス」を可能にする一方、
  モデル依存（Copilot）と実装コスト・監視の自動化（人間の関与除去）が伴う。

### 落とし込み候補（テンプレート草案ver.2へのインプット・2026-08-14）

[[テンプレート草案ver.1]] のclaims照合の結果、具体的な翻訳候補:

- **lint節**: 機械チェックに stale-entries / index-completeness の分離を1行で追加
- **Query節**: 「indexのtitle/summaryを本文より優先して読む」優先順位を明記（weighted 3x/2x/1xの翻訳）
- **執筆規約**: ページ書き込み時の検証ルールとして「type必須・indexのupsert（重複禁止）」を翻訳
- **init/配布**: 初期化で作成する最小セット（dirs + 空カテゴリindex + log + AGENTS.md）
- **file-back**: `queries/` + queryページ種別を選択肢として提示

不採用: 7セクション全量コピー（ガチガチ）、slugify命名（claim#3と対立）、`.wiki/`埋め込み強制、Copilot依存。

## 関連

- [[操作層]] — ツール型実装の概念ホーム
- [[Microsoft llmwiki]] — 製品エンティティ
- [[GitHubリポジトリ分析の方法論]] — 分析の方法論
- [[パイロット分析 横断所見]] — 運用repo5件との対比
- [[このWikiの目的と研究課題]] — 「既存の実装との差別化」TODO
- [[3層アーキテクチャ]] / [[Schema（AGENTS.md）]] / [[Lint]] / [[QueryとFile-back]] / [[IndexとLog]] / [[バッチIngest]]
