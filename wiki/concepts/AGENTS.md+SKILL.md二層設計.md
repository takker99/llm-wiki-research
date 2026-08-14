---
date: 2026-08-12
updated: 2026-08-14
tags: [template-design, agents-md, skill, pilot-finding]
sources: "[[リポジトリ分析 AMME-2026S-report]]", "[[パイロット分析 横断所見]]", "[[リポジトリ分析 SKILL併用6事例]]", "[[2026-08-14 opencode Agent Skills仕様]]"
---

# AGENTS.md+SKILL.md二層設計

AGENTS.mdを「スキーマ定義書」に純化し、操作手順をすべてskill（SKILL.md）に委譲するパターン。
AMME-2026S-reportで発見され、AGENTS.md 1.9KBを実現した中核技術。

## 構造

```
AGENTS.md（1.9KB）
├── アーキテクチャ定義（3層構造）
├── ディレクトリ構造一覧
├── 命名規約
├── Quick Operations Summary（保険: skill非ロード時用 ※2026-08-14に見直し: 不要。下記「分担基準」参照）
├── 禁止事項
└── 「詳細は llm-wiki skill を読め」

.agents/skills/llm-wiki/SKILL.md（3.7KB）
├── Ingest 完全手順
├── Query 完全手順
├── Lint 完全手順
└── File-back 判断基準
```

## なぜこれが機能するか

1. **責務分離**: AGENTS.md = What（何をすべきか）、SKILL.md = How（どうやるか）
2. **耐障害性**: Agentがskillをloadできなくても、Quick Operations Summaryで最低限動作
3. **コンテキスト節約**: AGENTS.mdが薄いほど、毎回のコンテキスト消費が少ない
4. **LLMの事前知識への依存**: Ingest/Query/Lintの概念自体は説明不要。AGENTS.mdは「このプロジェクト固有の差分」だけ書けばよい

## 限界

skillは「操作手順」の外部化には有効だが、「ドメイン知識の構造化」の外部化には限界がある。
BDL-2026Sはskill（.agents/ 4件）を持ちながら15.8KBに達しており、
SSOT分配設計のようなドメイン特化知識はskillでは吸収しきれない。

## SKILL併用実装サーベイからの拡張（2026-08-14）

外部LLM Wiki実装6件の比較（[[リポジトリ分析 SKILL併用6事例]]）から、
「AGENTS.mdとSKILLの役割分担」は以下のパターンに類型化できる:

| パターン | ag制御媒体の実例 | 分担の要旨 |
|---|---|---|
| **A: SKILLがSchema層を吸収** | Astro-Han (1.9k★)・micuintus | SKILL.md自体を3層の第3層と定義。AGENTS.md生成なし。skill単独で完結（ただしskill非ロード環境で動作不能） |
| **B: entry file + 操作skillの二層** | jackwener | entry file（数十行）= 常駐ナビゲーション（vault案内・skill選択・cheat-sheet）、skill = オンデマンド手順。**本wikiと同じ構造の独立収束** |
| **C: 薄いCLAUDE.md + 外部スキーマ/設定** | vanillaflava | CLAUDE.mdは1段落。「変化する契約」はwiki-config.md/wiki-schema.mdに分離し人間が編集、skillは手順のみ |
| **D: hooksによる自動注入** | toolboxmd | loader skillをSessionStart hookで注入。起動トリガーを文書でなくhookに移す（プラットフォーム固定を許容） |
| **E: 1行トリガー + skill + MCP併用** | ivankuznetsov | CLAUDE.mdの本質は1行のトリガー。skillがQMD MCPツールを呼ぶ併用も成立 |

検証結果:

