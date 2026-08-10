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
- [事前にやろうとしない運用哲学](concepts/事前にやろうとしない運用哲学.md) — nishioの実運用から導かれた中核哲学。事後修正コストの低さが前提
- [Vault分離と人間-AIの境界](concepts/Vault分離と人間-AIの境界.md) — AI用Vaultと人間用Vaultの分離。Wikiはsource of truthではない
- [Wikiはワークショップ](concepts/Wikiはワークショップ.md) — LLM Wikiは「主宅地」ではなく「処理場」。動的合成層として機能
- [Wikis-as-personas](concepts/Wikis-as-personas.md) — 各Wikiが仮想的人格として振る舞い、目的を通して質問を読み替える
- [研究目的Wikiとプロジェクト目的Wiki](concepts/研究目的Wikiとプロジェクト目的Wiki.md) — 抽象化ネットワーク目的 vs 具体実装目的。構造的差異
- [株分け（kabuwake）](concepts/株分け（kabuwake）.md) — 育ったWikiから別Wikiを派生。raw-source方式がbroken wikilink 0
- [LLM Wikiの実運用データ](concepts/LLM Wikiの実運用データ.md) — 25 Wiki/1647ページの定量データ。個人系が最も育つ
- [Coding Agentの歴史とLLM Wikiの位置づけ](concepts/Coding Agentの歴史とLLM Wikiの位置づけ.md) — 6段階の進化史。Agent Skillsの一般化としてのLLM Wiki
- [Wiki駆動開発](concepts/Wiki駆動開発.md) — Wiki内にコードリポジトリを持ち開発知識を外部化するパターン
- [コンテキスト外部化の歴史](concepts/コンテキスト外部化の歴史.md) — PLAN.md→Devin Knowledge→Agent Skills→LLM Wikiの系譜
- [LLM Wikiの本質定義](concepts/LLM Wikiの本質定義.md) — 文脈情報をファイル化しindexで分割、AI自身がメンテナンスする仕組み
- [適切な切り出し方はニーズが明らかになった後に決まる](concepts/適切な切り出し方はニーズが明らかになった後に決まる.md) — コピーだからオリジナル破壊なし。後から最適な整理が可能
- [個人的データを土台にした一般知識の再構築](concepts/個人的データを土台にした一般知識の再構築.md) — 個人データ＋一般知識の接続で知識が再配置される現象
- [知識は恐怖の解毒剤](concepts/知識は恐怖の解毒剤.md) — 理解できない状況のストレスをLLM Wikiが軽減する
- [AIによるingest停止判断](concepts/AIによるingest停止判断.md) — AIが自ら外部サーベイの停止を判断した事例
- [日記とLLM Wikiの併用](concepts/日記とLLM Wikiの併用.md) — 時系列的グラフと概念グラフの両方運用
- [AIによるスタンス解説生成](concepts/AIによるスタンス解説生成.md) — 複数人議論からAIが参加者ごとのスタンスページを自動生成
- [LLM Wikiは要約の改良版ではない](concepts/LLM Wikiは要約の改良版ではない.md) — 圧縮せず注意の足場を作る。要約の5つの構造的問題
- [読まれなくてよい中間産物](concepts/読まれなくてよい中間産物.md) — 読む主体が人間からLLMに移る。read-optionalの最強バージョン
- [注意の足場](concepts/注意の足場.md) — 情報量を減らさず認知負荷を下げるLLM Wikiの仕組み
- [伸びるに任せてから剪定](concepts/伸びるに任せてから剪定.md) — 議論やWikiの成長を自然に任せ後から整理する思想
- [ChatGPT ProとLLM Wikiの併用](concepts/ChatGPT ProとLLM Wikiの併用.md) — クラウド側Deep ResearchとローカルLLM Wikiの使い分け
- [複数のLLM Wikiに共通のインプット](concepts/複数のLLM Wikiに共通のインプット.md) — 同じ資料を複数Wikiに投入→異なる切り出し方が生まれる現象

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
- [Karwi](entities/Karwi.md) — nishioのLLM Wikiで活動するAIペルソナ
- [家計LLM-wiki](entities/家計LLM-wiki.md) — 個人資産管理のLLM Wiki。個人系の価値を実証
- [猫LLM Wiki](entities/猫LLM Wiki.md) — 猫の医療記録管理。知識は恐怖の解毒剤の実例
- [dd2030-wiki](entities/dd2030-wiki.md) — デジタル民主主義2030プロジェクトWiki。Agentic Retrievalによる経緯再構成
- [ブロードリスニング本Wiki](entities/ブロードリスニング本Wiki.md) — 書籍1冊から62ページのWikiを生成
- [注釈駆動Wiki](entities/注釈駆動Wiki.md) — ソースコードに注釈を付けるように知識を構造化
- [Kozaneba](entities/Kozaneba.md) — KJ法支援ツール。前言語的構造化に強い
- [ConnectingDotsシステム](entities/ConnectingDotsシステム.md) — 事実と解釈を分離する知識管理システム
- [MindTrellis](entities/MindTrellis.md) — AI構造を仮説化する知識システム。3エージェント構成
- [LENCHI](entities/LENCHI.md) — LLMを使った知的生産に関するWiki。Qバックログ
- [scbdown](entities/scbdown.md) — Cosense記法に近いMarkdown方言
- [Devin](entities/Devin.md) — 初のAIソフトウェアエンジニア。Knowledge機能の先駆
- [Agent Skills](entities/Agent Skills.md) — Anthropicの手続き的知識外部化。LLM Wikiの前段階
- [Codex Mobile](entities/Codex Mobile.md) — OpenAIのモバイルコーディングエージェント
- [赤リンクの数の議論のLLM Wiki](entities/赤リンクの数の議論のLLM Wiki.md) — 複数人議論からAIが整理したLLM Wiki

