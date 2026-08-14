---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]", "[[リポジトリ分析 microsoft-llmwiki]]"
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
1. 機械チェック: 孤立ページ、壊れたwikilink、index未掲載、raw/参照不整合
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

## 赤リンク論争（OKF §9との対比）

[[2026-08-11 OKFとLLM Wiki (nishio+villagepump)]]: OKFは壊れリンクを「未記述知識」として許容（§9）するのに対し、このwiki含むLLM Wiki系はlintが壊れリンクをエラー扱いする。nishioは「意図的な前方参照（未作成ページへのstub）とリネーム漏れ/誤りを区別する余地。前者を許す運用はwikiを育てやすい」と指摘する。

- Cosenseの「同一の赤リンクが複数ページに出現→仮想的ページ（バックリンクリスト）ができる＋2ホップリンクで繋がる」挙動は一歩先で、OKFにも言及がない
- concept ID＝ファイルパスのOKF・素のMarkdown wikiは赤リンクを「解決しないパス＝エラー」としか扱えず、キーワードベース・リンク（タイトル同一性での自動集約）の利点を取りこぼす（[[OKF]]、[[赤リンクの数の議論のLLM Wiki]]）
- 本wikiは lint が basename 解決している分、偶然半分キーワード化していてこの利点に近い。「同一の赤リンクを共有する既存ページ群を2ホップ関連として提示」すれば、エラー（リネーム漏れ）と発見（前方参照）を分離できる（Karwiの提案）

## 参照数分類lint（赤リンク論争への具体的解）

2026-08-14 ingestで、赤リンク論争（許容 vs エラー）に対する**第3の選択肢**が実装データとして揃った（[[赤リンクとLLM Wiki]]）: 未解決wikilinkを**参照数で分類**する。

| 分類 | 参照数 | 扱い | 実装 |
|---|---|---|---|
| broken_wikilink | 1ページのみ | error。typo or private jargon。ページ作成はしない | [[リポジトリ分析 BDL-2026S]] |
| aspect_handle | 2+ページ | info。概念ハブの種。Cosense風では正常。参照が増えたらページ作成 | [[リポジトリ分析 BDL-2026S]]、[[リポジトリ分析 SMS-2026S-report]] |

BDL-2026Sの明文化（AGENTS.md）: 「Do not treat unresolved wikilink references as a TODO list. In Scrapbox/Cosense style, red links are a feature... Do not create a page for a 1-page reference.」。SMS-2026S-reportは「unresolvedはbrokenではない、全て実参照」「2+頁参照=2-hop hubの種」とlintコメントに明記。

**当wikiでの実装（2026-08-14）**: 参照数分類を導入（1頁= B R O K E N / 2+頁= ASPECT_HANDLE、エイリアス解決、インラインコード除外）。スクリプトはroot `scripts/lint.sh`から`.agents/skills/llm-wiki-lint/scripts/lint.sh`へ同日移動（llm-wiki-lint skill同梱。[[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]の改訂）。AGENTS.mdのLintセクション・執筆要件にも「赤リンクは許容」を明文化。lint結果の`[[fact-wiki-separation]]`（3頁参照=ASPECT_HANDLE）が概念ページ化された最初の事例。

graspの理論的裏付け（[[リポジトリ分析 grasp]]）: リンクにはrecall / attention / navigation / 読者ケアの4仕事があり、Cosenseはsubstrate制約で全部を1つのlinkに束ねている。recallをlinkの外へ出せば、linkは必須（infrastructure）から任意（editorial）に変わる。**書き手がAI化するほど裸言及が増える**（AI default 裸）ので、wikilink強制より赤リンク許容＋come-from（用語-大域の1宣言で全出現をgather）が向く可能性がある。

## 関連操作

- [[Ingest]] — 新しい知識の流入（lintはその品質管理）
- [[QueryとFile-back]] — 探索（lintはその網羅性チェック）
- [[IndexとLog]] — lint結果を反映する基盤
- [[AIによるingest停止判断]] — Lintの延長としての自己評価
- [[LLM Wikiの実運用データ]] — Lintが検出すべきスケール問題
- [[繋げる力]] — 概念ページの重複ドリフトが繋がりを阻害する