- **Bの独立収束**: jackwenerが本wikiと同一構造（entry file薄さ + 操作skillオンデマンド）に独立到達。構造の普遍性の第2系統の証拠
- **Aは需要がある**: Astro-Han 1.9k★。ただし「Quick Operations Summary保険」なしのためskill非ロード環境で機能しない。本wikiの保険付き二層の優位点
- **Cが人間-LLM境界と親和**: スキーマ外部ファイル化は「人間がスキーマを編集し、skillは手順」の分離。テンプレート草案ver.2で採用検討
- **EはMCP併用の実証**: 「デフォルト不採用・オプション追加可」（[[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]）の拡張パスになる

## テンプレート設計への示唆

**skill同梱か否かがテンプレート配布形式の最初の設計判断になる。**

- skill同梱: AGENTS.mdを1.5KB程度まで薄くできる。ただしskillの配布・管理方法が課題
- skill非同梱: AGENTS.mdに操作手順を含める必要がある（5-8KB）。自己完結的で配布は容易

汎用テンプレートでは「最小AGENTS.md + オプショナルskill」の構成を推奨。
Quick Operations Summaryを保険として残すことで、skillがない環境でも最低限動作する。
**（2026-08-14改訂: skillは必須同梱、保険サマリは不要。下記「分担基準」参照）**

## 分担基準: 常時行動 vs トリガー操作（2026-08-14）

人間との設計議論で「何をAGENTS.mdに残すか」の基準を明確化した。

### 基準

1. **常時行動（ユーザーが明示しなくても発動すべき行動）→ AGENTS.md**
   - 例: queryの作法（index.mdから読む・wikilink引用で総合）、file-backの提案習慣、lintの発動ポリシー（自律提案するか・言われた時だけか）
   - 理由: **決定論性**。AGENTS.mdは毎ターン必ずコンテキストに入る
2. **トリガー操作（ユーザーの明示で発動する操作）→ SKILL.md**
   - 例: ingest
   - 理由: 「ingestして」のような明示トリガーのある操作は発動が確実にマッチする。手順を毎ターン常駐させるコストを払う価値がない
3. **交差点 → AGENTS.mdに1行のポリシー**（例: lintの「いつ実行するか」はAGENTS.md、実行手順はSKILL.md）
4. **機械チェック → skill同梱の決定スクリプト**（本wiki: `.agents/skills/llm-wiki-lint/scripts/lint.sh`）。[[リポジトリ分析 SKILL併用6事例]]の全6実装が「検証・決定的実行はコード」で一致（配置は6事例がroot `scripts/`、本wikiは2026-08-14からskill内に改訂: 手順と一体の凝集性・汎用`scripts/`名前空間の衝突回避。[[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]参照）

### skillロードの仕様（[[2026-08-14 opencode Agent Skills仕様]]）

- `<available_skills>`（name + description、約100トークン/skill）が常駐。本文はロード時のみ
- 本文のロードはagentが`skill`ツールを呼んだ時。ユーザー明示不要・ターン途中でも自律発動可
- **トリガーは決定的マッチングでなくLLMの想起**。常時行動をskillに置くと「毎ターンモデルが思い出す必要」が生まれ信頼性が落ちる。[[2026-08-14 SKILL併用LLM Wiki ivankuznetsov (hackernoon+github)]]の1行トリガー（「この1行がないとClaudeはwikiを能動的に見ない」）と整合

### トリガー表・保険サマリは不要

- **保険サマリ（Quick Operations Summary）**: AMME設計での根拠は「skill非ロード時用フォールバック」のみだったが、Agent Skillsは2025-12-18にオープン標準化（agentskills.io、40+プラットフォーム）され非対応環境が消滅したため不要（人間との議論で決定）
- **トリガー表（router）**: descriptionマッチが標準トリガーであり、AGENTS.mdに二重に書くとdriftの温床。AMMEもトリガー表を持たず「詳細は llm-wiki skill を読め」の1行のみ
- **唯一残すもの: 明示パス参照1行**（「手順は`.agents/skills/llm-wiki/SKILL.md`。読め」）。発見パスの差（Claude Codeは`.claude/skills/`のみ読む）への対策。トリガー表でも保険サマリでもない

### 結果

AGENTS.md = スキーマ（構造・命名・禁止事項）+ 常時行動 + 明示パス参照1行。AMME（1.9KB + Quick Operations保険）よりさらに薄い構成が可能。AGENTS.mdの純化の帰結として、`analyses/MCP不採用とAGENTS.md+SKILL.md二層採用の根拠.md`の推奨構成も修正済み。

## 関連

- [[リポジトリ分析 AMME-2026S-report]] — 発見元
- [[リポジトリ分析 SKILL併用6事例]] — 外部実装サーベイ（2026-08-14）
- [[Schema（AGENTS.md）]] — AGENTS.mdの薄さの限界
- [[Agent Skills]] — Anthropicのskill概念
- [[GitHubリポジトリ分析の方法論]]
