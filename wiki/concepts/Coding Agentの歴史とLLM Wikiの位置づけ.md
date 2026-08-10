---
sources: "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]"
tags: [template-design, llm-wiki-pattern]
---

# Coding Agentの歴史とLLM Wikiの位置づけ

nishioが整理した、Coding Agentの進化史におけるLLM Wikiの位置づけ。LLM WikiをAgent Skillsの一般化として捉える視点。

## 6段階の進化

1. **小コンテキスト時代**（〜2021）: GitHub Copilot technical preview。短い補完のみ
2. **大コンテキスト＋Lost in the Middle**（2023）: Claude 100K発表→「迷子になる」問題
3. **コンテキストを使い切る時代**（2024前半）: Claude 3、Devin。ただしコンパクションで過去記憶がぼんやり
4. **コンテキスト外部化の模索**（2024後半）: Devin Knowledge、PLAN.md運用。知識をコンテキスト外に保存
5. **手続き的知識の外部化**（2025）: Agent Skills。Markdownをindexに使ってAgentic Retrieval。why/whatよりhowにフォーカス
6. **LLM Wiki = 水平移動**（2026）: 同じMarkdown+Agentic Retrievalのメカニズムをスキル（how）に限定せず、what/whyも含めて広く使う発想

## LLM Wikiの独自性

Agent Skillsとの対比:
- Skills: howの知識（手続き）にフォーカス
- LLM Wiki: why/what/howすべてを扱う
- PLAN.mdは「何を作るか（what）を忘れない」アプローチだったが、LLM Wikiはそれを構造化・永続化する

## nishioの総括

> 「CLAUDE.mdに全部のノウハウを書くのではなくSKILLS.mdをindexとして個別の知識に振る」という構造を、PLAN.mdに応用したものが可能なはず。LLM Wikiはそれを実現している。

## 関連概念

- [[コンテキスト外部化の歴史]] — 段階4以降の詳細
- [[Wiki駆動開発]] — LLM Wiki＋コードリポジトリの統合パターン
- [[Agent Skills]] — 対比される仕組み
- [[LLM Wikiの本質定義]] — 6段階目の定義
