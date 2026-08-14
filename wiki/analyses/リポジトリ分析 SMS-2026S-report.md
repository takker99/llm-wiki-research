---
status: tentatively-adopted
date: 2026-08-14
tags: [template-design, repos, pilot-analysis, research-report, grasp, red-links]
source: subagent analysis of repo
repo_url: (private)
license: (private)
type: 研究レポート型（grasp-backed）
---

# リポジトリ分析: SMS-2026S-report

パイロット分析。SMS-2026S（粉体・ジャミング物理学の講義）の研究レポート用LLM Wiki。graspをSQLite-authorityとして使い、リンク概念（未解決targetの参照数分割・backlinks）を実運用している例。AMME-2026S-reportと同系統の研究レポート型だが、graspへの依存度が高い。

## 構造

| 項目 | 値 |
|---|---|
| AGENTS.md | 182行（テンプレート風の汎用構成、`<REPO_NAME>`プレースホルダ付き） |
| wiki/ 総ページ数 | 128 |
| wiki/ サイズ | 960KB |
| .agents/skills/ | `grasp/SKILL.md`（ユーザーレベルskillのミラー）+ `pdf-ingest/SKILL.md` |
| scripts/ | `lint_wiki.py`（参照数分割lint） |
| .grasp/store.sqlite | リポジトリローカルSQLite store（gitignored） |
| report.md | 講義レポート本体（wikiを参照して執筆） |
| raw/ | gitignored |

## 設計上の核心的特徴

### grasp-backed運用

AGENTS.mdはgraspの使い方を第一に定義:
- **常に** `--store .grasp/store.sqlite` を付与（グローバルdefault store禁止）
- wiki/ Markdownはstoreの**投影（projection）**でありread-only cache。衝突時はSQLite優先
- `write-page` / `append-log` / `rename-page` で書く。`wiki/*.md`の直接編集は禁止
- 「Do not edit wiki/*.md directly」— graspのSQLite-authorityパターンの踏襲

### リンク概念の実装: 参照数分割（lint_wiki.py）

[[赤リンクとLLM Wiki]]の実践例として最重要。`scripts/lint_wiki.py:3-8` は未解決target（ページなしだが参照されている）を**参照数で分割**する:

- **1ページのみ参照** = low-frequency unresolved — typo, jargon, or a future concept handle
- **2+ページで参照** = aspect-handle candidate（**2-hop hubの種**、empty page or concept page化候補）
- 「Note: these are not 'broken' — every unresolved target is a real reference」— 未解決targetは壊れリンクではなく実参照
- 1-ref handleは頻度が低いだけで将来育つ可能性がある

BDL-2026Sとほぼ同じ分類だが、SMS-2026S-reportはlintコメントに「2-hop hubの種」と明示的に書いている点で、Cosenseの2 hop link概念を意図的に輸入していることが分かる。

### pdf-ingest skill

PDF論文をingestするワークフロー。`grasp unresolved`で未解決targetのaspect-handle確認を組み込んでいる（`.agents/skills/pdf-ingest/SKILL.md:121`）— 新規概念ページを作る前に、既に複数ページから参照されているaspect-handleとして概念が存在するかを確認する運用。

### source→conceptの役割分担

「sourceページは入口、conceptページが本体」が明文化（AGENTS.md:91-96）。論文が導入する新規概念は必ず独立conceptページとして抽出しcross-linkを整備する。Q1-Q4の判断基準で概念分解を機械的に行う。

## テンプレート研究への示唆

### 取り込める要素
- **参照数分割lint**: 未解決wikilinkを1-ref（typo/error）と2+ref（aspect-handle/info）に分ける分類は、[[Lint]]の赤リンク論争に対する具体的な解。broken-links=errorのハードラインを和らげる第3の選択肢
- **grasp unresolvedのaspect-handle確認**: 概念ページ作成前に「既に2+ページから参照されているか」を確認するワークフローは、赤リンクを概念ノードとして扱う運用の実装例
- **store分離の規律**: リポジトリローカルstoreを使い、グローバルdefaultを汚さない規律は[[Vault分離と人間-AIの境界]]と同型

### 一般化が難しい要素
- **grasp依存**: AGENTS.mdがgrasp CLI前提（SQLite-authority・投影）。ツール非依存テンプレートでは再現不可（[[リポジトリ分析 grasp]]と同じ結論）
- **AGENTS.mdがテンプレート風**: `<REPO_NAME>`プレースホルダ入りで、このwikiでいうテンプレートの「種」の1つとも読める

## 関連

- [[リポジトリ分析 grasp]] — SQLite-authorityパターンの原典
- [[リポジトリ分析 AMME-2026S-report]] — 同系統の研究レポート型（wikilink 0）
- [[リポジトリ分析 BDL-2026S]] — 同じ参照数分割lintを持つ講義型
- [[赤リンクとLLM Wiki]] — 本分析の概念ページ
- [[パイロット分析 横断所見]] — 横断比較
