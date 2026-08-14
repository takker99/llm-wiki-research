# Log

Append-only timeline of wiki operations.
Format: `## [YYYY-MM-DD] action | detail`

Each entry should be one line after the date header.
Parse with: `grep "^## \[" log.md | tail -5`

## [2026-08-01] init | wiki created for llm-wiki-template research

## [2026-08-01] file-back | このWikiの目的と研究課題 (created analyses/ page, updated index/log)

## [2026-08-11] source-loss | raw/の6ソース（nishio 4 + villagepump 2）がユーザー誤削除。raw/はgitignore対象のため復元不可。再取得予定

## [2026-08-11] refactor | 役割分離: AGENTS.mdを運用規則のみに縮小、テンプレート草案をanalyses/テンプレート草案ver.1へ移管、README/overview修正 (touched 6 pages)

## [2026-08-11] refactor | テンプレート草案ver.1をポインタページ化: 本文コピー（220行）を削除し原文は git 6c821c1:AGENTS.md を参照 (touched 3 pages)

## [2026-08-11] ingest | LLM Wikiの作文リスク (concept page。きっかけ: overview.mdのソース一覧が実在1件のみと判明)

## [2026-08-11] repo-rename | llm-wiki-template → llm-wiki-research

## [2026-08-11] file-back | Cosenseソースのingest方式（subagent相談結果をanalyses/に提案として保存。status: hypothesis、決定ではない。index/log更新）

## [2026-08-11] file-back | rawディレクトリの取り扱い（gitignoreの動機・二面性・発見層とrawの分離・manifest.md。repo cloneはraw/外に置く方針。status: hypothesis, open question。index/log更新）

## [2026-08-11] adopt | Cosenseソースのingest方式を仮採用（subagent相談2往復+lint正規表現実機検証。仮採用セット10項目。AGENTS.md・lint.sh・.gitignore・提案2ページ・index/log更新）

## [2026-08-11] ingest | Karpathy LLM Wiki Gist (touched 33 pages: 1 source + 17 concepts + 9 entities + 4 existing updated + 2 index/log; later +11 existing cross-link updates)

## [2026-08-11] ingest | Cosense LLM Wiki議論 (villagepump AIを使った知識マネジメント + nishio KarpathyのLLM Wiki勉強会 + 2-hop先7ページ; touched 53 pages: 2 sources + 23 concepts + 15 entities + 11 existing updated + 2 index/log)

## [2026-08-11] refactor | 編み込み修正: 既存11ページにCosense ingestのクロスリンクを追加

## [2026-08-11] file-back | ingestにおける編み込みの実際（2回のingest実績データ + nishioの定式 + 3層波及構造 + 教訓。index/log更新）

## [2026-08-11] file-back | ingestステップの設計判断（3提案のsubagent検証 + 採用/却下の判断。index/log更新）

## [2026-08-11] refactor(agents): ingestステップに既存照合+未カバー領域特定を追加、logフォーマットを内訳付きに拡張、Lintにingest空白指摘の集約を追記

## [2026-08-11] file-back | ingestの監視頻度とソース数の2軸 (analyses/新規 + バッチIngest・事前にやろうとしない運用哲学にクロスリンク + index/log更新。きっかけ: nishioのチェック省略はバッチingestと同型という気づき)

## [2026-08-11] query | concept/entity境界の検証: raw全ソースに定義なし、villagepumpの表は簡潔さポリシー、入リンク実測でentityもハブ化（Obsidian 9, qmd 7, Marp 6）。4分類は実質3分類＋ナビゲーション用タクソノミ。研究課題の追記 + テンプレート草案ver.1 evidenceに追記

## [2026-08-11] ingest | zenn tsurubee記事 (raw/にアーカイブ + manifest追記。touched 13 pages: 1 source + 2 concepts new (繋げる力, 理解のボトルネック) + 8 existing updated + 2 index/log)。評価: 要約どまり。理解のボトルネック vs 読まれなくてよい中間産物の対立を研究課題に追加、草案ver.1 claim#7に反証データ点を記録

