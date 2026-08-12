---
date: 2026-08-12
tags: [template-design, agents-md, skill, pilot-finding]
sources: "[[リポジトリ分析 AMME-2026S-report]]", "[[パイロット分析 横断所見]]"
---

# AGENTS.md+SKILL.md二層設計

AGENTS.mdを「スキーマ定義書」に純化し、操作手順をすべてskill（SKILL.md）に委譲するパターン。
AMME-2026S-reportで発見され、AGENTS.md 1.9KBを実現した中核技術。

## 構造

```
AGENTS.md（1.9KB）
├── アーキテクチャ定義（3層構造）
├── ディレクトリ構造一覧
├── 命名規約
├── Quick Operations Summary（保険: skill非ロード時用）
├── 禁止事項
└── 「詳細は llm-wiki skill を読め」

.agents/skills/llm-wiki/SKILL.md（3.7KB）
├── Ingest 完全手順
├── Query 完全手順
├── Lint 完全手順
└── File-back 判断基準
```

## なぜこれが機能するか

1. **責務分離**: AGENTS.md = What（何をすべきか）、SKILL.md = How（どうやるか）
2. **耐障害性**: Agentがskillをloadできなくても、Quick Operations Summaryで最低限動作
3. **コンテキスト節約**: AGENTS.mdが薄いほど、毎回のコンテキスト消費が少ない
4. **LLMの事前知識への依存**: Ingest/Query/Lintの概念自体は説明不要。AGENTS.mdは「このプロジェクト固有の差分」だけ書けばよい

## 限界

skillは「操作手順」の外部化には有効だが、「ドメイン知識の構造化」の外部化には限界がある。
BDL-2026Sはskill（.agents/ 4件）を持ちながら15.8KBに達しており、
SSOT分配設計のようなドメイン特化知識はskillでは吸収しきれない。

## テンプレート設計への示唆

**skill同梱か否かがテンプレート配布形式の最初の設計判断になる。**

- skill同梱: AGENTS.mdを1.5KB程度まで薄くできる。ただしskillの配布・管理方法が課題
- skill非同梱: AGENTS.mdに操作手順を含める必要がある（5-8KB）。自己完結的で配布は容易

汎用テンプレートでは「最小AGENTS.md + オプショナルskill」の構成を推奨。
Quick Operations Summaryを保険として残すことで、skillがない環境でも最低限動作する。

## 関連

- [[リポジトリ分析 AMME-2026S-report]] — 発見元
- [[Schema（AGENTS.md）]] — AGENTS.mdの薄さの限界
- [[Agent Skills]] — Anthropicのskill概念
- [[GitHubリポジトリ分析の方法論]]
