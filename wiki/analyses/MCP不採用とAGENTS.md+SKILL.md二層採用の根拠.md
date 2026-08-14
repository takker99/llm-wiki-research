---
status: tentatively-adopted
date: 2026-08-14
tags: [template-design, operation-layer, agents-md, skill, mcp]
sources: "[[リポジトリ分析 microsoft-llmwiki]]", "[[AGENTS.md+SKILL.md二層設計]]", "[[操作層]]", "[[テンプレート草案ver.1]]", "[[パイロット分析 横断所見]]"
---

# MCP不採用とAGENTS.md+SKILL.md二層採用の根拠

## 決定の要旨

本テンプレートの[[操作層]]は、MCPサーバ等のツールではなく **AGENTS.md + skill（SKILL.md + 同梱スクリプト）の文書構成**で提供する。
MCPは**デフォルト不採用・オプション追加可**（[[LLM WikiテンプレートのOptionality]]哲学に整合。絶対に使わない、ではない）。

- 参照点: [[リポジトリ分析 microsoft-llmwiki]]（MCP 14ツール+VS Code拡張のガチガチ構成）
- subagent相談2往復（2026-08-14）の検証を経て決定
- 定量データの出典: subagentによるrepo実測（`~/git/llm-wiki-samples/microsoft-llmwiki@b44df6ae`）+ 公開情報（Anthropic/GitHub/agentskills.io）。raw/コピーなし

## 背景

microsoft/llmwikiはMCPサーバ14ツール + VS Code拡張 + npmパッケージのmonorepoで、
操作層をソフトウェアとして完全実装した先鋭例。本テンプレートは「ツール非依存・環境非依存・手軽に始められる」を目標とし、対極の選択をする。

## 自己質問（判断の深化プロセス）

1. **MCPのcontext圧迫とは具体的に何か** → ツール定義（name+description+inputSchema）の**毎ターン固定コスト**。SKILL.mdはオンデマンドロード。対比は「常時常駐 vs オンデマンド」
2. **128K-1M contextの時代に大した問題か** → 汎用テンプレートはユーザーのモデルを選べない。固定コストは実効contextを恒常的に削る
3. **context以外のデメリット** → セットアップコスト・環境依存・保守・透明性低下。Microsoft自身の「Why git repo: ゼロインフラ・Markdown普遍性」とも緊張関係
4. **MCPの利点（決定的実行・検証・メトリクス）を捨ててよいか** → 「文書指示でどこまで代替できるか」の問題に変換
5. **SKILL.mdは本当に「中間」か** → スペクトラム: 薄いAGENTS.md → 厚いAGENTS.md → **二層** → 文書+MCP → 完全ソフトウェア
6. **薄いAGENTS.md単層ではダメか** → テンプレート利用者は操作手順がなければ動けない。「薄さの美学」と「手順の配布」の両立が二層の動機
7. **中間に固有のリスク** → 形式の環境間非互換・skill非ロード環境での動作不能・決定的実行の再現不能
8. **表現は「不採用」でよいか** → Optionality哲学では「デフォルト不採用・オプション追加可」が正確

## subagent相談の検証結果

### 1往復目（判断の検証）

- ✅ **context圧迫は実在する（実測）**: 14ツール定義は6.3KB≈1.6〜2.0Kトークン/ターン常駐。ただし**単独wikiサーバとしては軽微**。実害の主座は他MCPサーバとの集約・注意容量・キャッシュ無効化
- ⚠ **修正1: SKILL.mdも「ゼロコスト」ではない**: frontmatter（name+description）約100トークン/skillが常駐。「1.6-2K vs ~100/skill + 本文オンデマンド」の差
- ⚠ **修正2: 「MCP=環境依存」は2026年で減衰**: MCPはLinux Foundation傘下で標準化が進み、主要クライアントは概ね対応。むしろSKILL.mdの**発見パス**（`.claude/` vs `.agents/` vs `.cursor/`）が環境依存に
- ✅ **2026年で議論の土台が激変**: Agent Skillsは2025-12-18にオープン標準化（agentskills.io、40+プラットフォーム）。形式は互換。発見パスは`.agents/skills/`へ集約進行（唯一の例外: Claude Codeは`.claude/skills/`のみ）
- ✅ **自己不整合ではない**: 本wikiの厚さ（AGENTS.md 8.7KB）は研究ルール=ドメイン知識が主成分で、操作手順のskill化だけでは薄まらない（BDL型）。「薄さの実証はAMME（1.9KB）由来の外部データ点、自己適用は厚さ側のデータ点」と明文化すべき
- 📌 **独立収束の観察**: MicrosoftもMCP内にオンデマンドのprompt層（ingest-and-integrate / lint-and-fix / research-topic）を持ち、「常時軽い定義+オンデマンド手順」の階層化は二層設計と同構造。差分は常時常駐メカニズムのコストのみ

