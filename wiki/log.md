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
