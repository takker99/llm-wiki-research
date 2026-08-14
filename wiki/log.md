# Log

Append-only timeline of wiki operations.
Format: `## [YYYY-MM-DD] action | 短い題名` + 詳細は本文。

Parse with: `grep "^## \[" log.md | tail -5`

## [2026-08-01] init | wiki created

wiki created for llm-wiki-template research

## [2026-08-01] file-back | このWikiの目的と研究課題

created analyses/ page, updated index/log

## [2026-08-11] source-loss | raw/の6ソース誤削除

raw/の6ソース（nishio 4 + villagepump 2）がユーザー誤削除。raw/はgitignore対象のため復元不可。再取得予定

## [2026-08-11] refactor | 役割分離

AGENTS.mdを運用規則のみに縮小、テンプレート草案をanalyses/テンプレート草案ver.1へ移管、README/overview修正 (touched 6 pages)

## [2026-08-11] refactor | テンプレート草案ver.1をポインタページ化

本文コピー（220行）を削除し原文は git 6c821c1:AGENTS.md を参照 (touched 3 pages)

## [2026-08-11] ingest | LLM Wikiの作文リスク

concept page。きっかけ: overview.mdのソース一覧が実在1件のみと判明

## [2026-08-11] repo-rename | llm-wiki-template → llm-wiki-research

## [2026-08-11] file-back | Cosenseソースのingest方式

subagent相談結果をanalyses/に提案として保存。status: hypothesis、決定ではない。index/log更新

## [2026-08-11] file-back | rawディレクトリの取り扱い

gitignoreの動機・二面性・発見層とrawの分離・manifest.md。repo cloneはraw/外に置く方針。status: hypothesis, open question。index/log更新

## [2026-08-11] adopt | Cosenseソースのingest方式を仮採用

subagent相談2往復+lint正規表現実機検証。仮採用セット10項目。AGENTS.md・lint.sh・.gitignore・提案2ページ・index/log更新

## [2026-08-11] ingest | Karpathy LLM Wiki Gist

touched 33 pages: 1 source + 17 concepts + 9 entities + 4 existing updated + 2 index/log; later +11 existing cross-link updates

## [2026-08-11] ingest | Cosense LLM Wiki議論

villagepump AIを使った知識マネジメント + nishio KarpathyのLLM Wiki勉強会 + 2-hop先7ページ; touched 53 pages: 2 sources + 23 concepts + 15 entities + 11 existing updated + 2 index/log

## [2026-08-11] refactor | 編み込み修正

既存11ページにCosense ingestのクロスリンクを追加

## [2026-08-11] file-back | ingestにおける編み込みの実際

2回のingest実績データ + nishioの定式 + 3層波及構造 + 教訓。index/log更新

## [2026-08-11] file-back | ingestステップの設計判断

3提案のsubagent検証 + 採用/却下の判断。index/log更新

## [2026-08-11] refactor(agents) | ingestステップ改善

既存照合+未カバー領域特定を追加、logフォーマットを内訳付きに拡張、Lintにingest空白指摘の集約を追記

## [2026-08-11] file-back | ingestの監視頻度とソース数の2軸

analyses/新規 + バッチIngest・事前にやろうとしない運用哲学にクロスリンク + index/log更新。きっかけ: nishioのチェック省略はバッチingestと同型という気づき

## [2026-08-11] query | concept/entity境界の検証

raw全ソースに定義なし、villagepumpの表は簡潔さポリシー、入リンク実測でentityもハブ化（Obsidian 9, qmd 7, Marp 6）。4分類は実質3分類＋ナビゲーション用タクソノミ。研究課題の追記 + テンプレート草案ver.1 evidenceに追記

## [2026-08-11] ingest | zenn tsurubee記事

raw/にアーカイブ + manifest追記。touched 13 pages: 1 source + 2 concepts new (繋げる力, 理解のボトルネック) + 8 existing updated + 2 index/log。評価: 要約どまり。理解のボトルネック vs 読まれなくてよい中間産物の対立を研究課題に追加、草案ver.1 claim#7に反証データ点を記録

## [2026-08-11] query | 理解のボトルネックへのnishioの回答

