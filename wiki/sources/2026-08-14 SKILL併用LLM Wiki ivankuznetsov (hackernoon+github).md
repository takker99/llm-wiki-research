---
raw:
  - raw/hackernoon-ivankuznetsov-6プロジェクトの知識ベース構築.md
  - raw/github-ivankuznetsov-llm-wiki.md
source_url: https://hackernoon.com/how-i-built-a-self-maintaining-knowledge-base-for-6-projects-using-claude-code-and-karpathys-llm-wiki
accessed: 2026-08-14
tags: [template-design, skill, implementation, practice]
---

# 2026-08-14 SKILL併用LLM Wiki: ivankuznetsov 6プロジェクト運用 (hackernoon+github)

**SKILLとMCPを併用した実運用事例**（HackerNoon記事 + そのスキルパッケージrepo）。Claude Code + QMD(MCP) + wiki-researcher SKILL + /plan commandで6プロジェクトを運用。

## 要点

1. **4層システム**: プロジェクト別wiki（各repoの`wiki/`）→ post-commit hook（コード変更でwiki自動更新）→ QMD検索（セマンティック検索）→ master wiki（`~/wikis/master/`、共通パターン集約）。2時間毎の同期タスク + 週次監査 + 月次フル同期（systemd timer）。

2. **CLAUDE.mdの役割 = 1行のトリガーが肝**:
   > "Always check wiki/ before answering questions about this project's architecture, patterns, or decisions."
   この1行がないとClaudeはwikiを能動的に見ない。残り（構造説明・セッション末の保存指示・検索プロトコル・gaps.md記録）は補助。

3. **SessionStart hook**: セッション開始時 + /clear後に`wiki/index.md`先頭60行と`wiki/log.md`末尾15行をcontextへ注入（→ [[IndexとLog]]の実装版）。

4. **wiki-researcher SKILL + QMD MCPの併用**: skillはQMDのMCPツールを呼んでプロジェクトwiki+master wikiを検索し「Past Knowledge」節（重要決定・適用可能パターン・既知バグ・再利用部品・ギャップ）を生成。`/plan` commandがwiki研究 → CE（Compound Engineering）プランニングへ委譲。
   → **SKILL（文書）とMCP（ツール）は排他でなく、skillがMCPツールを呼ぶ形で併用できる**実証。

5. **コスト管理**: `--max-budget-usd`（$0.50/call上限）・`--allowedTools`（read/writeのみ）・`--bare`（hooks/MCPをスキップ）・`nohup &`でバックグラウンド。月$10-20/6プロジェクト。

6. **ブートストラップ5段階**: データモデル → ルート/コントローラ（trivial CRUDはスキップ指示） → アーキテクチャ/パターン（3種のgit log選別） → ギャップ分析（gaps.md） → プラン/タスク（最初スキップは失敗だった）。21モデルで25ページ/10分。サブagent並列で4プロジェクト25分。

7. **QMDの位置づけ**: 100ページ未満ならripgrepで十分、と明言。QMDのセマンティック検索は「正確な用語を知らない」クエリで効く。192ページ/388 chunks/7 collections。

## 触れている概念

- 概念: [[Wikiとコードリポジトリの関係]]（master wiki） / [[操作層]] / [[QueryとFile-back]] / [[Lint]] / [[Post-ingestレビューループ]] / [[バッチIngest]]
- 実体: [[qmd]] / [[Agent Skills]] / [[Microsoft llmwiki]]（MCP併用の対照例）
