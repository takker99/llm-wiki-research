---
status: tentatively-adopted
date: 2026-08-14
tags: [template-design, operation-layer, agents-md, skill, mcp]
sources: "[[リポジトリ分析 microsoft-llmwiki]]", "[[AGENTS.md+SKILL.md二層設計]]", "[[操作層]]", "[[テンプレート草案ver.1]]", "[[パイロット分析 横断所見]]"
---

# MCP不採用とAGENTS.md+SKILL.md二層採用の根拠

## 決定の要旨

本テンプレートの[[操作層]]は、MCPサーバ等のツールではなく **AGENTS.md + SKILL.md + scripts/ の文書構成**で提供する。
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

- **推奨構成（3層同梱）**: AGENTS.md（4-6KB自己完結・Quick Operations内蔵）+ `.agents/skills/llm-wiki/SKILL.md`（完全手順）+ root `scripts/lint.sh`（決定的実行）。GitHub Template Repositoryとして配布し、クローンだけでopencode/Codex/Cursor/Geminiでskill有効（Claude Codeのみ1コマンド）
- **lint.shはskill内に移さない**: root直下+自己相対パス方式を継承（skill非ロード環境から到達不能になるため）。grasp（root `scripts/` + skill）が実証前例
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
├── scripts/lint.sh               # 決定的実行（root直下・自己相対パス方式）
├── wiki/                         # 空カテゴリスケルトン + index/log/overview
├── raw/.gitkeep
├── examples/demo-vault/          # 完成サンプル（10-15ページ）
└── docs/DESIGN.md                # 設計判断の記録 + MCP拡張指針（一節数行）
```

3層ともrepoに同梱・コミット済み（配布物の単一性）。AGENTS.md単体でも完全運用可能（フォールバック）。
lint.shはskillの有無と無関係に動作。

## 残課題

- [ ] 自己適用実験: 本wikiの操作手順のみをskill化し差分を計測（[[このWikiの目的と研究課題]]にTODO化）
- [ ] MCP版設計指針（どの検証を機械化するか）は需要が生じたらdocs/DESIGN.mdへ
- [ ] llm-wiki.app・各種CLIツールの分析（既存TODO）

## 関連

- [[リポジトリ分析 microsoft-llmwiki]] — 参照点となったMCP実装の分析
- [[操作層]] — 文書型 vs ツール型のスペクトラム
- [[AGENTS.md+SKILL.md二層設計]] — 二層パターンの発見元（AMME）
- [[テンプレート草案ver.1]] — claim#9として追記
- [[パイロット分析 横断所見]] — 運用repo5件の横断比較
- [[LLM WikiテンプレートのOptionality]] — デフォルト不採用・オプション追加可の哲学
