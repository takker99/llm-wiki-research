---
raw: raw/zenn-tsurubee-KarpathyのLLM_Wikiを1ヶ月運用してわかった繋げる力.md
source_url: https://zenn.dev/tsurubee/articles/llm-wiki-connecting-knowledge
accessed: 2026-08-11
tags: [template-design, llm-wiki-pattern]
---

# 2026-08-11 KarpathyのLLM Wikiを1ヶ月運用してわかった繋げる力 (tsurubee)

zenn記事（2026-05-15公開）。KarpathyのLLM Wikiを1ヶ月運用した個人の実践報告。
SAKURA internetの研究者（AI/ML for drug discovery and material science）による。

## 要約

- **中心的主張**: LLMの真価は要約ではなく「繋げる力」（複数ソースを横断して概念ページが自動で組み上がること）。要約は一次資料の凝縮に閉じるが、繋げる作業は別々のソースを並べないと見えなかった構造を取り出す
- **三層構造・3オペレーションの紹介**: Karpathy gistの要約（三層・bookkeeping論・compounding）。新規性なし
- **実例1**: Automated Scientific Discovery論文10本を順次ingest→評価軸が4カテゴリ（実行ベース/実ピアレビュー/LLM-as-Judge/実wet-lab検証）に整理され、独立した3論文の観察（2.3pt甘い/9-10reject/68pt変動）が「LLM-as-Judgeは中立な評価軸ではない」という1パターンに統合
- **実例2**: AltmanとAmodeiのエッセイ4本を別々にingest→`agi.md`に両者のAGI定義の対比が自動的に立ち上がった。多数同種ソースの統合（事例1）と少数異種視点の対比抽出（事例2）の2タイプを提示
- **運用知見2点**: Lintが表記揺れ・重複カテゴリのドリフトを検出（`agent-harness`/`harness`等）。Query結果のファイリングが探索を資産化し、回答スコープが自分のキュレーションに閉じることで「狭いぶん深い」回答になる
- **導入3ステップ**: (1) gistをLLMに読ませ雛形を作る（ミニマム構成サンプル: CLAUDE.md + 4スキル + vault/、ingest-paper SKILL.md全文あり）(2) 5本ingestして「読み返したい形か」を確認 (3) テンプレをドメインに合わせてLLMと育てる
- **課題**: 人間が読んで理解することがボトルネック。対策としてソース選定は手動主義（自動ingestは「いつの間にページができたんだ」状態を招くとして警戒）

## 考察（このwikiの評価）

### 新規性は限定的。nishio/villagepumpより考察が浅い

- 前半のアーキテクチャ説明はgistの忠実な要約で、[[3層アーキテクチャ]]・[[Ingest]]・[[Lint]]等の既知内容を超えない
- 「繋げる力」は実質[[ingestにおける編み込みの実際]]（既存ページへの波及更新）の体感報告であり、nishioの[[LLM Wikiは要約の改良版ではない]]（圧縮しない・注意の足場）や[[読まれなくてよい中間産物]]のような設計原理の深化がない
- ユーザー評価（ingest時）: 「考察が浅く要約どまり。llm wikiを人間が読むために整えようとしている雰囲気」—— これは下記の「理解のボトルネック」論に結晶している

### 「人間が読む前提」の設計思想はnishioと正面対立

記事は「wikiを人間が読んで理解しないと自分の知識にならない」を前提とし、概念ページを「自分が読み返したい形に育てる」ことを目的とする。これは[[読まれなくてよい中間産物]]（読む主体はLLMへ、読みやすさは不要）の否定に近い。
→ [[理解のボトルネック]]として概念化。テンプレート設計のopen question（可読性重視 vs read-optional）

### テンプレート設計に使える具体案

- 概念ページに「横断的知見」「未解決の問い」セクションを必置にするingestスキル運用 → [[Ingest]]
- ミニマム構成サンプル（CLAUDE.md + 4スキル + vault/、SKILL.mdの最小例）→ [[LLM WikiテンプレートのOptionality]]・[[Schema（AGENTS.md）]]
- queryのスコープ閉鎖性（自分のキュレーションしたソースだけを根拠に答える）→ [[QueryとFile-back]]
- 手動ソース選定主義（自動ingestへの警戒）→ [[バッチIngest]]・[[AIによるingest停止判断]]

## 関連

- [[繋げる力]] — 記事の中心概念を一般化
- [[理解のボトルネック]] — 記事が提起した課題（nishioとの対立点）
- [[LLM Wikiは要約の改良版ではない]] — 記事の「要約より繋げる力」論との異同
- [[2026-08-11 Karpathy LLM Wiki Gist]] — 記事の要約元
- [[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]] — より深い実践知の対比対象
