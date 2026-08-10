---
sources: [[2026-08-11 AIを使った知識マネジメント (villagepump)]], [[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]
tags: [template-design, llm-wiki-pattern]
---

# Vault分離と人間-AIの境界

LLM Wikiの実践において、AI用の知識ベース（Vault）と人間用の知識ベースを分離する設計方針。KarpathyのObsidian setupへの反応から発展した。

## 起源

KarpathyのX投稿に対し、kepanoが「AI用のVaultと人間用のVaultを分けた方が良い」とコメント。人間用Vaultをクリーンに保ち、エージェント用の乱雑なVaultを別に作る。

## Cosenseコミュニティでの発展

- **Cosense vs Obsidianの使い分け**: Cosenseは人間の議論の場、ObsidianはAIの整理の場。人間の会話にAIが「殴り込んで」くるのとは違う関係（[[AIによるスタンス解説生成]]）
- **「人間とLLMの書くWikiを明確に分離する」**: 人間はCosenseで議論し、AIはObsidianで整理する。CosenseのJSONを参考資料としてAIに与えてもよい
- **複数人議論からのLLM整理**: Export for AIでページを出力→AIがingest→整理。複数の人間が書いたものを整理する精神的コストの高さをAIが回避

## 設計上の意義

- **[[Wikiはワークショップ]]**: Wikiをsource of truthにしないことで、AI用Wikiは気軽に書き換え・削除できる
- **[[fact-wiki-separation]]**: より信頼できる情報源がLLM Wikiと明瞭分離されていることに意味がある
- 外部（人間のCosense/グループウェア）とは境界で区別し、ingest/filing backが境界での輸入・保存操作になる

## テンプレート設計への含意

- テンプレートはAI用Vaultの構造を規定するが、人間用Vaultとの連携方法はユーザー任せ → [[LLM WikiテンプレートのOptionality]]
- Cosense export等の外部ソース取り込みはingestの一形態として扱える

## 関連概念

- [[3層アーキテクチャ]] — raw/wikiの分離がVault分離の基盤
- [[Wikiはワークショップ]] — Wikiをsource of truthにしない設計
- [[株分け（kabuwake）]] — Vault間の知識移植
- [[Obsidian as IDE]] — 具体的なツール分離
