---
raw:
  - raw/opencode-docs-agent-skills.md
source_url: https://opencode.ai/docs/skills/
accessed: 2026-08-14
tags: [template-design, skill, operation-layer]
---

# 2026-08-14 opencode Agent Skills仕様

opencodeのAgent Skills仕様。**skillのロードタイミングと常駐コスト**を規定する文書で、AGENTS.md/SKILL.md分担の設計根拠になる。

## 要点

1. **2段構えのロード**: `<available_skills>`（各skillの `name` + `description` のみ）が常に`skill`ツールのdescriptionとして提示される。本文はagentが`skill`ツールを呼んだ時のみ注入。

2. **ロードはagentの自律判断**: "The agent loads a skill by calling the tool: `skill({ name: "git-release" })`"。ユーザーがskill名を明示する必要はなく、ターン途中でも発動可能。トリガーは決定的マッチングではなく**LLMの想起**。

3. **descriptionが唯一の発動材料**: "Keep it specific enough for the agent to choose correctly"（1-1024文字）。descriptionの質がトリガー信頼性のすべて。

4. **常駐コストはname+descriptionのみ**: 本文はロード時のみのコスト。[[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]の「frontmatter約100トークン/skill常駐」の実体。

5. **発見パス**: `.opencode/`・`.claude/`・`.agents/` の3系統（プロジェクト/グローバル）。Agent Skillsオープン標準化後も発見パスは複数残る。

## 触れている概念

- 概念: [[AGENTS.md+SKILL.md二層設計]] / [[操作層]] / [[Schema（AGENTS.md）]]
- 実体: [[Agent Skills]]
