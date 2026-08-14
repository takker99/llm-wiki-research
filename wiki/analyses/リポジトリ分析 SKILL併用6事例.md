---
status: tentatively-adopted
date: 2026-08-14
tags: [template-design, skill, repos, implementation, skill-comparison]
sources: "[[2026-08-14 SKILL併用LLM Wiki Astro-Han (github)]]", "[[2026-08-14 SKILL併用LLM Wiki jackwener (github)]]", "[[2026-08-14 SKILL併用LLM Wiki vanillaflava (github)]]", "[[2026-08-14 SKILL併用LLM Wiki toolboxmd (github)]]", "[[2026-08-14 SKILL併用LLM Wiki micuintus (github)]]", "[[2026-08-14 SKILL併用LLM Wiki ivankuznetsov (hackernoon+github)]]"
type: 横断分析
---

# リポジトリ分析: SKILL併用LLM Wiki 6事例

SKILL（Agent Skills）を併用するLLM Wiki実装6件の横断比較。
焦点: **SKILLをどう設計しているか、AGENTS.md/CLAUDE.mdとSKILLの役割分担**。
microsoft/llmwiki（ツール型・[[リポジトリ分析 microsoft-llmwiki]]）が操作層をソフトウェアで実装したのに対し、本分析は**操作層をskill文書で実装する群**の設計判断が抽出対象。

## 対象

| repo | 形態 | スキーマの置き場所 | AGENTS.md/CLAUDE.mdの役割 | MCP/自動化 |
|---|---|---|---|---|
| Astro-Han/karpathy-llm-wiki (1.9k★) | 単一SKILL.md | **SKILL.md自体**（Schema層と明言） | 生成しない。skill単独で完結 | MCP・hooksは「skillの範囲外」と明言 |
| jackwener/llm-wiki (95★) | CLI + 4操作skill | `wiki-schema.md`（vault直下） | **entry file**: 数十行の常駐案内。どのskillをloadするか指示 | CLIで検索・グラフ（DB9はオプション） |
| vanillaflava/llm-wiki-skills (59★) | 6スキル | `wiki-schema.md` + `wiki-config.md` | CLAUDE.mdは「1段落で十分」。3層ブートストラップの第2層 | Claude Desktopではfilesystem MCP必須（CLIは不要） |
| toolboxmd/karpathy-wiki (98★) | 4スキル + hooks | validatorがコードで執行 | AGENTS.md + CLAUDE.md両方。loaderがhookで注入 | hooks全面（SessionStart/Stop）・デタッチドingest |
| micuintus/llm-wiki (22★) | 純skill ~6KB | SKILL.md + lazy-loaded references | entry fileなし | 一切なし |
| ivankuznetsov/llm-wiki | 3スキル | （wiki/gaps.md等のページ群） | CLAUDE.mdは**1行のトリガー**が肝 | **SKILLがQMDのMCPツールを呼ぶ併用** |

## 比較軸1: SKILLの分割粒度

- **単一SKILL型**: Astro-Han（1 SKILL.mdがschema+手順全部）、micuintus（SKILL.md ~6KB + 本文は全てlazy-loaded references）
- **操作別分割型**: jackwener（ingest/query/lint/research の4個）、vanillaflava（config/ingest/query/lint/integrate/crystallize の6個）、ivankuznetsov（bootstrap-wiki/wiki-researcher/wiki-plan の3個）
- **loader+分割型**: toolboxmd（`using-karpathy-wiki` loader + capture/read/ingest の3個。loaderはSessionStart hookで毎回自動注入、他は役割別にオンデマンド）

観察: 単一SKILLでも**lazy-loading**（micuintusのパス参照、Astro-Hanのreferences/）で実質的に分割と同じ効果を狙う。分割の粒度は「ロード粒度の細かさ」と「発見・管理コスト」のトレードオフ。toolboxmdのloaderパターンは「必ずロードされる薄い入口 + 役割別本体」で**ロード粒度を構造的に解決**した形（[[AGENTS.md+SKILL.md二層設計]]と同型の階層がskill内部に再帰している）。

