# Wiki Index

Full catalog of all wiki pages, organized by category.
Each entry: `- [Page Title](path/to/page.md) — One-line summary.`

## top-level

- [overview](overview.md) — エントリーポイント。このwikiの俯瞰図

## concepts

- [LLM Wiki](concepts/LLM Wiki.md) — LLMが永続的なMarkdown wikiを段階的に構築・保守するパターン全体
- [永続Wikiと複利効果](concepts/永続Wikiと複利効果.md) — RAGとの対比。知識が蓄積し複利で効く「compounding artifact」
- [3層アーキテクチャ](concepts/3層アーキテクチャ.md) — raw/（入場時凍結）→ wiki/（LLM管理）→ Schema（AGENTS.md）の基本構造。不変性は入場時の誓約へ再解釈
- [Schema（AGENTS.md）](concepts/Schema（AGENTS.md）.md) — 3層目の設定ドキュメント。LLMをwiki保守者に仕立てる鍵
- [fact-wiki-separation](concepts/fact-wiki-separation.md) — Wikiをsource of truthにしない。書き換え自由の担保と簡潔さの維持。書き換え原則の適用外（時系列・履歴・人間の記録は追記）
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
- [Wikiとコードリポジトリの関係](concepts/Wikiとコードリポジトリの関係.md) — 同一repo型vs別repo参照型。SSOTの所在と「AIが読む想定」のwiki
- [コンテキスト外部化の歴史](concepts/コンテキスト外部化の歴史.md) — PLAN.md→Devin Knowledge→Agent Skills→LLM Wikiの系譜
- [LLM Wikiの本質定義](concepts/LLM Wikiの本質定義.md) — 文脈情報をファイル化しindexで分割、AI自身がメンテナンスする仕組み
- [適切な切り出し方はニーズが明らかになった後に決まる](concepts/適切な切り出し方はニーズが明らかになった後に決まる.md) — コピーだからオリジナル破壊なし。後から最適な整理が可能
- [個人的データを土台にした一般知識の再構築](concepts/個人的データを土台にした一般知識の再構築.md) — 個人データ＋一般知識の接続で知識が再配置される現象
- [知識は恐怖の解毒剤](concepts/知識は恐怖の解毒剤.md) — 理解できない状況のストレスをLLM Wikiが軽減する
- [AIによるingest停止判断](concepts/AIによるingest停止判断.md) — AIが自ら外部サーベイの停止を判断した事例
- [日記とLLM Wikiの併用](concepts/日記とLLM Wikiの併用.md) — 時系列的グラフと概念グラフの両方運用
- [AIによるスタンス解説生成](concepts/AIによるスタンス解説生成.md) — 複数人議論からAIが参加者ごとのスタンスページを自動生成
- [LLM Wikiは要約の改良版ではない](concepts/LLM Wikiは要約の改良版ではない.md) — 圧縮せず注意の足場を作る。要約の5つの構造的問題
- [繋げる力](concepts/繋げる力.md) — 複数ソース横断で概念ページが自動的に組み上がる価値。統合と対比の2タイプ
- [理解のボトルネック](concepts/理解のボトルネック.md) — 人間が読んで理解することがボトルネック？nishioの回答: 内部ネットワークは手段にすぎない。手段の目的化の問い直し
- [読まれなくてよい中間産物](concepts/読まれなくてよい中間産物.md) — 読む主体が人間からLLMに移る。read-optionalの最強バージョン
- [注意の足場](concepts/注意の足場.md) — 情報量を減らさず認知負荷を下げるLLM Wikiの仕組み
- [伸びるに任せてから剪定](concepts/伸びるに任せてから剪定.md) — 議論やWikiの成長を自然に任せ後から整理する思想
- [ChatGPT ProとLLM Wikiの併用](concepts/ChatGPT ProとLLM Wikiの併用.md) — クラウド側Deep ResearchとローカルLLM Wikiの使い分け
- [一貫・網羅・頂点](concepts/一貫・網羅・頂点.md) — 安定性の3価値分解（min/union/max）。cross-run stability批判とAIランチエ分業
- [AIランチエ](concepts/AIランチエ.md) — スペキュラトゥールが内部に持てる退屈な保守仕事をこなすAI。接地の衛生は渡せても境界監督と創発は渡せない
- [複数のLLM Wikiに共通のインプット](concepts/複数のLLM Wikiに共通のインプット.md) — 同じ資料を複数Wikiに投入→異なる切り出し方が生まれる現象
- [目的明示（purpose-hoist）](concepts/目的明示（purpose-hoist）.md) — AGENTS.md冒頭に第一目的を明示し迷走を防ぐ。about-nishioで発見
- [AGENTS.md+SKILL.md二層設計](concepts/AGENTS.md+SKILL.md二層設計.md) — 操作手順をskillに委譲しAGENTS.mdを薄く保つ。AMMEで実証。分担基準（常時行動vsトリガー操作）・保険不要化・skillロード仕様を明確化
- [操作層](concepts/操作層.md) — wikiへの操作を定義・実現する層。文書型（AGENTS.md指示）vs ツール型（MCP/拡張）。OKFが標準化しない層
- [徒歩レビュー](concepts/徒歩レビュー.md) — 人間のレビュー負荷を最小化。AIがフィルタ→人間は違和感のみ。about-nishioで発見
- [統合解説層（synthesis）](concepts/統合解説層（synthesis）.md) — 概念辞書の上のメタ層。素人向け入口。deliteが発明
- [Cosenseのリンク概念](concepts/Cosenseのリンク概念.md) — 2 hop link・赤リンク（空リンク）・大きなリンク・関連ページリスト・リンクサジェスト等の用語体系。リンクで思考をジャンプさせる運用思想
- [赤リンクとLLM Wiki](concepts/赤リンクとLLM Wiki.md) — 赤リンク=情報の不在表現のLLM Wikiへの輸入。Open Questionとの同型性、リンクの4仕事、come-from、参照数分割lint
- [AGENTS.md=CLAUDE.md管理パターン](concepts/AGENTS.md=CLAUDE.md管理パターン.md) — コピー・分離・片方のみの4パターンと推奨
- [overviewの役割](concepts/overviewの役割.md) — 人間向けの入口ページ。原型（Karpathy gist）にはない独自発明だが「入門の1枚」はnishio実測・他実装に元ネタあり

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
- [OKF](entities/OKF.md) — GoogleのOpen Knowledge Format。markdown+frontmatterのオープン仕様。データカタログ由来でformat層のみ標準化
- [赤リンクの数の議論のLLM Wiki](entities/赤リンクの数の議論のLLM Wiki.md) — 複数人議論からAIが整理したLLM Wiki
- [Microsoft llmwiki](entities/Microsoft%20llmwiki.md) — Microsoft製のLLM Wiki製品。VS Code拡張+MCPサーバ。操作層のツール型実装の先鋭例

