---
raw:
  - raw/github-vanillaflava-llm-wiki-skills.md
source_url: https://github.com/vanillaflava/llm-wiki-skills
accessed: 2026-08-14
tags: [template-design, skill, implementation, repos]
---

# 2026-08-14 SKILL併用LLM Wiki: vanillaflava llm-wiki-skills (github)

**6スキル構成**のLLM Wiki実装。crystallize（セッション蒸留）を一級操作にした点と、プライバシー論が特徴。59 stars / MIT。

## 要点

1. **6スキル = config / ingest / query / lint / integrate / crystallize**:
   - `wiki-config`: 初回scaffold生成（wiki-config.md・wiki-schema.md・wiki-help.md・Home/Overview・index/log・raw/ingested・**13ページテンプレート**）。最小セットは config + ingest + query。
   - `wiki-crystallize`: **セッション管理機構**。長い作業セッションから durable signal（決定・発見・未解決質問）をwikiページに蒸留。毎セッション末に実行し、次のセッションはchat scrollbackでなくwikiページから始まる。Karpathyの「良い回答はfile-backせよ」を一次操作に昇格。
   - `wiki-integrate`: 新規・更新ページをバックリンクとindexエントリで知識グラフに編み込む。

2. **状態管理 = ファイルシステム**: ソースは`raw/`→ingest成功で`ingested/`へ移動（＝コミット）。`log.md`は監査専用で、処理済み判定は`ingested/`の存在で行う（再ingestしても害なし）。

3. **信頼性評価をfrontmatterに**: `source:`（由来追跡）+ `reliability:`（high/medium/low、ingest時にagentが評価）。低信頼ソース由来のページには`## Pending Review`節を付けて具体的な裏取り対象を標示。強いソースを入れて再ingestすると節が消える。

4. **3層セッションブートストラップ**（永続指示 → プロジェクト指示 → domain home）: 
   - 第1層: プラットフォーム恒久指示（Personal Preferences等）— 個人のスタイル・制約。ドメインで変わらない。
   - 第2層: プロジェクト指示（CLAUDE.md等）— どのドメインか + 「domain homeを先に読め」。
   - 第3層: **domain home（wikiのハブページ）** — 何をやっているか・前回の決定・未解決事項。
   - 「恒久指示=誰であるか、プロジェクト指示=どのドメインか、domain home=どこまで進んだか」。wikiは**セッションサイクリングを生き残る記憶**であり、指示層が新しいagentを軌道に載せる。

5. **プライバシー論**: skillは純文書だが「ローカル=非公開」ではない。agentが読む全ファイルはLLMプロバイダーに送られる。filesystem MCPのスコープをwiki rootに限定すること、blacklistは書込み防止のみで**読み取りの境界ではない**こと、MCP自体のテレメトリ確認を警告。

6. **スキーマ・設定の外部分離**: `wiki-config.md`（blacklist・ingestedフォルダ等）+ `wiki-schema.md`（必須/条件付きフィールド・enum定義）をvault直下に配置し、6スキル全てがboot時に読む。テンプレート（13種）は`templates/`に置きユーザー編集可能。

## 触れている概念

- 概念: [[AGENTS.md+SKILL.md二層設計]] / [[操作層]] / [[QueryとFile-back]] / [[Lint]] / [[読まれなくてよい中間産物]]
- 実体: [[Agent Skills]] / [[Obsidian]] / [[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]（プライバシー論が関連）
