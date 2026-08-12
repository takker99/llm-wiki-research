---
date: 2026-08-12
tags: [template-design, agents-md, claude-md, pilot-finding]
sources: "[[パイロット分析 横断所見]]", "[[リポジトリ分析 llm-wiki-about-nishio]]", "[[リポジトリ分析 grasp]]", "[[リポジトリ分析 llm-wiki-about-delite]]"
---

# AGENTS.md=CLAUDE.md管理パターン

AGENTS.md（汎用エージェント設定）とCLAUDE.md（Claude Code用設定）の
関係をどう設計するか。5件のパイロット分析から4つのパターンが確認された。
全パターンに課題があり、決定版はまだない。

## 4パターン

| パターン | 例 | メリット | リスク |
|---|---|---|---|
| **完全コピー** | about-nishio | 両方から同じ内容が読める | 同期漏れ。実際にCLAUDE.mdのみ更新指示あり |
| **共通部分コピー+差分分離** | grasp | 共通部分の一元管理意図あり | 共通部分変更時に両方更新が必要。実質コピー |
| **CLAUDE.mdのみ** | delite | シンプル | ツール依存。他LLMツールからアクセス不可 |
| **CLAUDE.mdなし** | AMME, BDL | opencodeのみで完結 | opencode非ユーザーが使えない |

## どのパターンを選ぶべきか

テンプレートとしての推奨: **単一AGENTS.md + ツール固有差分を `.claude/` 等に分離。**

これにより:
- AGENTS.mdはツール非依存の汎用ルールを保持
- `.claude/commands/`, `.opencode/` 等にツール固有の設定を分離
- symlinkやコピーは避ける（同期リスク）

ただし、このパターンを採用している例はパイロット中に存在しない（未検証）。
テンプレート草案ver.2で提案し、実地検証が必要。

## そもそもCLAUDE.mdは必要か

Claude CodeにおいてCLAUDE.mdはAGENTS.mdの代替として機能するため、
両方あること自体が混乱を生む。
opencodeはAGENTS.mdのみを読む。

**テンプレートが特定ツールに依存しないこと** が設計目標なら、
AGENTS.md 1本で統一し、必要に応じて各ツール用の設定ファイルを追加する方針が
最もシンプルで移植性が高い。

## 関連

- [[パイロット分析 横断所見]] — 4パターンの比較表
- [[リポジトリ分析 llm-wiki-about-nishio]] — 完全コピーパターン
- [[リポジトリ分析 grasp]] — 差分分離パターン
- [[リポジトリ分析 llm-wiki-about-delite]] — CLAUDE.mdのみパターン
- [[Schema（AGENTS.md）]] — AGENTS.mdの設計全般
