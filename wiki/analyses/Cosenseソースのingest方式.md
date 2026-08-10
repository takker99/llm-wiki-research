---
status: hypothesis
date: 2026-08-11
tags: [template-design, cosense, ingest]
topic: Cosenseソース（nishio / villagepump）のingest方式
---

# Cosenseソースのingest方式（案）

Cosense（nishio 26Kページ / villagepump 44Kページ）の情報をこのwikiにどう取り込むか。
subagent相談（2026-08-11）の結果をまとめた**提案であり、決定ではない**。
実運用（6ファイル再取得、初回ingest）を経て検証・改訂する。

## 検討した3案

| 案 | 内容 | 長所 | 短所 |
|---|---|---|---|
| 1. smart context export | 関連ページをMarkdownでexportしてraw/へ | 凍結スナップショット。lintがそのまま効く。検証可能性が高い | 陳腐化、手動キュレーションが重い。発見力が弱い |
| 2. Cosense自体をrawとみなす | cosense-cliでその都度取得。sourceはURL | 常に最新。引用ごとの作業が軽い | 「読んだ時点の内容」を後日証明できない。ページ変更・削除・API変更のリスク |
| 3. grasp DBをraw/へ | grasp import済みDBをraw/に置きCLI経由で読む | 行レベル逆リンク・2-hop・未解決target検索が最強 | DBはバイナリでLLMが直接読めない。そもそも**派生物**であり原本（JSON）と層の意味が濁る |

前提の補正（subagentの事実確認）:
- grasp DBはvillagepumpのみimport済み。nishioは未import。`grasp sync`で差分更新可（陳腐化懸念は実質解消）
- `raw/*`がgitignoreされていることは「バックアップがない」ことを意味し、**2026-08-11の6ファイル誤削除の直接原因**。案2の「実態がなくても問題ない」は作文リスク対策の防衛線を外す

## 推奨案（subagent案・未検証）

「発見 → 生読み → 引用時アーカイブ」のパイプライン:

1. **graspは発見層**: DBは`~/.grasp`に置いたまま（raw/には入れない）。nishioは`acquire`追加、定期`sync`
2. **引用したページは必ずその場でcosense-cliで取得しraw/にMarkdownでアーカイブ**（案1の「重要ページだけ保全」より強い規則）
3. **manifest.mdをraw/直下に置きコミット対象に**（出典URL・取得日・ハッシュ記録）——gitignore起因の損失を仕組みで防ぐ
4. sourcesページには raw/リンク + cosense URL + アクセス日 を併記

併用案（必要になったら）: 出典JSONを`raw/cosense/<project>-<date>.json`で日付付きで入れる（原本=JSON、索引=DBの整理）。引用台帳（逐語引用+行permalink）は高リスクな主張に。

## テンプレート設計への含意（草案ver.2のclaims候補）

- ライブソースポリシー: 「raw/には読んだ時点のコピーを置く」を基本に、「URL+アクセス日+引用時アーカイブ」の二段構え
- 検証の2階層化: 無料の機械チェック（lint・ローカル存在）と、有料の再確認（URL再取得）を分離
- ツール非依存: 方針だけを書き、cosense-cli/graspはテンプレートの必須依存にしない
- 大規模ソース向けパターンは応用編に位置づけ、デフォルトAGENTS.mdには書かない（薄さの維持）
- 引用時アーカイブ規則は現行の「sourcesページは必ずraw/へリンク」の自然な延長として1行でデフォルトに含められる

## 未解決の論点

- [ ] 「引用時アーカイブ」と「軽微参照はURLのみ」の線引き（仮説: 主張の根拠→アーカイブ必須、案内リンク→URLのみ可）
- [ ] nishioはpartial acquireになるためbacklinks等が「取得済みsubset内」の結果になる。フルacquire vs 目的指向acquireの判断
- [ ] 6ファイルのタイトルは不明（ユーザー記憶喪失）。再ingest時に重要ページとして自然に再発見される見込み

## 関連

- [[LLM Wikiの作文リスク]] — この案の前提となるリスクと防衛線
- [[このWikiの目的と研究課題]] — 情報信頼性・配布形式の研究課題との接続
- [[テンプレート草案ver.1]] — 検証対象。本ページはver.2へのインプット
