---
raw:
  - raw/github-jackwener-llm-wiki.md
source_url: https://github.com/jackwener/llm-wiki
accessed: 2026-08-14
tags: [template-design, skill, implementation, repos]
---

# 2026-08-14 SKILL併用LLM Wiki: jackwener llm-wiki (github)

**AGENTS.md+SKILL.md二層設計の純粋な実装版**。CLIはscaffoldのみでLLMを呼ばず、操作は全てskill（agent）に委ねる。95 stars / Apache-2.0。

## 要点

1. **「ツール自身はLLMを呼ばない」原則**: CLI（`llm-wiki init`等）はvault作成とskillインストールのみ。wiki運用は全てagentがskillで行う。ツール型（[[Microsoft llmwiki]]のMCP）と文書型のハイブリッドだが、知能の所在はagent側。

2. **二層の役割分担が明示的**（このWikiの[[AGENTS.md+SKILL.md二層設計]]と同構造）:
   - **Entry files**（`CLAUDE.md` / `AGENTS.md`、数十行）: セッション起動時に自動ロード。「vaultであること・どこに何があるか・どのskillをloadするか・CLI cheat-sheet・コア運用規則」。**意図的に小さく**（session-start context節約）。
   - **Operation skills**（`.claude/skills/{ingest,query,lint,research}/SKILL.md`）: オンデマンドロードの手順書。page schema・frontmatter規則・invariant（ソース不変性等）。
   - 発見はAgent Skills spec準拠で、**`.claude/skills/`と`.agents/skills/`の両方にインストール**しマルチプラットフォーム対応。

3. **4操作 = ingest / query / lint / research**。research（外部検索→ソース保存→ingest→レポート）を一級操作にした点が特徴。

4. **スキーマを外部ファイルに分離**: `wiki-purpose.md`・`wiki-schema.md`（page type・命名・frontmatter規則）をvault直下に配置し、entry fileはその場所を指すだけ。

5. **CLIによる検索・グラフ分析の追加**: BM25検索（CJK bigram対応）、wikilinkグラフ分析（コミュニティ/ハブ/孤立/wanted）、DB9（PostgreSQL）によるハイブリッド検索（RRF融合）はオプション。

## 触れている概念

- 概念: [[AGENTS.md+SKILL.md二層設計]] / [[操作層]] / [[Schema（AGENTS.md）]] / [[LLM Wikiのスケーラビリティ]] / [[赤リンクとLLM Wiki]]（wanted pages）
- 実体: [[Agent Skills]] / [[Obsidian]] / [[Microsoft llmwiki]]（対比）
