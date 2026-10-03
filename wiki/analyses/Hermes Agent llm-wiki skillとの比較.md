---
sources: "[[2026-08-11 Karpathy LLM Wiki Gist]]"
tags: [comparison, hermes-agent, llm-wiki-pattern]
---

# Hermes Agent llm-wiki skillとの比較

Hermes Agentに組み込まれている`llm-wiki` skill（v2.1.0）と、本wikiのテンプレート（v0.1）を比較する。
機能レベルと設計思想レベルの双方で相違点を明らかにし、テンプレートの流儀から見たHermes側の意外な特徴を記録する。

## 比較の目的

- テンプレート設計の選択肢を、既存実装との対比で検証する（[[このWikiの目的と研究課題]]）
- Hermesの設計が「完成されたシステム」としてどこまで行っているかを確認し、テンプレートの「研究仮説」との距離を測る

## 機能レベルの相違点

| 機能 | Hermes `llm-wiki` | 本テンプレート |
|---|---|---|
| **管理ファイル** | 単一 SKILL.md（~400行） | AGENTS.md + 2 skill（ingest/lint）+ lint.sh |
| **ディレクトリ構成** | `raw/` → `entities/` `concepts/` `comparisons/` `queries/` → `SCHEMA.md` | `raw/` → `wiki/`（`concepts/` `entities/` `sources/` `analyses/`）→ `AGENTS.md` |
n| **frontmatter** | **必須**（title, created, updated, type, tags, sources, confidence, contested, contradictions） | **sources のみ必須**（raw:, source_url:, accessed:）。concepts/entities は任意 |
| **タグ管理** | SCHEMA.md にタグタクソノミー定義、lint で監査 | タグなし（frontmatter 任意） |
| **provenance** | `^[raw/articles/source.md]` 段落末マーカー | sources ページへの wikilink（claim 粒度） |
| **source drift 検出** | `sha256` で raw ファイルの変更を検出 | なし |
| **矛盾処理** | frontmatter `contested: true` + `contradictions: [page]` | lint の意味チェック（LLM が手動判定） |
| **品質シグナル** | `confidence: high/medium/low` | なし |
| **lint** | 12項目（orphan, broken link, index, frontmatter, stale, contradiction, quality, drift, size, tag, log rotation） | 機械チェック（orphan, broken link, index, stale）+ 意味チェック（矛盾, 古い主張, 概念欠落, クロスリファレンス不足, 著者-年表記の棚卸し） |
| **Obsidian 連携** | 充実（wikilinks, graph view, dataview, **obsidian-headless** サーバー同期） | なし（git 管理が前提） |
| **ファイル命名** | lowercase, hyphens, no spaces（英語強制） | **人間の使用言語**（日本語可、説明的な自然言語名） |
| **wikilink** | `[[wikilinks]]`（大文字小文字区別） | `[[ページタイトル]]`（**大文字小文字区別しない**） |
| **赤リンク** | broken wikilink として検出 | **許容**（情報の不在の表現。2ページ以上で参照されたらページ作成候補） |
| **ページ作成閾値** | 2+ sources or central to one source | 明示的な閾値なし（「2ページ以上から参照」で判断） |
| **更新ポリシー** | 追記ではなく**書き換え**（raw が source of truth） | 同じく**書き換え**（raw が source of truth） |
| **concepts の扱い** | 200行超で分割提案 | **atomic** に保つ（1ページ1概念） |
| **file-back** | `queries/` に保存 | `analyses/` か `concepts/` に保存 |
| **目的（purpose）** | なし（domain は SCHEMA.md に記述） | **必須**（AGENTS.md の唯一の記入事項） |
| **配布形式** | Hermes skill（`~/.hermes/skills/`） | `template/` ディレクトリをコピー + `git init` |
| **環境変数** | `WIKI_PATH`（デフォルト `~/wiki`） | なし（AGENTS.md がルート） |
| **研究課題** | なし | **明示的**（M1/M2 マイルストーン、研究課題を列挙） |

## 設計思想レベルの相違点

| 思想 | Hermes `llm-wiki` | 本テンプレート |
|---|---|---|
| **主体** | **Agent が全てを管理**（frontmatter 必須、タグタクソノミー、provenance、sha256） | **人間とLLMの共進化**（AGENTS.md が人間向け、frontmatter 最小限） |
| **信頼の置き所** | **機械的メタデータ**（frontmatter の confidence/contested/contradictions） | **人間の判断**（lint の意味チェック、目的への立ち返り） |
| **不変性** | `raw/` 不変 + `sha256` で完全検証 | `raw/` 不変（検証は人間の目） |
| **ナビゲーション** | `index.md` + `SCHEMA.md`（agent が管理） | `index.md` + `overview.md`（人間が読む） |
| **拡張性** | タグタクソノミーに閉じている（新しいタグは SCHEMA.md に追加） | タグなし（frontmatter 自由） |
| **ツール依存** | Obsidian 生態系（dataview, obsidian-headless） | git + エディタ（ツール非依存） |
| **言語** | 英語前提（lowercase, hyphens） | **言語非依存**（日本語ファイル名可） |
| **完成度** | 完成されたシステム（v2.1.0） | **研究仮説**（v0.1、検証対象） |
| **配布** | プラットフォーム組み込み | **as-is starter kit**（改変・フォーク推奨） |