勉強会raw L177-196: LLM Wikiは知識のネットワークを人間の外側で作る。内部ネットワークは手段にすぎない。人間の役割は目的の言語化。概念ページに追記 + 手段の目的化の問い直しを考察として追加 (touched 3 pages: concept + source + index/log)

## [2026-08-11] ingest | OKF (Open Knowledge Format)

raw/に4アーカイブ: nishio OKFとLLM Wiki + 一貫・網羅・頂点 + villagepump 2026/06/13 + stakiran gist。manifest追記。touched 8 pages: 1 source + 1 entity new (OKF) + 1 concept new (一貫・網羅・頂点) + Lint・研究課題更新 + index/log

## [2026-08-11] file-back | nishioのOKF評価

query回答をanalyses/に保存: format層のみ標準化 + cross-run stability批判 + 撤回の内実はドメイン違い。index/log更新

## [2026-08-12] file-back | AIランチエ

query回答をconcepts/に保存: パレートのランチエ/スペキュラトゥール由来、接地の衛生の委譲と境界監督の落とし穴。index/log更新

## [2026-08-12] file-back | GitHubリポジトリ分析の方法論

subagent 3体との相談結果をanalyses/に保存。発見層+選択的アーカイブ、Template Analysis、設計空間マップ、リスク一覧。index/log更新

## [2026-08-12] split | 外部リポジトリ分析のリスクと罠

GitHubリポジトリ分析の方法論からリスク編を分離・拡充。6+3類型の分析罠、リスクマトリクス追加。親ページ・index/log更新

## [2026-08-12] file-back | パイロット分析4ページ

subagentによる3 repo並行分析 → 個別3ページ + 横断所見1ページ。nishio/llm-wiki-about-nishio + grasp + takker99/AMME-2026S-report。index/log更新

## [2026-08-12] file-back | パイロット分析追加2件 + 横断所見更新

BDL-2026S: 最大規模330p + llm-wiki-about-delite: 43時間停止/CLAUDE.mdのみ/Quartz。横断所見を5件に拡張、停止の2類型・init.txtパターン・命名規則2派・grasp名目利用の乖離を追加。index/log/manifest更新

## [2026-08-12] file-back | パイロット発見のconcept化

5新規: purpose-hoist, 二層設計, 徒歩レビュー, 統合解説層, CLA.md管理 + 4更新: Schema, IndexとLog, スケーラビリティ, Post-ingestレビューにパイロット知見反映。index/log更新

## [2026-08-14] ingest | Wikiとコードリポジトリの関係

nishio cosense: 勉強会「中にコードリポジトリを持つパターン」+ kouchou-ai-developer-wikiページ。raw/に1アーカイブ追加 + manifest追記。touched 6 pages: 1 source new + 1 concept new (Wikiとコードリポジトリの関係) + 3 existing updated (Wiki駆動開発, dd2030-wiki, 研究目的Wikiとプロジェクト目的Wiki) + index/log。内容: 同一repo型vs別repo参照型の対比、SSOTの所在、raw 1ページあたりwiki<1の量的観察、「AIが読む想定」、記憶の外部化が目的

## [2026-08-14] review | 目的↔repo型の対応を検証

subagent相談2往復で「知識の蓄積→別repo参照型・成果物管理→同一repo型」の対応を検証 → 不成立と判定。反証例: grasp/BDL-2026S=知識蓄積+同一repo、dd2030-wiki=成果物管理+別repo。代替基準: コードの有無→生まれ方→知識の向き（wiki=SSOTか）→公開性。新規立ち上げは同一repoがデフォルト。concepts/Wikiとコードリポジトリの関係.md を改訂: 比較表更新 + 含意節の4段階選択 + work/運用規定追加（stalenessは防ぐのではなく記録する）。index/log更新

## [2026-08-14] file-back | repo型の知見を4ページに分散

1: 概念ページに「読む主体はrepo型を決めない」「目的軸とrepo型軸は直交」を追記。2: リポジトリ分析BDL-2026Sに分類ラベル補正（主目的=知識蓄積の同一repo型反証例）。3: 研究課題に配布形式の要件「wiki/単独で取り出せる」を追記。4: 横断所見に#12「分類ラベルは目的ラベルでありrepo型ラベルではない」を追加。index/log更新