## sources

- [2026-08-11 Karpathy LLM Wiki Gist](sources/2026-08-11 Karpathy LLM Wiki Gist.md) — LLM Wikiパターンの原典。RAG vs 永続Wiki、3層アーキテクチャ、Obsidian as IDE、Memex接続
- [2026-08-11 AIを使った知識マネジメント (villagepump)](sources/2026-08-11%20AIを使った知識マネジメント%20(villagepump).md) — villagepumpでのLLM Wiki集合的議論。Vault分離、種→カオス→株分け、事前にやろうとしない哲学
- [2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)](sources/2026-08-11%20KarpathyのLLM%20Wiki勉強会%20(nishio).md) — nishioの講義資料。20+ Wiki実運用データ、Wikis-as-personas、Coding Agent史
- [2026-08-11 OKFとLLM Wiki (nishio+villagepump)](sources/2026-08-11%20OKFとLLM%20Wiki%20(nishio+villagepump).md) — OKFの正体・format層vs操作層・赤リンク論争・一貫・網羅・頂点
- [2026-08-11 KarpathyのLLM Wikiを1ヶ月運用してわかった繋げる力 (tsurubee)](sources/2026-08-11%20KarpathyのLLM%20Wikiを1ヶ月運用してわかった繋げる力%20(tsurubee).md) — 1ヶ月運用報告。要約どまりだが「理解のボトルネック」でnishioと対立、ミニマム構成サンプルあり
- [2026-08-14 Wikiとコードリポジトリの関係 (nishio)](sources/2026-08-14%20Wikiとコードリポジトリの関係%20(nishio).md) — 別repoのコードをwiki repoから参照してingestする方式（wiki-driven workflow）
- [2026-08-14 Cosenseのリンク概念 (villagepump+nishio)](sources/2026-08-14%20Cosenseのリンク概念%20(villagepump+nishio).md) — 2 hop link・赤リンク・大きなリンク・関連ページリスト・リンクサジェスト・come-fromの基本概念
- [2026-08-14 赤リンクとLLM Wiki (nishio+villagepump)](sources/2026-08-14%20赤リンクとLLM%20Wiki%20(nishio+villagepump).md) — 赤リンク延伸・Open Questionとの同型性・リンクの4仕事・come-from理論・実践例（grasp/BDL/SMS）
- [2026-08-14 SKILL併用LLM Wiki Astro-Han (github)](sources/2026-08-14%20SKILL併用LLM%20Wiki%20Astro-Han%20(github).md) — 単一SKILL.mdがSchema層を吸収。Design BoundariesでMCP/hooksをskillの範囲外と宣言（1.9k★）
- [2026-08-14 SKILL併用LLM Wiki jackwener (github)](sources/2026-08-14%20SKILL併用LLM%20Wiki%20jackwener%20(github).md) — entry file(数十行)+4操作skillの二層。本wikiと同一構造の独立収束（95★）
- [2026-08-14 SKILL併用LLM Wiki vanillaflava (github)](sources/2026-08-14%20SKILL併用LLM%20Wiki%20vanillaflava%20(github).md) — 6スキル構成+crystallize。薄いCLAUDE.md+外部スキーマ分離。プライバシー論（59★）
- [2026-08-14 SKILL併用LLM Wiki toolboxmd (github)](sources/2026-08-14%20SKILL併用LLM%20Wiki%20toolboxmd%20(github).md) — 4スキル+loader+SessionStart hook+デタッチドバックグラウンドingest（98★）
- [2026-08-14 SKILL併用LLM Wiki micuintus (github)](sources/2026-08-14%20SKILL併用LLM%20Wiki%20micuintus%20(github).md) — 最小純skill ~6KB+lazy-loaded references。エコシステム比較表9repo収録（22★）
- [2026-08-14 SKILL併用LLM Wiki ivankuznetsov (hackernoon+github)](sources/2026-08-14%20SKILL併用LLM%20Wiki%20ivankuznetsov%20(hackernoon+github).md) — 6プロジェクト実運用。CLAUDE.md 1行トリガー+wiki-researcher skill+QMD MCP併用
- [2026-08-14 opencode Agent Skills仕様](sources/2026-08-14%20opencode%20Agent%20Skills仕様.md) — skillロードの2段構え。available_skills常駐+skillツール呼び出しはagent自律判断。トリガーはLLMの想起

