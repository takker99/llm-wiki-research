---
raw:
  - raw/nishio-KarpathyのLLM_Wiki勉強会.md
  - raw/cosense/nishio/kouchou-ai-developer-wiki-2026-08-14.md
source_url: https://scrapbox.io/nishio/KarpathyのLLM_Wiki勉強会
accessed: 2026-08-14
tags: [template-design, llm-wiki-pattern]
---

# 2026-08-14 Wikiとコードリポジトリの関係 (nishio)

nishioのcosenseでの「中にコードリポジトリを持つパターン」（wiki-driven workflow）に関する言及。[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]の「中にコードリポジトリを持つパターン」節と、広聴AI開発wiki（`kouchou-ai-developer-wiki`）のページをまとめたもの。

## 要点

1. **別repoのコードをwiki repoから参照してingestする**: dd2030-wikiでの「リポジトリをrawの中にcloneして分析させた」経験から、開発対象のソースコードをWikiの参照対象にする方式に発展。`work/` にコードのrepo（clone）、`raw/` に議事録・Slackログ、`wiki/` に両方から抽出したwhy/whatという3層構成。コード本体のrepoとは別repoで、wiki repoは知識層のみを持つ（[[Wikiとコードリポジトリの関係]]）。

2. **コードはwikiページの生成効率が低い**: 25 wiki集計で「GitHubからcloneしたソースコードがあるケースでは raw 1ページあたりのwikiページが < 1」。Cosense exportのような1ファイルから多数の概念を切り出すソースと対照的。コードは1ファイル=1概念ではなく、wiki化の対象というよりAgentic Retrievalの参照対象。

3. **「AIが読む想定」のwiki**: kouchou-ai-developer-wikiは「人間が読むためにAIが書いている」のではなく「人間も読める形でAIが自分の理解を書き留めている」。dd2030-wiki（人間が読むためにAIが書く）との違いをnishio自身が明示。

4. **目的は記憶の外部化**: 隙間時間で進めるOSSプロジェクトの「どうしてこうなってるんだっけ」「何をしてたんだっけ」を解決。rawデータのAgentic Retrievalを繋ぎ、file backで「開発者が疑問に思うこと」の解説が有機的に育つ。実装中の発見は「今は対処しない、Wikiに書いといて」で逃さない。

5. **仕組みの解説と公開**: `https://nishio.github.io/kouchou-ai-developer-wiki/concepts/wiki-driven-workflow/` にworkflowの解説を公開。Codex Mobileとの連携（溜まったPR処理・大規模リファクタリングを完了）も報告されている。

## 触れている概念・実体

- 概念: [[Wikiとコードリポジトリの関係]] / [[Wiki駆動開発]] / [[研究目的Wikiとプロジェクト目的Wiki]] / [[LLM Wikiの実運用データ]] / [[Coding Agentの歴史とLLM Wikiの位置づけ]]
- 実体: [[dd2030-wiki]] / [[注釈駆動Wiki]] / [[Codex Mobile]]