## 比較軸2: AGENTS.md/CLAUDE.mdとSKILLの役割分担 ← 本題

### パターンA: SKILLがSchema層を吸収（AGENTS.md不要）

Astro-Han: Karpathyの3層の第3層を**SKILL.mdそのもの**と定義（「**SKILL.md** (this file) — Schema layer」）。CLAUDE.md/AGENTS.mdを生成せず、`npx add-skill`で完結。micuintusも同系（SKILL.md ~6KB + パス参照references、entry fileなし）。

- 利点: 配布が単一フォルダで完結。エージェント非依存
- 欠点: **skill非ロード環境で動作不能**。本wikiの「Quick Operations Summary保険」のようなフォールバックがなく、Agent Skills未対応agentでは何も起きない

### パターンB: entry file（常駐数十行）+ 操作skill（オンデマンド）の二層

jackwener: 本wikiの[[AGENTS.md+SKILL.md二層設計]]と**ほぼ同一構造**。entry file（CLAUDE.md/AGENTS.md、数十行）は「vaultの場所・どのskillをloadするか・CLI cheat-sheet・コア規則」のみで、手順は全てskillへ。entry fileの薄さを「session-start context節約」と明記。

→ **二層設計の独立収束の証拠**（本wikiのAMME発見と別系統で同じ構造に到達）。

### パターンC: 薄いCLAUDE.md + 外部スキーマ/設定ファイル + 複数skill

vanillaflava: CLAUDE.mdは「1段落で十分」、代わりに`wiki-config.md`（設定）と`wiki-schema.md`（frontmatterスキーマ・enum定義）をvault直下に配置し、6スキル全てがboot時に読む。テンプレート13種も`templates/`に分離しユーザー編集可能（skillコードを触らず反映）。
→ **人間の編集対象（スキーマ・設定・テンプレート）とLLMの手順書（skill）の分離**が明示的。skillは「変化しない手順」、スキーマ/設定は「変化する契約」。

### パターンD: hooksによる自動注入 + 役割分割skill

toolboxmd: loader skillをSessionStart hookが毎回注入（`hookSpecificOutput.additionalContext`）。AGENTS.md+CLAUDE.mdはプラグイン文書として残るが、実際の起動時ナビゲーションはhook→loaderが担う。**skillの起動トリガーを文書（description frontmatter）でなくhookに移した**形。

### パターンE: 1行トリガー + skill + MCP併用

