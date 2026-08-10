---
status: tentatively-adopted
date: 2026-08-11
tags: [template-design, raw, ingest]
topic: raw/の取り扱い（gitignore・プライバシー・ライセンス・発見層の区別）
---

# rawディレクトリの取り扱い

`raw/*` はgitignoreされており、`raw/` はgitの管理外にある（karpathyのgistすらuntracked）。
この状態は意図的なものだが、トレードオフを整理し、テンプレートのデフォルトをどうするかを検討する。
一部は[[Cosenseソースのingest方式]]（2026-08-11）で仮採用済み（manifest.md・発見層の分離・lint対応）。

## gitignoreの動機（ユーザーによる意図、2026-08-11）

- **graspのrepoが同様の運用**をしていた: `raw/`=外部ソース（設計対話ログ・Codex作業ログ等）、不変・gitignored（grasp commit a7ff7d3 で確認）
- **privateな情報**を入れたとき、git logにデータを残すのはまずい
- **論文PDFをそのまま入れると転載**になる（著作権）
- **repoをsourceとしたとき、その全部をraw/に入れるのか？** という疑問
- private repoでやるぶんには全く問題ない

注: 「発見層とrawの区別」はgraspの設計ではなく、[[Cosenseソースのingest方式]]側のフレーム。
graspで発見を担うのはSQLite store + CLI（`~/.grasp`、これもgitignored）で、raw/はあくまで外部ソース置き場。

### grasp・nishio系wikiでの検証（2026-08-11）

grasp本体の全履歴（commit e3c9625〜a7ff7d3）を調査した結果:

- `raw/` のgitignoreは**初期scaffold（create_wiki.py）に最初から含まれており**、以降変更なし。**判断プロセスの記録はgrasp内に存在しない**（テンプレートのデフォルトとして継承されたと推定）
- 理由が明文化されているのはnishioの派生wiki `llm-wiki-about-nishio`:
  - .gitignoreコメント: 「Large source corpus (**regeneratable** via `git clone ...` raw/external_brain_in_markdown)」— **再生成可能だからignore**
  - AGENTS.md: 「本Wiki repo は public なので、raw/ には公開Cosense由来のbundleのみを置く。**private project / 非公開ソースは絶対に混入させない**」
- **実運用前例**: `llm-wiki-about-nishio` は raw/ にgit cloneを丸ごと配置（`raw/external_brain_in_markdown`、gitignored、`git pull`で更新可）。URLは.gitignoreコメントとAGENTS.mdに記録。→ 今回の「repoをraw/にclone」議論の先行実装であり、「clone丸ごと+gitignored+再生成可能」という選択肢の実証

→ この発見は下記「テンプレート設計への含意」の「gitignoreのデフォルト」「manifest.md」にインプットする。

## gitignoreの二面性

| 面 | 内容 |
|---|---|
| 負 | バックアップ・履歴なし。**2026-08-11の6ファイル誤削除の直接原因**（[[Cosenseソースのingest方式]] line 24） |
| 正 | private情報のgit log残留防止、著作権のある資料の転載防止。**プライバシー・著作権の防御として機能** |

[[Cosenseソースのingest方式]] は負の面だけを記録していたため、正の面（防御としての機能）をここで補足する。

## 既存提案との接続: 発見層とrawの分離

[[Cosenseソースのingest方式]] の「発見層 → 生読み → 引用時アーカイブ」パイプラインは、
raw/全体の取り扱いに一般化できる仮説:

1. **発見層**: 大きなソース集合体（Cosense DB / 分析対象repoのclone）は `raw/` 外に置く
2. **生読み**: 探索・分析は発見層に対して行う
3. **引用時アーカイブ**: 実際に参照・引用したファイルだけを `raw/` にコピー
4. **manifest.md**: URL・commit hash・取得日・ハッシュを記録し、**コミット対象にする**（`raw/*` はignoreされたままなので、manifest.md はネガティブパターンでコミット対象に復帰させる）

## repoをsourceとした場合の適用（2026-08-11の議論）

「llm wiki実践例repoの運用分析」のケース:

- cloneは `raw/` 外（`~/git/` や `/tmp`）に置く = 発見層
- 分析で実際に引用したファイル（AGENTS.md、index.md、ディレクトリツリー等）だけを `raw/<repo>/` へ
- manifest.md にURL・commit hash・取得日・対象ファイル一覧
- これで「repo丸ごとをraw/に」の否定と「無管理の引用」の両方を避ける

lint上の注意（2026-08-11解決）: 参照チェックは `raw/` 直下の `.md` しか見なかった（正規表現がスラッシュを含むパス・空白入りパスに非対応）が、[[Cosenseソースのingest方式]]8に従いlint.shを修正済み。

## テンプレート設計への含意（草案ver.2のclaims候補）

- **gitignoreのデフォルトはどちらか**: 公開repoなら「commitして配布」が自然だが、private情報・著作権の観点ではignoreにも理がある。公開/非公開で挙動を変えるかも論点
- **manifest.mdのコミット対象化**は損失防止の防衛線として有力（gitignoreと両立可能）
- 発見層とrawの区別はデフォルトのAGENTS.mdに書くか、応用編に置くか（薄さの維持との兼ね合い）
- gitignoreのままなら**バックアップの代替手段**（別途の定期バックアップ等）をどうするか

## 未解決の論点

- [ ] gitignoreのデフォルト（public / privateで変える？）
- [ ] 著作権のある資料（論文PDF等）の扱い（要約のみ？ 引用の範囲？）
- [ ] gitignore維持時のバックアップ手段（manifestは防衛線の一部。代替手段は未定）

解決済み（[[Cosenseソースのingest方式]]）:
- manifest.mdのコミット対象化 → 仮採用（項目5。.gitignoreに `!raw/manifest.md`）
- 発見層の位置づけ → 仮採用（項目1。デフォルトのAGENTS.mdには書かず応用編のclaimsに留める）
- lintのサブディレクトリ・空白対応 → 仮採用（項目8。lint.shに反映済み）

## 関連

- [[Cosenseソースのingest方式]] — 本ページの前提となるパイプライン提案
- [[LLM Wikiの作文リスク]] — raw/による防衛線の概念
- [[このWikiの目的と研究課題]] — 情報信頼性・配布形式の研究課題との接続
- [[テンプレート草案ver.1]] — 検証対象。本ページはver.2へのインプット
