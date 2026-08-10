---
sources: ["[[2026-08-11 OKFとLLM Wiki (nishio+villagepump)]]"]
source_url: https://cloud.google.com/blog/products/data-analytics/how-the-open-knowledge-format-can-improve-data-sharing
accessed: 2026-08-11
tags: [template-design, okf]
---

# OKF

Open Knowledge Format。2026-06-12にGoogle Cloud Data Cloudチームが発表したオープン仕様。知識（メタデータ・文脈・キュレーションされた洞察）をmarkdownファイル + YAML frontmatterのディレクトリとして表現する、ベンダーニュートラルでエージェント・人間双方に読みやすい形式。公式には「LLM-wikiパターンをportableでinteroperableな形式にformalizeする」と位置付けられる。

## 仕様の概要

- **バージョン**: 発表時v0.1（2026-06-12）→ v0.2（provenance/trust/lifecycle/attestationをfirst-class化。後方互換）
- **必須フィールド**: `type` のみ。未知のtypeは寛容に扱う
- **構造**: 概念1つ=1ファイル。**ファイルパスがconceptのID**。YAML frontmatter + 自由な本文（必須セクションなし）
- **追加フィールド**: title / description / resource（元になるデータ資産のURI）/ tags、v0.2でprovenance（sources・信頼シグナル）・trust（generated / verified）・lifecycle（status: draft→stable→deprecated、stale_after）・Attested Computation
- **原則**: schema registryなし、中央権威なし、必須ツールなし。「catで読めてgit cloneで運べる」
- **レポジトリ**: GoogleCloudPlatform/knowledge-catalog（OKF + mdcode等の参照ツール + サンプルbundle）

## 性格: データカタログ由来

stakiranの分析（[[2026-08-11 OKFとLLM Wiki (nishio+villagepump)]]）:

- OKFのDNAはwiki文化ではなく、Dataplex系のデータカタログ（Entry / Aspect / EntryLinkモデル）。仕組み（markdown + frontmatter + リンク + index）はwikiの末裔だが、性格（何を概念とし、どう型付けし、何に紐づけるか）はデータカタログ
- 位置づけとしては「Metadata as Code」— メタデータの真実の源を専用サービスからGitリポジトリのファイルへ移す設計思想。観測された事実（データ側がマスター、source→file）とキュレーションされた知識（ファイル側がマスター、file→service）でマスターが層ごとに分かれ、`catalog.yaml` のsnapshot/publishingがその境界を宣言する
- 「Knowledge Format」より「Knowledge Packaging Format」に近い。ナレッジを作る装置ではなく、作ったものを載せる宛先

## LLM Wikiとの比較

| | OKF | KarpathyのLLM Wiki |
|---|---|---|
| 標準化対象 | 成果物（フォーマット）層 | 操作（足場）層 + 成果物 |
| 赤リンク | 壊れリンク=「未記述知識」として許容（§9） | lintがエラー扱い |
| 由来 | データカタログ（Dataplex） | 知的生産の方法論 |
| 進化 | provenance/trust/lifecycle/attestation | AGENTS.mdの運用規則 |

Google自身はOKFを「LLM Wikiの改良版」と位置付けており、nishioは「標準化戦争」と認識している（[[2026-08-11 OKFとLLM Wiki (nishio+villagepump)]]）。

## 関連概念

- [[2026-08-11 OKFとLLM Wiki (nishio+villagepump)]] — 本ページの主ソース
- [[nishioのOKF評価]] — nishioの2つの否定理由（format層のみ・cross-run stability批判）
- [[LLM WikiテンプレートのOptionality]] — format層/操作層の区別（差別化点）
- [[Lint]] — 赤リンク論争（許容 vs エラー）
- [[一貫・網羅・頂点]] — OKFのenrichment evalが求めるcross-run stability批判
- [[LLM Wikiの作文リスク]] — 接地（provenance）の重要性
- [[LLM Wiki]] — OKFが「formalize」すると主張するパターン