ivankuznetsov: CLAUDE.mdで重要なのは **「Always check wiki/ before answering...」の1行**だけ。残りは補助。wiki-researcher skill（オンデマンド）がQMDのMCPツールを呼び、/plan commandがCEプランニングへ委譲。
→ **SKILLとMCPは排他でなく、skillがMCPツールを呼ぶ「併用」が実運用で成立**（[[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]の「オプション追加可」を裏付けるデータ点）。

### 分担のまとめ

| 機能 | A (Astro-Han) | B (jackwener) | C (vanillaflava) | D (toolboxmd) | E (ivankuznetsov) |
|---|---|---|---|---|---|
| 起動時ナビゲーション | SKILL.md | entry file 数十行 | CLAUDE.md 1段落 | hook→loader | CLAUDE.md 1行 |
| 操作手順 | SKILL.md | skill (4) | skill (6) | skill (3+loader) | skill (3) |
| スキーマ定義 | SKILL.md内 | wiki-schema.md | wiki-schema.md | コード(validator) | ページ群 |
| 機械検証 | scripts/ | CLI | （手順内） | コード(validator) | QMD MCP |
| セッション跨ぎ記憶 | （log） | （log） | **domain home** | .wiki-pending/ | master wiki |

→ 本テンプレートの推奨は **B + Cの融合**（entry file + 外部スキーマ + 単一SKILL+references）。Aは「skill非ロード環境で動作不能」リスク、Dは環境固定（Claude Code/Codexプラグイン）を招くため不採用判断の材料。

## 比較軸3: 機械実行の置き場所

- **scripts/（コード）に外出し**: Astro-Han（`check_evidence.py`でGrounding Invariant検証）、toolboxmd（`bin/wiki` + validator）、jackwener（CLI検索・グラフ）
- **skill手順内のみ**: vanillaflava・micuintus（lintは手順として書く）
- 観察: **検証・決定的実行はコード、手順・判断基準はskill**という分担が規模の大きい実装で共通。分担は本wikiと一致（[[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]）。ただし**配置は分岐**: 6事例はroot `scripts/`、本wikiは2026-08-14からskill内同梱（`.agents/skills/llm-wiki-lint/scripts/lint.sh`）に改訂——手順との凝集性・汎用`scripts/`名前空間の衝突回避が理由で、分担原則は維持したままの配置変更

## 比較軸4: 自動化（hooks）の位置づけ

- **skillの範囲外と宣言**: Astro-Han「Automatic hooks and scheduled runs — those belong to the **agent harness**, not a tool-agnostic skill.」→ ツール非依存を守る
- **hooksを全面採用**: toolboxmd（SessionStart/Stop + デタッチドingest + scheduler）、ivankuznetsov（SessionStart + post-commit hook + systemd timer）
- 観察: hooks採用は**プラットフォーム固定（Claude Code/Codex）を許容する実装に多い**。汎用テンプレートとしてはAstro-Hanの線引き（「hooksはskillの範囲外、agent harnessの仕事」）がツール非依存と整合。

## テンプレート設計への示唆

1. **二層設計の独立収束**: jackwener（entry file数十行 + 操作skill）が本wikiの[[AGENTS.md+SKILL.md二層設計]]と同一構造。AMMEに加え外部実装でも実証（2系統目の証拠）
2. **SKILL単独配布（パターンA）は有力な選択肢**: Astro-Han 1.9k★は「skillだけで完結」の需要の大きさを示す。ただしQuick Operations保険（フォールバック）の有無が分岐点（※2026-08-14再評価: Agent Skillsのオープン標準化で保険は不要となり、パターンAの欠点は減衰。[[AGENTS.md+SKILL.md二層設計]]の分担基準参照）
3. **スキーマの外部分離（wiki-schema.md）を採用検討**: 人間編集対象とLLM手順の分離（vanillaflava C）は、本wikiの「AGENTS.mdは人間と共進化」と親和性が高い。テンプレート草案ver.2で検討
4. **MCP併用の実証**: ivankuznetsov（skill→QMD MCP）により「デフォルト不採用・オプション追加可」の拡張パスが確認された。docs/DESIGN.mdのMCP指針に具体例として追記可能
5. **crystallize（file-backの昇格）**: vanillaflavaの`/wiki-crystallize`は[[QueryとFile-back]]のfile-backを一次操作にした設計。テンプレートのFile-back操作の設計参考
6. **残課題**: lucasastorian/llmwiki（808★・MCP-native）とPratiyush/llm-wiki（229★・16 lint規則のコード化）は「機械検証の制度化」のデータ点として別途分析候補（[[このWikiの目的と研究課題]]の既存実装分析TODOに追加）

## 関連

- [[AGENTS.md+SKILL.md二層設計]] — パターンBの概念ホーム
- [[操作層]] — 文書型（skill）vs ツール型（MCP）のスペクトラム
- [[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]] — 本分析のデータ点を反映
- [[リポジトリ分析 microsoft-llmwiki]] — 対極（ツール型）の分析
- [[Schema（AGENTS.md）]] — スキーマの置き場所の設計判断
- [[GitHubリポジトリ分析の方法論]] — 分析方法論
