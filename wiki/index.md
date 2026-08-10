# Wiki Index

Full catalog of all wiki pages, organized by category.
Each entry: `- [Page Title](path/to/page.md) — One-line summary.`

## top-level

- [overview](overview.md) — エントリーポイント。このwikiの俯瞰図

## concepts

- [LLM Wiki](concepts/LLM Wiki.md) — LLMが永続的なMarkdown wikiを段階的に構築・保守するパターン全体
- [永続Wikiと複利効果](concepts/永続Wikiと複利効果.md) — RAGとの対比。知識が蓄積し複利で効く「compounding artifact」
- [3層アーキテクチャ](concepts/3層アーキテクチャ.md) — raw/（不変）→ wiki/（LLM管理）→ Schema（AGENTS.md）の基本構造
- [Schema（AGENTS.md）](concepts/Schema（AGENTS.md）.md) — 3層目の設定ドキュメント。LLMをwiki保守者に仕立てる鍵
- [Ingest](concepts/Ingest.md) — 3基本操作の1つ。raw/ソースを読みwikiに統合するプロセス
- [QueryとFile-back](concepts/QueryとFile-back.md) — 質問応答＋回答のwiki化。探索の蓄積が複利効果を生む
- [Lint](concepts/Lint.md) — wikiの健全性チェック。矛盾検出＋新調査課題の提案
- [Post-ingestレビューループ](concepts/Post-ingestレビューループ.md) — ingest後に人間が要約を確認しLLMをガイドするステップ（Karpathyの運用スタイル）
- [バッチIngest](concepts/バッチIngest.md) — 多数のソースを一度にingestし監視を減らす代替スタイル
- [IndexとLog](concepts/IndexとLog.md) — wikiナビゲーションを支える2つの特殊ファイル。中規模までRAG不要
- [Obsidian as IDE](concepts/Obsidian as IDE.md) — ObsidianをIDE、LLMをプログラマ、wikiをコードベースとするツールチェーン像
- [Memex](concepts/Memex.md) — Vannevar Bushの先駆的知識装置。LLM Wikiの歴史的先駆
- [連想トレイル](concepts/連想トレイル.md) — 文書間の連想的な繋がり。wikilinkによる現代的実装
- [LLM Wikiのスケーラビリティ](concepts/LLM Wikiのスケーラビリティ.md) — index.mdの有効範囲（〜100ソース）とqmd等によるスケールアップ
- [LLM Wikiの応用領域](concepts/LLM Wikiの応用領域.md) — 個人・研究・読書・ビジネス等のユースケース一覧
- [LLM WikiテンプレートのOptionality](concepts/LLM WikiテンプレートのOptionality.md) — パターンと実装の分離。すべてオプショナルでモジュラー
- [RAG](concepts/RAG.md) — Retrieval-Augmented Generation。LLM Wikiが対比するパラダイム
- [LLM Wikiの作文リスク](concepts/LLM Wikiの作文リスク.md) — LLMが存在しないソースを作文するリスクと、raw/による防衛線

## entities

- [Andrej Karpathy](entities/Andrej Karpathy.md) — LLM Wikiパターンの提唱者
- [Obsidian](entities/Obsidian.md) — Markdownベースのナレッジベースアプリ。LLM WikiのIDE
- [Obsidian Web Clipper](entities/Obsidian Web Clipper.md) — Web→Markdown変換のブラウザ拡張
- [qmd](entities/qmd.md) — Markdownローカル検索エンジン。LLM Wikiスケールアップ時の選択肢
- [Marp](entities/Marp.md) — Markdownスライドデッキ形式。Obsidianプラグインあり
- [Dataview](entities/Dataview.md) — Obsidianプラグイン。frontmatterクエリで動的ビュー生成
- [Vannevar Bush](entities/Vannevar Bush.md) — Memex提唱者。LLM Wikiの歴史的先駆
- [Tolkien Gateway](entities/Tolkien Gateway.md) — 読書ユースケースの実例として引用されたファンwiki
- [NotebookLM](entities/NotebookLM.md) — GoogleのAIノートブック。RAG型の典型例

## sources

- [2026-08-11 Karpathy LLM Wiki Gist](sources/2026-08-11 Karpathy LLM Wiki Gist.md) — LLM Wikiパターンの原典。RAG vs 永続Wiki、3層アーキテクチャ、Obsidian as IDE、Memex接続

## analyses

- [このWikiの目的と研究課題](analyses/このWikiの目的と研究課題.md) — このWikiの目的・中心となる研究課題（TODO）・現状のまとめ
- [テンプレート草案ver.1](analyses/テンプレート草案ver.1.md) — テンプレート仮説ver.1（claims一覧 + 原文へのポインタ `6c821c1:AGENTS.md`、status: hypothesis）
- [Cosenseソースのingest方式](analyses/Cosenseソースのingest方式.md) — Cosense（nishio/villagepump）のingest方式3案と仮採用セット（status: tentatively-adopted）
- [rawディレクトリの取り扱い](analyses/rawディレクトリの取り扱い.md) — gitignoreの動機と二面性・発見層とrawの分離・manifest.md（status: tentatively-adopted、一部open question）
