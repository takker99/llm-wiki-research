---
summary: "wikiの健全性チェック。矛盾検出＋新調査課題の提案。未解決リンクは参照数で分類し、OPEN_LINK語彙の正本を持つ"
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]", "[[リポジトリ分析 microsoft-llmwiki]]", "[[2026-10-27 LLM知識ベースの言語ドリフト検証]]"
tags: [template-design, llm-wiki-pattern]
---

# Lint

LLM Wikiの3基本操作の1つ。wikiの健全性を定期的にチェックするプロセス。

## Karpathyの定義するチェック項目

- ページ間の矛盾
- 新しいソースに取って代わられた古い主張
- 入リンクのない孤立ページ
- 言及されているが概念ページのない重要概念
- 不足しているクロスリファレンス
- 埋められるデータギャップ（Web検索で補完可能なもの）

Lintのもう一つの重要な役割: **新しい調査課題と探すべきソースを提案すること。** これは単なるエラー検出ではなく、wikiの成長を方向付ける機能。

## nishioの実践知

- AIが自動的にLintを呼び出すこともある
- 「しばらくLintをやってないものを発見する仕組み」を作ろうとしたが、予想より自動的に整えられていることが多い
- [[AIによるingest停止判断]]はLintの延長線上にある——AIがソースの質を評価し取捨選択を提案

## 実務で検出されるドリフト（tsurubeeの実践）

tsurubeeの運用報告: ingestを繰り返すと「`agent-harness`と`エージェントハーネス`と`harness`が別ページとして存在」「`reinforcement-learning`タグと`rl`タグが混在」のような表記揺れ・粒度の違いによる重複カテゴリが必ず生じ、定期lintで崩れの累積を防ぐ。当wikiの[[LLM WikiテンプレートのOptionality]]原則（命名規約はユーザー任せ）との関係で、重複ドリフトはテンプレートが想定すべきコストの実例。

## 当wikiでの実装

AGENTS.mdでは機械チェックと意味チェックに分類:
1. 機械チェック: 孤立ページ、オープンリンク（未解決wikilink）、index未掲載、raw/参照不整合
2. 意味チェック: 矛盾、古い主張、概念ページ不在、クロスリファレンス不足
3. 新しい調査課題とソースの提案
4. 重大度別報告 + 機械的問題の自動修正提案

スクリプト: `bash .agents/skills/llm-wiki-lint/scripts/lint.sh`（[[AGENTS.md+SKILL.md二層設計]]のskill同梱構成。参考: [[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]）

## 機械lintの実装例（Microsoft llmwiki）

[[Microsoft llmwiki]] の `lintWiki` は6カテゴリをソフトウェア実装:
broken-links（error）/ **stale-entries**（error: indexエントリ→削除ファイル）/
orphan-pages（warning）/ **index-completeness**（warning: index未掲載）/
missing-pages（info: 参照のみで未作成）/ frontmatter-validation。
当wikiの機械チェックにない分類は **stale-entries**（indexエントリの陳腐化検出）と
**index-completeness**（index掲載漏れの分離）で、機械チェック拡張の参考になる。
→ [[リポジトリ分析 microsoft-llmwiki]]

## 赤リンクと参照数分類lint

OKFは壊れリンクを「未記述知識」として許容し、LLM Wiki系の実装にはエラー扱いするものも多い。本wikiは2026-10-24に「オープンリンク（未解決リンク）」として許容する語彙へ変更した。赤リンクの理論・リンクの4仕事・come-from・参照数分類の由来は [[赤リンクとLLM Wiki]] に集約している。

lint側の現在の出力語彙:

| 出力 | 参照数 | 扱い |
|---|---|---|
| OPEN_LINK (1 page) | 1ページ | 表記ゆれ・パス形式・未作成ページのいずれか。意図的なら放置、表記の誤りなら修正 |
| OPEN_LINK (n pages) | 2+ページ | 仮想ページ／概念ハブの種。ページ作成を候補として提案 |

`broken_wikilink` / `aspect_handle` はBDL-2026Sの語彙で、分類の由来は [[赤リンクとLLM Wiki]] を参照。本wikiでは [[fact-wiki-separation]]（3ページ参照）が、参照数分類から概念ページ化された最初の事例。

## 機械検査で捕捉できないドリフト（2026-10-27 ingest）

マルチエージェント通信研究の分類では、語用論的ドリフト（流暢さと表層の意味整合を保ったまま機能的解釈が標準から乖離する現象）は流暢性指標や単純な接地指標では自動検知できない（[[2026-10-27 LLM知識ベースの言語ドリフト検証]]）。機械lintが捕捉するのは形態・構文の表層までであり、意味の乖離は意味チェック（矛盾・陳腐化）とraw/との照合に依存する。→ [[言語ドリフト（LLM Wiki）]]

reconciliation（可逆的照合）への拡張案: 概念ページの主張文から複合名詞化・抽象化表現を検出したら、紐づくraw/原典を再読して動作主・極性・境界条件を明示した命題形式へ展開し直す。stale-claims検出（未実装）とraw再読の組み合わせとして提案されており、stale-claimsの論点整理は[[ingestの意義とsourcesページの役割]]にある。

## 関連操作

- [[Ingest]] — 新しい知識の流入（lintはその品質管理）
- [[QueryとFile-back]] — 探索（lintはその網羅性チェック）
- [[IndexとLog]] — lint結果を反映する基盤
- [[LLM Wikiの実運用データ]] — Lintが検出すべきスケール問題
- [[繋げる力]] — 概念ページの重複ドリフトが繋がりを阻害する
