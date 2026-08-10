# Log

Append-only timeline of wiki operations.
Format: `## [YYYY-MM-DD] action | detail`

Each entry should be one line after the date header.
Parse with: `grep "^## \[" log.md | tail -5`

## [2026-08-01] init | wiki created for llm-wiki-template research

## [2026-08-01] file-back | このWikiの目的と研究課題 (created analyses/ page, updated index/log)

## [2026-08-11] source-loss | raw/の6ソース（nishio 4 + villagepump 2）がユーザー誤削除。raw/はgitignore対象のため復元不可。再取得予定

## [2026-08-11] refactor | 役割分離: AGENTS.mdを運用規則のみに縮小、テンプレート草案をanalyses/テンプレート草案ver.1へ原文ママ移管、README/overview修正 (touched 6 pages)

## [2026-08-11] ingest | LLM Wikiの作文リスク (concept page。きっかけ: overview.mdのソース一覧が実在1件のみと判明)

## [2026-08-11] repo-rename | llm-wiki-template → llm-wiki-research