## [2026-08-14] file-back | raw/不変性の設計思想

query: Karpathyの不変 vs nishioの実運用とgitignore repoでは不変でない。subagent相談2往復: 観察は部分正しく2類型の混在、不変性の3機能（検証/書き換え自由の担保/LLM範囲境界）、入場時の誓約（性質文→時間規則で例外条項消滅）、コーパスモードの条件付き正当化、「git=不変性担保」撤回と新軸「可視性×転載可能性」。analyses/rawディレクトリの取り扱いを更新（claims候補・未解決論点改訂）+ concepts/3層アーキテクチャの乖離修正（概念文言とAGENTS.md運用の矛盾を解消）+ index/log更新

## [2026-08-14] fix | lint.shのraw参照チェックの偽陽性を解消

正規表現の除外文字に全角括弧（）と→を追加。`・`は実在ファイル「一貫・網羅・頂点-2026-08-11.md」を壊すため追加せず、AMME分析の三層定義セルと方法論のmanifest分離記述は文言を意味保持のまま微修正。MISSING RAW 0件に。index/log更新

## [2026-08-14] file-back | log.mdとgit logの分工

query: 「git管理下ならcommit messageで操作履歴を賄えlog.md不要では？」をsubagent相談2往復で検証。結論: 部分的正しく全体としては誤り。操作時刻vsコミット時刻のズレ、git履歴の書き換え可能性、log.mdにしか書けない7種の情報、粒度のトリレンマ、既存議論はDiors.techのGit+log.md分工とCHANGELOG論争のみ。テンプレート示唆: log.md維持+1行規約・ローテーション・lintサイズチェックの軽量化デフォルト化。analyses/新規 + index/log更新

## [2026-08-14] refactor | log.mdエントリ形式の変更

見出しを `## [DATE] action | 短い題名` に短縮し、詳細は本文（body）に移動。rendering時の見づらさ解消。既存エントリは情報を保持したまま再整形（追記専用の例外として明示的に実施）。`grep "^## \["` によるパースは引き続き可能。AGENTS.mdのフォーマット仕様2箇所・analyses/log.mdとgit logの分工の推奨文案を更新

## [2026-08-14] file-back | log.md形式の既存実装調査

query: 既存llm wikiのlog.md形式を実リポジトリで調査（about-nishio/delite/graspはraw.githubusercontentで実地確認、BDL/AMMEはprivateのためwiki記録のみ）。結果: 見出しは全実装で短い（`## [DATE] action | 短い対象名`がデファクト）、詳細は本文に書くのが標準。種別語彙はabout-nishio (filing-back/deliverable/correction/scaffold)・grasp (implementation+file-back複合) へ拡張。粒度はabout-nishio/graspが時刻まで、deliteは日付のみ。当wikiの旧形式（見出し長文込み）は例外的で、2026-08-14の変更でデファクトに追いついた。concepts/IndexとLogに形式バリエーション節を追加。index/log更新

## [2026-08-14] ingest | microsoft-llmwiki

「Microsoft製のLLM Wiki製品repoをingestしてほしい」の依頼で実施。運用repo5件とは異なる**実装repo（ツール型）**として分析。cloneは発見層 ~/git/llm-wiki-samples/microsoft-llmwiki@b44df6ae（raw/コピーなし・ユーザー選択）。抽出した知見: 3層アーキテクチャの独立収束（index/log形式も当wikiとほぼ同一）、init生成の7セクションAGENTS.mdテンプレート（ガチガチ側の極）、lint 6分類（stale-entries/index-completeness）、weighted query（title 3x/summary 2x/body 1x）、操作層の完全ソフトウェア実装（MCP 14ツール・@wiki /save）、Copilot依存。研究課題「既存の実装との差別化」「配布形式」のTODOにデータ点を追加。
(touched 9 pages: 3 new [リポジトリ分析 microsoft-llmwiki / 操作層 / Microsoft llmwiki] + 6 existing updated [3層アーキテクチャ, Schema, Lint, QueryとFile-back, IndexとLog, バッチIngest, 横断所見, 研究課題] + index/log)