## テンプレートの流儀から見た、Hermes llm-wiki の意外な特徴

1. **Agent への権限集中** — Hermes は agent に frontmatter の必須フィールド（confidence, contested, contradictions）を埋めさせ、タグをタクソノノミーに強制する。これは「agent が全てを管理」する思想だが、テンプレートの流儀（「人間とLLMの共進化」「frontmatter 最小限」）から見ると、**agent に意思決定権を与えすぎている**と感じられる。特に `confidence` の判定は主観的であり、agent に任せると「high」に倒れやすい。

2. **provenance の過剰設計** — `^[raw/articles/source.md]` 段落末マーカーは、テンプレートでは「sources ページへの wikilink」で代替される。Hermes の設計は**出所追跡を機械化**しようとするが、テンプレートの流儀から見ると「sources ページへのリンクがあれば十分」であり、**段落粒度のマーカーは過剰**に見える。

3. **sha256 による完全検証** — raw ファイルの sha256 を保存し、re-ingest 時に drift を検出する。これはテンプレートにない機能だが、テンプレートの流儀（「raw/ は不変。人間が明示的に依頼した場合のみ変更」）から見ると、**raw の不変性を信頼していない**ように見える。実際には「raw が変更されたら wiki の記述も更新が必要」という実用的な配慮だが、テンプレートは「raw は不変」という前提を人間の運用に委ねている。

4. **Obsidian への最適化** — obsidian-headless によるサーバー同期、dataview クエリ、graph view への言及は、テンプレートには全くない。テンプレートは git + エディタを前提とし、**特定のツールに依存しない**設計思想。Hermes の llm-wiki は Obsidian ユーザーに最適化されているが、テンプレートの流儀から見ると**ツールロックイン**に見える。

5. **「追記ではなく書き換え」の共通点** — 両者とも「追記ではなく書き換え」を原則としている。これは意外な**共通点**。テンプレートの AGENTS.md に「既存の記述に手を加えず追記だけするのはwikiではない」と明記され、Hermes も「When updating a page, always bump the `updated` date」とある。ただし Hermes は frontmatter の `updated` 日付を機械的に bump するだけで、テンプレートは「統合して書き直す」という**人間の判断**に委ねている。

6. **赤リンクの扱い** — Hermes の lint は赤リンクを「broken wikilink」として検出するが、テンプレートは赤リンクを**許容**する（「情報の不在の表現」）。これは設計思想の根本的な相違。Hermes は「完全な wiki」を目指し、テンプレートは「**未完成の wiki**」を許容する。→ [[赤リンクとLLM Wiki]]

7. **研究リポジトリとしての自己言及** — テンプレートは「このrepoは研究リポジトリであり、テンプレート本体ではない」と明言し、研究課題（M1/M2 マイルストーン）を列挙する。Hermes の llm-wiki は**完成されたスキル**として配布され、研究課題やマイルストーンは存在しない。テンプレートの流儀から見ると、Hermes の llm-wiki は**研究プロセスの痕跡を隠している**（あるいは研究する必要がない完成度だが）。

8. **「目的」の必須化** — テンプレートは AGENTS.md の「目的」を唯一の記入事項とし、「空欄のまま運用しない」と明記。Hermes の llm-wiki は `domain` を SCHEMA.md に記述するが、**必須ではない**（テンプレートに `[What this wiki covers]` とあるだけ）。テンプレートの流儀から見ると、Hermes は**目的なしで wiki を始められる**設計であり、これは「何でも入る wiki」になりやすい。

## テンプレート設計への含意

- Hermes の実装は「agent が全てを管理する完成されたシステム」の極端な例。frontmatter 必須、タグタクソノミー、provenance、sha256、Obsidian 連携は、すべて「agent の判断を機械化し、人間の介入を減らす」方向の設計。
- テンプレートは「人間とLLMの共進化」を前提とし、frontmatter を最小限に抑え、赤リンクを許容し、目的を必須化する。これは「agent の判断に依存せず、人間の判断を残す」方向の設計。
- 両者の間には「agent の判断 vs 人間の判断」という根本的なトレードオフが存在し、テンプレートは「人間の判断」を優先する立場を明確にしている。
- Hermes の「完成されたスキル」としての配布は、テンプレートの「研究仮説」としての配布とは対照的。テンプレートは「検証対象」であり、Hermes は「完成品」である。

## 関連概念

- [[LLM Wiki]] — 全体パターン
- [[テンプレート草案ver.1]] — テンプレート設計の仮説
- [[LLM WikiテンプレートのOptionality]] — オプショナリティの原則
- [[このWikiの目的と研究課題]] — 研究課題とTODO
- [[Microsoft llmwiki]] — 既存実装の分析
- [[Schema（AGENTS.md）]] — 設計文書
- [[赤リンクとLLM Wiki]] — 赤リンクの扱い
- [[LLM Wikiの作文リスク]] — 複製リスク
- [[繋げる力]] — 「読み返したい形に育てる」実践の概念化
