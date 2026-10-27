---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]", "[[パイロット分析 横断所見]]", "[[リポジトリ分析 microsoft-llmwiki]]", "[[2026-10-27 LLM知識ベースの言語ドリフト検証]]"
tags: [template-design, llm-wiki-pattern]
---

# Schema（AGENTS.md）

LLM Wikiの3層アーキテクチャにおける第3層。LLMにwikiの構造・規約・ワークフローを伝える設定ドキュメント。Claude Codeでは `CLAUDE.md`、OpenAI Codexでは `AGENTS.md` というファイル名が使われる。

Karpathyの定義: 「LLMをしつけられたwiki保守者にするための鍵。これがあることでLLMは単なる汎用チャットボットではなくなる」

## 役割

- wikiのディレクトリ構造を定義する
- ページの規約（命名、フォーマット）を定める
- Ingest / Query / Lint のワークフローを指示する
- 人間とLLMが時間をかけて共進化させる（ドメインに合わせて調整）

## 薄さの限界

5件の実運用Wiki分析（[[パイロット分析 横断所見]]）から:

| 条件 | サイズ | 例 |
|---|---|---|
| skillあり + 低複雑性 | **1.9KB** | AMME |
| skillなし + 中複雑性 | 6.4KB | about-nishio |
| 高複雑性（ツール開発込み） | 12.5KB | grasp |
| skillあり + 高複雑性（SSOT分配） | 15.8KB | BDL-2026S |

下限は約1.5KB。これ以下ではLLMが自力で構造を発明しなければならず一貫性が失われる。
薄さの鍵は [[AGENTS.md+SKILL.md二層設計]] — 操作手順をskillに委譲し、AGENTS.mdをスキーマ定義書に純化する。

### ガチガチ側の極: スターターテンプレート（Microsoft llmwiki）

[[Microsoft llmwiki]] のinitコマンドは **7セクションのAGENTS.mdを自動生成**する
（Page Types 5種 / Directory Structure / Frontmatter Schema（type+title必須）/ Naming Conventions /
Ingest Workflow / Lint Rules / Cross-Referencing Guidelines、`packages/core/src/init.ts`）。
prescriptiveな「スターターとして配られるschema」の実例。ただし「Starts minimal. Grows with use」と
共進化前提である点はKarpathy/nishioと同じ。
file-backを `queries/` ディレクトリ + `type: query` ページとしてページ種別に制度化している。
→ [[リポジトリ分析 microsoft-llmwiki]]

## 書き込みゲート（2026-10-27 ingest）

エージェントの記憶更新を「永続化前の整合性検証を通すゲート付き演算」として定式化するSSGM（Stability- and Safety-Governed Memory）の観点（[[2026-10-27 LLM知識ベースの言語ドリフト検証]]）。LLM Wikiにはraw/とwiki/の二層分離が既にあり、Schema層の規約が書き込みゲートの実装になる。

- 命題のKnowledge Atom化（複合名詞化による因果圧縮の禁止）→ [[Knowledge Atom]]
- 正規名レジストリとaliasesの強制参照（新規ページ作成前のindex走査）→ [[同義語増殖]]
- 出典と時間・信頼度メタデータの分離保持（上書きによる出典切断の禁止）

AGENTS.md自体の文体が出力のFew-shot手本になる問題（[[プロンプト自己言及汚染]]）と、常駐サイズ上限のメカニズム（[[Instruction Dilution]]）もSchema設計の対象になる。

## 目的明示

[[目的明示（purpose-hoist）|purpose-hoist]]: AGENTS.md冒頭にWikiの第一目的を明示し、全操作に目的への寄与をチェックさせるパターン。about-nishioで迷走防止に有効性が確認された。

## Schemaの二層性

Karpathy gist自身が指摘するように、Schemaには2つのレベルがある:
1. **パターン文書**（Karpathy gistのような抽象レベル）— アイデアを伝える
2. **運用Schema**（各wikiのAGENTS.md）— 具体的なルールを定める

この分離がLLM Wikiテンプレート設計の核心課題の一つ → [[LLM WikiテンプレートのOptionality]]

## SchemaとWikiタイプ

nishioの観察（[[研究目的Wikiとプロジェクト目的Wiki]]）では、Schemaの目的文がWikiタイプを暗黙に規定する。[[株分け（kabuwake）]]時に新Schemaを書くことで、AIが当初の目的との関係が浅いものを無視する問題が解決する。

## AGENTS.mdとCLAUDE.md

→ [[AGENTS.md=CLAUDE.md管理パターン]]

## 関連概念

- [[3層アーキテクチャ]] — Schemaが属する構造
- [[LLM Wiki]] — 全体パターン
- [[Hermes Agent llm-wiki skillとの比較]] — HermesのSCHEMA.mdはagent管理のためのメタデータ（frontmatter必須、タグタクソノミー、provenance、sha256）を定義するが、本テンプレートのAGENTS.mdは人間とLLMの共進化を前提とする設計思想の相違
