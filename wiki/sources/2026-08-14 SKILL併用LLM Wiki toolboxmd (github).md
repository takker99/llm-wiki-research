---
raw:
  - raw/github-toolboxmd-karpathy-wiki.md
source_url: https://github.com/toolboxmd/karpathy-wiki
accessed: 2026-08-14
tags: [template-design, skill, implementation, repos]
---

# 2026-08-14 SKILL併用LLM Wiki: toolboxmd karpathy-wiki (github)

**hooks + デタッチドバックグラウンドingester**で運用を自動化するプラグイン型。4スキル分割 + SessionStart hookによるloader自動注入。98 stars / MIT。

## 要点

1. **4スキル分割 + loaderパターン**:
   - `using-karpathy-wiki/SKILL.md`: **loader**。SessionStart hook経由で毎セッション自動注入（`hookSpecificOutput.additionalContext`）。iron laws・トリガー定義・他3スキルへのポインタのみ。
   - `karpathy-wiki-capture/SKILL.md`: メインagent用・オンデマンド。会話からのdurable知識をcaptureファイルとして書くプロトコル。
   - `karpathy-wiki-read/SKILL.md`: メインagent用・オンデマンド。**6段階のdeterministicな方向付けラダー**（orient → 候補数え → ≤5件はinline-read / 6+件はExplore subagent / 冷えた結果はweb検索 → cite）。Iron Rule 4: どんな質問にもwiki方向付けなしで答えてはならない。
   - `karpathy-wiki-ingest/SKILL.md`: **デタッチドingester専用**。深い方向付け(1-9)・ページ形式・validator契約・manifest・commitプロトコル。
   - サブagentとspawned ingesterは必要な面だけを受け取る（**surface最小化**）。

2. **非同期パイプライン**: capture → `<wiki>/.wiki-pending/` → dispatcherが原子的にclaim → デタッチド`claude -p`（またはCodex/Grok）がingest → ページロック付き編集 → validator → auto-commit。フローを遮断しない（`nohup &`思想）。

3. **SessionStart/Stop hooks**: hookがloader注入・ingesterガード・dispatcher tick実行。activationは `session_start` と `scheduled`（macOS LaunchAgent）の2モード。

4. **provider対応の一般化**: grok / claude / codex のモデル選択・フォールバックプロファイル・`--max-budget-usd`的コスト管理・heartbeat・retry。**モデルIDをハードコードしない**（MicrosoftのCopilot必須と対極）。

5. **Tier-1 lintを毎ingest時に実行**: 必須frontmatter・リンク解決・ソース存在・type/path一貫性。検証はコード（validator）で行い、skillは契約を記述する。

6. **SKILL.mdはobra/superpowers-skillsの技法で書かれている**（writing-skills等）— skill自身の書き方にメタ技法を適用。

## 触れている概念

- 概念: [[操作層]] / [[AGENTS.md+SKILL.md二層設計]] / [[Post-ingestレビューループ]]（自動化との緊張） / [[QueryとFile-back]]
- 実体: [[Agent Skills]] / [[Microsoft llmwiki]]（両者とも自動化志向だが実現手段が異なる）
