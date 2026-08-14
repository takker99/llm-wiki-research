---
raw:
  - raw/github-micuintus-llm-wiki.md
source_url: https://github.com/micuintus/llm-wiki
accessed: 2026-08-14
tags: [template-design, skill, implementation, repos]
---

# 2026-08-14 SKILL併用LLM Wiki: micuintus llm-wiki (github)

**最小の純skill**（SKILL.md ~6KB + lazy-loaded references）。「patternを欲しい人」向けで、CLI・サーバ・プラグイン一切なし。22 stars / MIT。READMEに**エコシステム比較表**（9 repo）を含む点が重要。

## 要点

1. **純skill設計**: `SKILL.md`が唯一の常時ロードファイル（~6KB）。他は全てlazy-loaded（skill本文にパス参照で書かれ、必要になるまで読み込まれない）。「Conventions live in the skill text, not in code」— 規約の執行をコードでなくskillテキストで行う。

2. **比較表で見るSKILL実装のスペクトラム**（README「Related work」）:
   - Skill型: Astro-Han（651★単一SKILL）・toolboxmd（66★ hooks駆動）・balukosuri（125★記事+実装）・lewislulu（447★ SKILL+Obsidian監査プラグイン+web viewer）
   - CLIツール型: lucasastorian/llmwiki（808★ **MCP-native**、ClaudeをMCP接続）・Pratiyush/llm-wiki（229★ 2,651テスト・16 lint規則・MCPサーバ・Playwright E2E）
   - その他: Kausik-A/pi-llm-wiki（9★ Pi-native、コードでガードレール執行）・yologdev（43★ self-growing、コミット=agentの仕事）・hsuanguo（11★ SKILL+Python scaffold）
   - 観察: 同じ3層基盤を持ちながら **shape（agentがどう消費するか）と weight（ツール同梱量）で差別化**。純skill ↔ 完全ソフトウェアのスペクトラム。

3. **ユースケース**: 読書（章要約・キャラ/概念ページ）・複数論文の研究（矛盾の顕在化）・エコシステムマッピング・自プロジェクト文書化。

4. **lazy-loaded subskill**: webチャットingest（Claude.ai/ChatGPT/Gemini/Le ChatをCDPで取得）は別subskill化。

## 触れている概念

- 概念: [[操作層]] / [[AGENTS.md+SKILL.md二層設計]] / [[LLM WikiテンプレートのOptionality]]（shape×weightの分離）
- 実体: [[Agent Skills]] / [[Microsoft llmwiki]]（スペクトラムの対極） / [[lucasastorian/llmwiki]]（MCP-native、分析候補）
