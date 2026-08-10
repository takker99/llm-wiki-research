---
sources: "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]", "[[2026-08-11 AIを使った知識マネジメント (villagepump)]]"
tags: [template-design, llm-wiki-pattern]
---

# Wikis-as-personas

各LLM Wikiが仮想的人格として振る舞うという概念。nishioの複数Wiki運用から発見された。

## 現象

- 各Wikiは質問を自分の目的を通して読み替える。同じ問いでもWikiごとに異なる対象を指す（メタwiki視点 / システムpositioning / プロジェクト構造）
- nishioの認識: Claude Code君1人ではなく、wikiごとに別人という認識。情報を共有していない別プロセスとして走るClaude Codeは別個体
- 複数インスタンスを並列で立ち上げて並列実装。学んだことを日記（=wiki）に書いて終了。明日のインスタンスは今日のインスタンスの活動の記憶を持って開始

## 手動orchestratorパターン

同じ問いを複数Wikiに並列投げし、ユーザがAggregatorを担うパターン。N個のWikiに同じ資料をingestさせると、それぞれ異なる切り出し方やまとめ方、レスポンスを返す。これを相互に交換しても面白い（がN^2の手間）。

## 複数Wiki連携の課題

- 相互にお互いのWikiのことを知っているので、file back時に「あっちに書こうか？」という問いかけが発生することもある
- まだベストプラクティスは固まっていない
- 各フォルダにllm-wiki.mdがあるのを利用してClaude CodeにfindさせてWiki一覧を作る運用

## テンプレート設計への含意

- テンプレートは単一Wikiの運用を前提としつつ、複数Wiki連携を妨げない設計であるべき
- [[株分け（kabuwake）]]の仕組みが複数Wiki連携の基盤になる

## 関連概念

- [[株分け（kabuwake）]] — Wiki間の知識移植
- [[研究目的Wikiとプロジェクト目的Wiki]] — 人格分化の典型パターン
- [[複数のLLM Wikiに共通のインプット]] — 具体的事例
- [[LLM Wikiの実運用データ]] — 20+ Wikiの観察
