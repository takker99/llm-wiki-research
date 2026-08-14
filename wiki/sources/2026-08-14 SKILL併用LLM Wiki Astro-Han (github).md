---
raw:
  - raw/github-Astro-Han-karpathy-llm-wiki.md
source_url: https://github.com/Astro-Han/karpathy-llm-wiki
accessed: 2026-08-14
tags: [template-design, skill, implementation, repos]
---

# 2026-08-14 SKILL併用LLM Wiki: Astro-Han karpathy-llm-wiki (github)

単一`SKILL.md`でKarpathyパターンを完結させる**バニラskill実装**。1.9k starsとSKILL形式で最も支持された事例。README + SKILL.md全文をアーカイブ。

## 要点

1. **SKILL.mdが3層アーキテクチャの「Schema層」そのもの**: `raw/`・`wiki/`・**SKILL.md（this file）— Schema layer** と定義。KarpathyのAGENTS.md相当の役割をSKILL.mdが担う。CLAUDE.md/AGENTS.mdを生成せず、skill単独で完結（[[Schema（AGENTS.md）]]の役割をskillが吸収した形）。

2. **Design Boundaries（設計の境界宣言）が精緻**: 3ヶ月の運用ログ + エコシステム調査の結果、以下を**意図的に作らない**と明言: hooks・MCPサーバ・ベクトル検索・数値信頼度スコア・定期レビュー日・アクセス減衰・ソースハッシュ追跡。
   - 「Automatic hooks and scheduled runs — those belong to the **agent harness**, not a tool-agnostic skill.」
   - 「MCP servers, UIs, output subsystems — outside the boundary of a tool-agnostic skill.」
   - 「Vector or graph search — at 50K–100K tokens of curated wiki, grep and read are more reliable.」
   → skillの範囲を「手順の文書化」に限定し、自動化はエージェント側（harness）の仕事と線引きする設計哲学。

3. **Grounding Invariant（接地不変条件）**: 「wiki/の全重大事実（数値・日付・引用）はraw/に逐語存在する」。compile時のlocate-before-writeで確立し、`scripts/check_evidence.py`（高信号リテラルをgrep）でlint検証。機械チェックだけはscripts/に外出し。

4. **triage（取捨）の制度化**: 新規/更新/異議（Disputed）/無素材（No material）の4区分。無素材ならraw/に置いたまま記事を作らない。「薄いソースから記事を無理に作るな」。

5. **Cascade Updates**: 索引だけでなくwiki全体をキーワード検索して波及更新。矛盾・陳腐化は**歴史を消さずStatusブロック**（Outdated/Disputed）で標示。

6. **利用統計**: 2026年4月から毎日運用中の知識ベースで記事94/ソース99/直近7日でlog 87件。

## 触れている概念

- 概念: [[Schema（AGENTS.md）]] / [[操作層]] / [[AGENTS.md+SKILL.md二層設計]] / [[Lint]] / [[LLM Wikiの作文リスク]] / [[赤リンクとLLM Wiki]]
- 実体: [[Agent Skills]] / [[OKF]] / [[Microsoft llmwiki]]（対極として）