## [2026-08-14] file-back | microsoft-llmwikiの草案への落とし込み候補

query「microsoft/llmwikiからテンプレート草案づくりに有用な手法は？」の回答をfile-back。有用5点: lintのstale-entries/index-completeness分離、weighted query（title 3x/summary 2x/body 1x）、init scaffold最小セット、queries/+type:queryのfile-back制度化、MCP write系安全検証の執筆規約への翻訳。不採用: 7セクション全量・slugify・.wiki/埋め込み・Copilot依存。テンプレート草案ver.1のclaims#2/#4にevidence追記（Microsoftもinitで4分類固定＝初期固定型の分岐、index方式の独立実装+保守コスト対策）。リポジトリ分析ページに落とし込み候補セクション追加。index/log更新
## [2026-08-14] ingest | cosense-link-concepts

「2 hop linksや赤リンクなど、Cosenseのリンク概念を取り入れるのが望ましい。基本概念からLLM wikiとの組み合わせまで幅広くingestしたい」の依頼で実施。前半はvillagepump/nishioの基本概念、後半はLLM Wikiとの組み合わせ（nishio+villagepump+grasp理論+実践例BDL/SMS）。

収集元: villagepump/nishioのCosenseページ群（grasp store + cosense CLI browsePage、Cosenseページ14枚をアーカイブしmanifest.md追記）。確認結果: **BDL-2026S（AGENTS.md:231-236, lint_wiki.py参照数分割）とSMS-2026S-report（lint_wiki.py:3-8）の両方がリンク概念を実装使用していた**（ユーザーの記憶通り）。

抽出した知見: ①Cosenseの2 hop linkは「具体→抽象→別の具体」で思考ジャンプを生むshokai由来の概念。②赤リンク=情報の不在の表現で、LLM WikiのOpen Questionと同型（nishio）。③AIによる赤リンクの延伸（赤リンクをベクトル検索の入力にしてページを生成）。④リンクの4仕事（recall/attention/navigation/読者ケア）を1つの`[X]`に束ねるCosenseの設計と、recallを剥がすgrasp最適設計。⑤come-from（用語-大域の1宣言で全出現をgather）がAI default 裸（AI生成ページのリンク疎）問題の解。⑥参照数分割lint（1頁=broken/error、2+頁=aspect_handle/info）が赤リンク論争への第3の選択肢。

(touched 12 pages: 5 new [Cosenseのリンク概念, 赤リンクとLLM Wiki, リポジトリ分析 SMS-2026S-report, sources×2] + 7 existing updated [リポジトリ分析 BDL-2026S, リポジトリ分析 grasp, このWikiの目的と研究課題, Lint, 赤リンクの数の議論のLLM Wiki, index, log] )

## [2026-08-14] refactor | lintに参照数分類を実装、AGENTS.mdに赤リンク許容を明文化

ingestしたリンク概念をこのwikiの運用に取り込んだ。

- `scripts/lint.sh`: 壊れたwikilinkを参照数で分類（1頁参照=BROKEN=typo or 意図的赤リンク、2+頁=ASPECT_HANDLE=ページ作成候補）。併せてエイリアス解決（`[[X|表示名]]`）とインラインコード内wikilinkの除外
- AGENTS.md: Lintセクションに参照数分類を追記、執筆の機械要件に「赤リンクは許容」を追加
- 既存リンク整理: `[[リポジトリ分析 横断所見]]`→`[[パイロット分析 横断所見]]`（typo修正）、`[[vault-separation]]`→`[[Vault分離と人間-AIの境界|vault-separation]]`（リンク解決）、`[[File-back]]`→テキスト化
- `[[fact-wiki-separation]]`（3頁参照=ASPECT_HANDLE）を概念ページ化 — 参照数分類lintの最初の実地適用事例
- 残存: `[[Low-background steel]]`、`[[LLMと盆栽]]` は意図的赤リンクとして放置（LLMと盆栽はrawソースあり、ingest候補）

(touched 5 wiki pages: 1 new [fact-wiki-separation] + 4 existing updated [QueryとFile-back, リポジトリ分析 SMS-2026S-report, Wikiはワークショップ, Lint] + index/log、非wiki 2 files [lint.sh, AGENTS.md] )