### 2往復目（配布の具体化）

- **推奨構成**: AGENTS.md（4-6KB自己完結・常時行動内蔵 ※Quick Operations内蔵は2026-08-14に見直し、[[AGENTS.md+SKILL.md二層設計]]参照）+ `.agents/skills/llm-wiki/SKILL.md`（完全手順）+ skill同梱の決定スクリプト（`.agents/skills/llm-wiki-lint/scripts/lint.sh`）。GitHub Template Repositoryとして配布し、クローンだけでopencode/Codex/Cursor/Geminiでskill有効（Claude Codeのみ1コマンド）
- **lint.shは対応するskillのディレクトリ内に同梱**（2026-08-14改訂。下記「改訂: スクリプトの配置」参照）。手順（SKILL.md）と決定スクリプトの凝集性が高まり、汎用root `scripts/`名前空間の衝突（既存コードrepoへの埋め込み時のdev用スクリプトとの混在・`scripts/lint.sh`の曖昧さ）を避ける。grasp（root `scripts/` + skill）は実証前例のままだが、配置の規範ではない
- **明示パス参照が主契約**: AGENTS.mdに「`.agents/skills/llm-wiki/SKILL.md` を読め。ロードできない場合はファイルを直接読め」と書く。auto-discoveryはボーナス、トリガー構文（`$skill`等）はクライアント方言なのでオプション
- **1.9KBは売りにしない**: AMMEの1.9KBはドメイン薄型（数学レポート・raw 5ファイル）の特殊条件。二層の価値は**メンテナンス性**（手順編集が基幹スキーマを汚さない・人間がAGENTS.mdをスキーマとしてレビュー可能・形式は標準化済み）で主張し、context削減はボーナス表記にとどめる
- **決定打**: OpenAI自身がAGENTS.md+`.agents/skills/`+scripts構成を公式OSS運用（openai-agents-python/js）に採用。文書+skill構成が世界最大級で検証済み
- **MCP版設計指針**: docs/DESIGN.mdに一節数行だけ書く価値あり（それ以上は過剰設計=「事前にやろうとしない運用哲学」違反）

## 最終決定と理由（複合的理由）

当初の「context圧迫」は主理由から降格する。単独サーバでは軽微（実測1.6-2Kトークン）のため。

主理由（複合）:
1. **集約環境でのcontext加算** — ユーザー環境の他MCPサーバと集約された時に実害（93ツール=55Kトークンの公開実測例）
2. **セットアップ障壁** — MCPサーバ設定・依存・保守コスト。テンプレート目標の「手軽に始められる」に反する
3. **環境非依存の維持** — モデル/IDEを縛らない（MicrosoftはCopilot必須・VS Code固定）。「ゼロインフラ・Markdown普遍性」の価値観に整合
4. **透明性・可読性** — AGENTS.mdは読めば全部見える。ツールは実行時にブラックボックス
5. **文書+skill+scriptsで代替可能** — 決定的検証（lint機械チェック）はscripts/で、手順の一貫性はSKILL.mdで。決定的書込（index upsert等）だけは再現不能だが、単一ローカルユーザーでは脅威モデルが弱く、lint+gitで検出・修復可能（「予防するMCP vs 検出+修復する文書」のどちらでも運用は成立）

## 推奨構成（ファイルツリー案）

```
llm-wiki-template/                # GitHub Template Repository
├── AGENTS.md                     # 第1層: スキーマ定義 + Quick Operations + skill明示パス参照（4-6KB）
├── README.md                     # 冒頭「3分で始める」。Claude Codeユーザーへの1コマンド案内
├── .agents/skills/llm-wiki/      # 第2層: 完全手順（Ingest/Query/Lint/File-back）
│   ├── SKILL.md
│   └── references/
├── .agents/skills/llm-wiki-lint/scripts/lint.sh  # 決定的実行（skill同梱・自己相対パス方式）
├── wiki/                         # 空カテゴリスケルトン + index/log/overview
├── raw/.gitkeep
├── examples/demo-vault/          # 完成サンプル（10-15ページ）
└── docs/DESIGN.md                # 設計判断の記録 + MCP拡張指針（一節数行）
```