## analyses

- [このWikiの目的と研究課題](analyses/このWikiの目的と研究課題.md) — このWikiの目的・中心となる研究課題（TODO）・現状のまとめ
- [nishioのOKF評価](analyses/nishioのOKF評価.md) — OKFはformat層のみ標準化・cross-run stabilityは創発を殺す・本質はドメイン違い
- [テンプレート草案ver.1](analyses/テンプレート草案ver.1.md) — テンプレート仮説ver.1（claims一覧 + 原文へのポインタ `6c821c1:AGENTS.md`、status: hypothesis）
- [Cosenseソースのingest方式](analyses/Cosenseソースのingest方式.md) — Cosense（nishio/villagepump）のingest方式3案と仮採用セット（status: tentatively-adopted）
- [rawディレクトリの取り扱い](analyses/rawディレクトリの取り扱い.md) — gitignoreの動機と二面性・発見層とrawの分離・manifest.md・不変性の3機能と入場時の誓約・コーパスモード（status: tentatively-adopted、一部open question）
- [ingestにおける編み込みの実際](analyses/ingestにおける編み込みの実際.md) — 「1ソースが10〜15ページに触れる」の内実。新規作成と既存更新の両方が編み込みの構成要素
- [ingestの監視頻度とソース数の2軸](analyses/ingestの監視頻度とソース数の2軸.md) — バッチIngestとnishio流の共通点は監視頻度軸。ソース数とは直交
- [ingestステップの設計判断](analyses/ingestステップの設計判断.md) — AGENTS.md ingestステップの3改善提案の検証結果（subagent評価 + 判断）
- [GitHubリポジトリ分析の方法論](analyses/GitHubリポジトリ分析の方法論.md) — 外部LLM Wiki repoの収集・分析方法論。発見層＋選択的アーカイブ、Template Analysis、設計空間マップ（status: tentatively-adopted）
- [外部リポジトリ分析のリスクと罠](analyses/外部リポジトリ分析のリスクと罠.md) — 上記から分離。6+3類型の分析罠＋ライセンス倫理＋プロジェクト管理リスク＋リスクマトリクス（status: tentatively-adopted）
- [リポジトリ分析 llm-wiki-about-nishio](analyses/リポジトリ分析 llm-wiki-about-nishio.md) — パイロット1: 個人成熟型。目的駆動+purpose-hoist、徒歩レビュー、キーワード駆動ingest（6.4KB AGENTS.md, 48pages）
- [リポジトリ分析 grasp](analyses/リポジトリ分析 grasp.md) — パイロット2: Code+Wikiハイブリッド型。SQLite-authority、マルチエージェント構成(.agents/+.claude/+skills/)、自動ship loop（12.5KB AGENTS.md, 49pages）
- [リポジトリ分析 AMME-2026S-report](analyses/リポジトリ分析 AMME-2026S-report.md) — パイロット3: 研究レポート型・最薄AGENTS.md。AGENTS.md+SKILL.md二層設計、wikilink 0/frontmatter不使用で100ページ運用（1.9KB AGENTS.md, 100pages）
- [パイロット分析 横断所見](analyses/パイロット分析 横断所見.md) — 5件の横断比較。AGENTS.mdサイズ決定要因、index/log配置2派、CLA.md管理4パターン、停止の2類型、テンプレ草案claims検証
- [リポジトリ分析 BDL-2026S](analyses/リポジトリ分析 BDL-2026S.md) — パイロット4: 講義型・最大規模。330p/62K行、SSOT分配設計、concept-rename-mapping（15.8KB AGENTS.md, 330pages）
- [リポジトリ分析 llm-wiki-about-delite](analyses/リポジトリ分析 llm-wiki-about-delite.md) — パイロット5: 逸脱・停止型。CLAUDE.mdのみ、43時間で完了、Quartz公開、init.txt+先行概念マッピング（7.5KB CLAUDE.md, 100+pages）
- [リポジトリ分析 microsoft-llmwiki](analyses/リポジトリ分析 microsoft-llmwiki.md) — 実装repo（ツール型）: VS Code拡張+MCP。3層の独立収束、7セクションAGENTS.mdテンプレート、lint 6分類、操作層のソフトウェア実装（status: tentatively-adopted）
- [リポジトリ分析 SKILL併用6事例](analyses/リポジトリ分析%20SKILL併用6事例.md) — SKILL併用実装6件の横断比較。AGENTS.md/SKILL分担を5パターンに類型化、二層設計の独立収束、MCP併用の実証（status: tentatively-adopted）
- [MCP不採用とAGENTS.md+SKILL.md二層採用の根拠](analyses/MCP不採用とAGENTS.md+SKILL.md二層採用の根拠.md) — MCPはデフォルト不採用・オプション追加可。実測（14ツール6.3KB≈1.6-2Kトークン常駐）+Agent Skills標準化+推奨構成（status: tentatively-adopted）
- [リポジトリ分析 SMS-2026S-report](analyses/リポジトリ分析%20SMS-2026S-report.md) — パイロット6: 研究レポート型・grasp-backed。参照数分割lint（1頁=low-frequency / 2+頁=2-hop hubの種）、SQLite投影（182行 AGENTS.md, 128pages）
- [配布形式の決定とテンプレートの動機](analyses/配布形式の決定とテンプレートの動機.md) — テンプレートの動機（お決まり経路の再発明防止・品質の揺れ対策）と配布形式の決定（template/コピペ・お膳立てがメイン）＋subagent相談の妥当性検証（status: tentatively-adopted）
- [claims対応表](analyses/claims対応表.md) — 草案ver.1の9 claims × 2軸（記述的検証×規範的决定）の追跡器。v0.1スコープ決定（二層構成・対象範囲・規範のみ原則）
- [log.mdとgit logの分工](analyses/log.mdとgit logの分工.md) — 「git管理下ならlog.md不要」論の検証。操作時刻vsコミット時刻、粒度のトリレンマ、CHANGELOG論争（status: hypothesis）
- [ingestとfile-backの反映方法の同型性](analyses/ingestとfile-backの反映方法の同型性.md) — 両者は同じ編み込み操作。差はソースの性質と頻度制御のみ。実行は軽同型、templateのFile-back実行契約欠損を是正（status: tentatively-adopted）
- [index.md存廃の設計判断](analyses/index.md存廃の設計判断.md) — Cosense批判（大きなリンク論は適用範囲外・真の核心は登録作業への違和感）⇔ index維持。肥大化は可視・出口あり、廃止は不可視・サイレント。stale-entries lint + 「indexはキャッシュ」宣言はv0.1に実装済み、variant guideは撤回（改変はagent任せ）（status: hypothesis）