## sources

- [2026-08-11 Karpathy LLM Wiki Gist](sources/2026-08-11 Karpathy LLM Wiki Gist.md) — LLM Wikiパターンの原典。RAG vs 永続Wiki、3層アーキテクチャ、Obsidian as IDE、Memex接続
- [2026-08-11 AIを使った知識マネジメント (villagepump)](sources/2026-08-11%20AIを使った知識マネジメント%20(villagepump).md) — villagepumpでのLLM Wiki集合的議論。Vault分離、種→カオス→株分け、事前にやろうとしない哲学
- [2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)](sources/2026-08-11%20KarpathyのLLM%20Wiki勉強会%20(nishio).md) — nishioの講義資料。20+ Wiki実運用データ、Wikis-as-personas、Coding Agent史

## analyses

- [このWikiの目的と研究課題](analyses/このWikiの目的と研究課題.md) — このWikiの目的・中心となる研究課題（TODO）・現状のまとめ
- [テンプレート草案ver.1](analyses/テンプレート草案ver.1.md) — テンプレート仮説ver.1（claims一覧 + 原文へのポインタ `6c821c1:AGENTS.md`、status: hypothesis）
- [Cosenseソースのingest方式](analyses/Cosenseソースのingest方式.md) — Cosense（nishio/villagepump）のingest方式3案と仮採用セット（status: tentatively-adopted）
- [rawディレクトリの取り扱い](analyses/rawディレクトリの取り扱い.md) — gitignoreの動機と二面性・発見層とrawの分離・manifest.md（status: tentatively-adopted、一部open question）
- [ingestにおける編み込みの実際](analyses/ingestにおける編み込みの実際.md) — 「1ソースが10〜15ページに触れる」の内実。新規作成と既存更新の両方が編み込みの構成要素
- [ingestの監視頻度とソース数の2軸](analyses/ingestの監視頻度とソース数の2軸.md) — バッチIngestとnishio流の共通点は監視頻度軸。ソース数とは直交
- [ingestステップの設計判断](analyses/ingestステップの設計判断.md) — AGENTS.md ingestステップの3改善提案の検証結果（subagent評価 + 判断）
