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