3層ともrepoに同梱・コミット済み（配布物の単一性）。AGENTS.md単体でも完全運用可能（フォールバック）。
lint.shは明示パス参照によりskillロードの有無と無関係に実行可能。

※2026-08-14見直し: 「AGENTS.md単体でも完全運用可能」の保険（Quick Operationsサマリ）は不要と判断（Agent Skillsのオープン標準化でskill非対応環境が消滅。[[2026-08-14 opencode Agent Skills仕様]]）。AGENTS.mdの役割は「常時行動 + スキーマ + 明示パス参照1行」に純化。分担基準は [[AGENTS.md+SKILL.md二層設計]] 参照。

## 残課題

- [ ] 自己適用実験: 本wikiの操作手順のみをskill化し差分を計測（[[このWikiの目的と研究課題]]にTODO化。※lintは2026-08-14に実施済み: 手順を`.agents/skills/llm-wiki-lint/SKILL.md`へ・スクリプトを同ディレクトリへ移動。ingest等の他操作は未実施）
- [ ] MCP版設計指針（どの検証を機械化するか）は需要が生じたらdocs/DESIGN.mdへ
- [ ] llm-wiki.app・各種CLIツールの分析（既存TODO）— SKILL併用6事例のサーベイでlucasastorian/llmwiki（808★・MCP-native）とPratiyush/llm-wiki（229★・16 lint規則のコード化）が候補として判明（[[リポジトリ分析 SKILL併用6事例]]）

## 2026-08-14追記: SKILL併用実装による外部データ点

[[リポジトリ分析 SKILL併用6事例]]のingestで得られた追証:

- **SKILLの起動トリガーをhookに移すD型（toolboxmd）**はプラットフォーム固定を許容する実装に限られ、汎用テンプレートの「文書（description frontmatter）+ 明示パス参照」方針（2往復目で決定）と整合
- **Astro-Han（1.9k★）が「MCP servers, UIs, output subsystems — outside the boundary of a tool-agnostic skill」「hooks belong to the agent harness」をDesign Boundariesで明言**。本決定と同一の線引きを独立収束で採用
- **ivankuznetsovはskillがQMDのMCPツールを呼ぶ併用で実運用成功**。「デフォルト不採用・オプション追加可」の拡張パスが具体例として確認できた。docs/DESIGN.mdに一節書く際の実例に
- **全6実装が「検証・決定的実行はコード（scripts/CLI）、手順はskill」**を共通採用。本推奨構成（決定スクリプトを保持）の独立収束。配置は6事例がroot `scripts/`で本wikiはskill内同梱に改訂（2026-08-14）——分担原則は配置を規定しない

## 2026-08-14改訂: lint.shの配置をskill内同梱に変更

初期決定（2往復目）の「lint.shはskill内に移さない」を撤回し、`.agents/skills/llm-wiki-lint/scripts/lint.sh`へ移動した（本wiki + template 両方に自己適用）。

- **撤回の根拠**: 初期決定は「skill非ロード環境から到達不能」を理由に挙げたが、これはauto-discoveryとfile-reachabilityの混同だった。同一決定内で「明示パス参照が主契約」と宣言しており、AGENTS.mdがパスを明示すればスクリプトはskillロードの有無と無関係にファイルとして実行可能（`bash .agents/skills/llm-wiki-lint/scripts/lint.sh`）
- **新配置の利点**: ①手順（SKILL.md）と決定スクリプトの凝集性（lint.shの出力解釈はSKILL.mdに定義） ②root `scripts/`名前空間の解放——既存コードrepoに埋め込む場合のdev用スクリプトとの衝突・`scripts/lint.sh`の曖昧さを回避 ③skill単位の移植性
- **6事例との関係**: 「検証・決定的実行はコード」の分担原則は維持（配置を規定しない）。6事例のroot `scripts/`配置は記述的な観察であり規範ではない
- 初期決定の文言は「撤回」としてこの節に記録（バイアス顕在化）。log.md 2026-08-14エントリも参照

## 関連

- [[リポジトリ分析 microsoft-llmwiki]] — 参照点となったMCP実装の分析
- [[リポジトリ分析 SKILL併用6事例]] — SKILL併用実装6件の横断比較（2026-08-14追証）
- [[操作層]] — 文書型 vs ツール型のスペクトラム
- [[AGENTS.md+SKILL.md二層設計]] — 二層パターンの発見元（AMME）
- [[テンプレート草案ver.1]] — claim#9として追記
- [[パイロット分析 横断所見]] — 運用repo5件の横断比較
- [[LLM WikiテンプレートのOptionality]] — デフォルト不採用・オプション追加可の哲学
