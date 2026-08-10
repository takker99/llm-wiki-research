---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 AIを使った知識マネジメント (villagepump)]]"
tags: [template-design, llm-wiki-pattern]
---

# Obsidian as IDE

Karpathyが提唱するLLM Wikiの具体的なツールチェーン像。[[Obsidian]]をwikiのIDEに見立て、LLMがプログラマ、wikiがコードベースというアナロジー。

## 構成要素

- **Obsidian（IDE）**: 人間がwikiをブラウズするためのフロントエンド
- **LLM（プログラマ）**: 会話に基づいてwikiを編集する
- **Wiki（コードベース）**: Markdownファイルのコレクション

人間はObsidianを開いて、リンクを辿り、グラフビューを見て、更新されたページを読む。LLMは裏でファイルを編集している。

## Vault分離

KarpathyのObsidian setupへの反応として、AI用Vaultと人間用Vaultの分離が推奨されている（[[Vault分離と人間-AIの境界]]）。人間用Vaultをクリーンに保ち、エージェント用の乱雑なVaultを別に作成する。Cosenseコミュニティでは「Cosenseは人間の議論の場、ObsidianはAIの整理の場」という使い分けも提案された。

## 活用されるObsidianの機能

- **[[Obsidian Web Clipper]]**: Web記事をMarkdownに変換しraw/に保存するブラウザ拡張
- **画像ローカルダウンロード**: クリップした記事の画像をローカルに保存（設定: 添付フォルダパスを `raw/assets/` に、ホットキーでダウンロード実行）。URL切れを防ぎ、LLMが画像を直接参照できる。
- **Graph View**: wikiの形状を視覚化。何が何に繋がっているか、どのページがハブか、どれが孤立しているかが一目でわかる。
- **[[Dataview]]**: ページのfrontmatter（タグ、日付、ソース数）に対してクエリを実行し、動的なテーブルやリストを生成するプラグイン。
- **[[Marp]]**: Markdownベースのスライドデッキ形式。Obsidianプラグインあり。wikiコンテンツからプレゼンテーションを直接生成できる。

## ツールチェーンのOptionality

Karpathyはこれらすべてを「オプショナルでモジュラー」と位置づけている。Cosenseコミュニティでは、MarkdownよりCosense記法寄りの文法を求める試み（[[scbdown]]）もあるが、これもoptionalな拡張。

→ [[LLM WikiテンプレートのOptionality]]

## 関連概念

- [[LLM Wiki]] — 全体パターン
- [[Vault分離と人間-AIの境界]] — AI用/人間用Vaultの分離
- [[LLM Wikiのスケーラビリティ]] — どの段階でどのツールが必要になるか
- [[scbdown]] — Cosense寄りのMarkdown方言
