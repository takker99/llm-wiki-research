---
status: hypothesis
version: 1
date: 2026-08-11
source: "git 6c821c1:AGENTS.md"
claims:
  - "AGENTS.mdが3層アーキテクチャ（raw/wiki/AGENTS.md）を定義する"
  - "ディレクトリは concepts/entities/sources/analyses の4分類が良い"
  - "ファイル名は自然言語（日本語等）が良い"
  - "index.mdを先頭で読むカタログ方式が検索基盤なしでスケールする"
  - "Cosenseの6原理がデフォルト設計の土台になる"
  - "1ソースで10-15ページに触れるのが期待される"
  - "人間はwiki/を読まなくてよい（read-optional）"
  - "wikilinkを本文中に書くべき（first-class）"
evidence: []
superseded_by:
---

# テンプレート草案ver.1

2026-08-11の役割分離リファクタでAGENTS.mdから移管された、最初のテンプレート仮説。

- **原文はgitにあり、このページは複製しない。** 縮小前AGENTS.mdの全文は
  `6c821c1:AGENTS.md` で完全に取得できる（取得: `git show 6c821c1:AGENTS.md`）。
  wiki/は派生物という原則に従い、本文はコピーせずポインタのみを保持する
  （[[LLM Wikiの作文リスク]]の複製ドリフト対策）。
- **研究対象なのはこのページのclaims（frontmatter）**であり、原文そのものではない。
- 改訂は ver.2 以降の新しい草案ページとして行う。このページは不変。
- このclaimsの検証は[[このWikiの目的と研究課題]]の問いに沿って行う。

## 検証方法

- このwiki自身の運用で実地検証する（自己適用）。破綻や乖離を観測したら、
  [`wiki/log.md`](../log.md) に記録し、本ページの `evidence` に追記する。
- 外部の既存実装（Microsoft llmwiki、llm-wiki.app 等）の分析と照合する。
- 「このAGENTS.mdで新規wikiが運用できるか」をテンプレートとして別wikiで試す（研究の完了定義）。

## 関連

- [[このWikiの目的と研究課題]] — 研究課題とTODO
- [[LLM Wikiの作文リスク]] — 複製を作らない理由