## [2026-08-11] query | 理解のボトルネックへのnishioの回答を発見（勉強会raw L177-196: LLM Wikiは知識のネットワークを人間の外側で作る。内部ネットワークは手段にすぎない。人間の役割は目的の言語化）。概念ページに追記 + 手段の目的化の問い直しを考察として追加 (touched 3 pages: concept + source + index/log)

## [2026-08-11] ingest | OKF (Open Knowledge Format) (raw/に4アーカイブ: nishio OKFとLLM Wiki + 一貫・網羅・頂点 + villagepump 2026/06/13 + stakiran gist。manifest追記。touched 8 pages: 1 source + 1 entity new (OKF) + 1 concept new (一貫・網羅・頂点) + Lint・研究課題更新 + index/log)

## [2026-08-11] file-back | nishioのOKF評価（query回答をanalyses/に保存: format層のみ標準化 + cross-run stability批判 + 撤回の内実はドメイン違い。index/log更新）

## [2026-08-12] file-back | AIランチエ（query回答をconcepts/に保存: パレートのランチエ/スペキュラトゥール由来、接地の衛生の委譲と境界監督の落とし穴。index/log更新）

## [2026-08-12] file-back | GitHubリポジトリ分析の方法論（subagent 3体との相談結果をanalyses/に保存。発見層+選択的アーカイブ、Template Analysis、設計空間マップ、リスク一覧。index/log更新）

## [2026-08-12] split | 外部リポジトリ分析のリスクと罠（GitHubリポジトリ分析の方法論からリスク編を分離・拡充。6+3類型の分析罠、リスクマトリクス追加。親ページ・index/log更新）

## [2026-08-12] file-back | パイロット分析4ページ（subagentによる3 repo並行分析 → 個別3ページ + 横断所見1ページ。nishio/llm-wiki-about-nishio + grasp + takker99/AMME-2026S-report。index/log更新）

## [2026-08-12] file-back | パイロット分析追加2件 + 横断所見更新（BDL-2026S: 最大規模330p + llm-wiki-about-delite: 43時間停止/CLAUDE.mdのみ/Quartz。横断所見を5件に拡張、停止の2類型・init.txtパターン・命名規則2派・grasp名目利用の乖離を追加。index/log/manifest更新）

## [2026-08-12] file-back | パイロット発見のconcept化（5新規: purpose-hoist, 二層設計, 徒歩レビュー, 統合解説層, CLA.md管理 + 4更新: Schema, IndexとLog, スケーラビリティ, Post-ingestレビューにパイロット知見反映。index/log更新）

## [2026-08-14] ingest | Wikiとコードリポジトリの関係（nishio cosense: 勉強会「中にコードリポジトリを持つパターン」+ kouchou-ai-developer-wikiページ。raw/に1アーカイブ追加 + manifest追記。touched 6 pages: 1 source new + 1 concept new (Wikiとコードリポジトリの関係) + 3 existing updated (Wiki駆動開発, dd2030-wiki, 研究目的Wikiとプロジェクト目的Wiki) + index/log）。内容: 同一repo型vs別repo参照型の対比、SSOTの所在、raw 1ページあたりwiki<1の量的観察、「AIが読む想定」、記憶の外部化が目的

## [2026-08-14] review | 目的↔repo型の対応を検証（subagent相談2往復で「知識の蓄積→別repo参照型・成果物管理→同一repo型」の対応を検証 → 不成立と判定。反証例: grasp/BDL-2026S=知識蓄積+同一repo、dd2030-wiki=成果物管理+別repo。代替基準: コードの有無→生まれ方→知識の向き（wiki=SSOTか）→公開性。新規立ち上げは同一repoがデフォルト。concepts/Wikiとコードリポジトリの関係.md を改訂: 比較表更新 + 含意節の4段階選択 + work/運用規定追加（stalenessは防ぐのではなく記録する）。index/log更新）

## [2026-08-14] file-back | repo型の知見を4ページに分散（1: 概念ページに「読む主体はrepo型を決めない」「目的軸とrepo型軸は直交」を追記。2: リポジトリ分析BDL-2026Sに分類ラベル補正（主目的=知識蓄積の同一repo型反証例）。3: 研究課題に配布形式の要件「wiki/単独で取り出せる」を追記。4: 横断所見に#12「分類ラベルは目的ラベルでありrepo型ラベルではない」を追加。index/log更新）
