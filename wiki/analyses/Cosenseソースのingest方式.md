---
status: tentatively-adopted
date: 2026-08-11
tags: [template-design, cosense, ingest]
topic: Cosenseソース（nishio / villagepump）のingest方式
---

# Cosenseソースのingest方式（仮採用）

Cosense（nishio 26Kページ / villagepump 44Kページ）の情報をこのwikiにどう取り込むか。
subagent相談2往復（2026-08-11）を経て**仮採用**（[[Cosenseソースのingest方式]]）。実運用（6ファイル再取得、初回ingest）を経て検証・改訂する。

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

## 仮採用セット（2026-08-11）

subagent相談2往復（lint正規表現は実機検証済み）を経て仮採用。検証条件（10）を満たしたらvalidatedの候補、**2026-09-11のReviewで再評価**。

1. **パイプライン**: 発見層（grasp DB・repo cloneはraw/外）→ 生読み → 引用時アーカイブ。cosense-cli/graspは前提にせず方針のみ
2. **線引き**: 主張の根拠（引用・数値・要約の元）→ アーカイブ必須。存在確認・案内リンクのみ → URLのみ可。**迷ったらアーカイブ**
3. **アーカイブ追加の例外**: アーカイブの新規追加と `raw/manifest.md` への追記のみ許可。既存ファイルの変更・削除は従来通り禁止（AGENTS.mdに反映済み）
4. **アーカイブ配置・命名**: `raw/cosense/<project>/<title>-<YYYY-MM-DD>.md`。サブディレクトリ必須（同名ページ衝突回避）。タイトル内の`/`は`_`に置換。同一内容の再取得はmanifestのハッシュ照合で省略可
5. **manifest.md**: `raw/manifest.md` をコミット対象化（.gitignoreに `!raw/manifest.md`）。エントリ: プロジェクト/タイトル/URL/取得日/sha256/パス。**追記のみ**。URL+タイトルはgit logに残るため、非公開にしたい出典は載せない
6. **ハッシュ**: sha256で開始。pageId/commitIdは「URL改名で壊れた」「ページ同一性が争われた」事例が出たら拡張
7. **sources frontmatter**: 全ページ任意 `sources:`（`raw/パス` リスト。空白入りはダブルクォート。rawへの参照は必ずパス形式）。sources/ページ必須 `raw:`（リスト・1以上）+ 任意 `source_url:` / `accessed:`（AGENTS.mdに反映済み）
8. **lint**: (i) raw参照チェックの正規表現をサブディレクトリ・空白入りパス対応に (ii) sources/の `raw:` 必須チェック (iii) sources/を孤立チェックへ追加（index.md除外=未消化ソース判定）（lint.shに反映済み）
9. **役割分担**: manifest.md（raw/側）= 取得の事実・損失防止の台帳。sources frontmatter（wiki/側）= ページの根拠宣言。同一パスを共有するため実質的な突合が可能
10. **検証条件**: 初回Cosense再取得（6ファイル）+ 引用時アーカイブ数回の実運用で (a) lint通過 (b) manifest+アーカイブからの復元成功 を確認。再評価は2026-09-11のReview

## 未解決の論点

- [ ] nishioはpartial acquireになるためbacklinks等が「取得済みsubset内」の結果になる。フルacquire vs 目的指向acquireの判断（6ファイル再取得時に自然に判断材料が出る）
- [ ] 6ファイルのタイトルは不明（ユーザー記憶喪失）。再ingest時に重要ページとして自然に再発見される見込み
- [ ] タイトルのOSファイル名上限（255バイト）対処（起きたら対処。Grow first, split later）

## 関連

- [[LLM Wikiの作文リスク]] — この案の前提となるリスクと防衛線
- [[このWikiの目的と研究課題]] — 情報信頼性・配布形式の研究課題との接続
- [[テンプレート草案ver.1]] — 検証対象。本ページはver.2へのインプット
