# LLM Wiki Research — AGENTS.md

このリポジトリは、**汎用LLM Wikiテンプレートを研究するための研究wiki**です。
本ファイルは研究wikiを動かすための最小限の運用規則であり、テンプレート設計の主張ではない。

## このWikiの目的（研究課題）

KarpathyのLLM Wikiパターン、nishioの実践知、villagepumpの議論をingestし、以下の問いに答えていく:

- 汎用テンプレートとして何を提供すべきか？ 何をユーザー任せにするか？
- 汎用`AGENTS.md`には何を書くべきか？ 何を書かないべきか？
- ディレクトリ構成のベストプラクティスは？
- 配布形式はどうするか？（別repo / `template/` ディレクトリ / `npx create-llm-wiki` / 他）
- 既存の実装（Microsoft llmwiki、llm-wiki.app、各種CLIツール）との差別化は？
- Cosenseの設計原理をどう具体的なデフォルトに落とし込むか？
- `AGENTS.md`はどこまで薄くできるか？（このwiki自身の存続が最小スキーマの実証になる）

ingest時とfile-back時は、これらの問いに資する知見を優先し、`#template-design`タグを付ける。

## このWikiは研究の実験台です

- 本ファイルの規則はこのwikiを動かすための最小限の運用規則であり、テンプレート設計の主張ではない。
- テンプレートの設計主張はすべて `wiki/analyses/テンプレート草案*.md` の仮説ページにある。本ファイルは仮説を含まない。
- **バイアスは除去ではなく顕在化を狙う。** 運用と仮説の乖離に気づいたら `wiki/log.md` に記録し、該当する仮説ページのfrontmatter（status, evidence）を更新する。
- 疑問があれば常に `raw/` に戻って検証する。`wiki/`は派生物であり、`raw/`がソース・オブ・トゥルース。

## アーキテクチャ（運用規則）

```
raw/      — 不変。原文ドキュメント。LLMは読むだけで、絶対に変更しない。唯一の例外: 引用時アーカイブの新規追加と raw/manifest.md への追記。
wiki/     — LLMが管理する構造化Markdownページ（wikilink付き）。
AGENTS.md — 本ファイル。このwikiの運用規則。人間とLLMで共進化する。
```

`wiki/`の事実が争われたら `raw/` まで遡って検証する。

## ディレクトリ構成（運用規則）

```
wiki/
  concepts/   — 概念ページ
  entities/   — 実体ページ（人・組織・製品・場所・イベント）
  sources/    — ソース要約ページ。タイトル `YYYY-MM-DD 短い名前.md`。
  analyses/   — 分析・比較・総合ページ。長くなってよい。

  index.md    — 全ページのカタログ。各エントリ1行。Query時は最初に読む。
  log.md      — 追記専用のタイムライン。各エントリ: 見出し `## [DATE] action | 短い題名` + 詳細は本文。
  overview.md — エントリーポイント。このwikiの俯瞰図。
```

## オペレーション

### Ingest

1. `raw/` の新ファイルを読む。
2. `index.md` を読み、このWikiの目的に照らして既存ページとの接続点と未カバー領域を特定する。
3. 人間と3-5つの要点を議論する。何を重視するか聞く。
4. ページを作成・更新:
   - `sources/YYYY-MM-DD タイトル.md`（要約 + 関連concept/entityへのリンク）
   - 影響を受ける concepts/ と entities/ のページを更新（リンク追加、記述更新）
   - 既存の主張と矛盾する場合は明示する: 「⚠ Contradiction: [旧主張] vs [新ソース]」
   - 新規の概念・実体があれば概念ページを作成
5. `index.md` を更新（新ページ追加、変更された要約の更新）。
6. `log.md` に追記: 見出し `## [DATE] ingest | source-name` + 本文に `(touched N pages: M new + K existing updated + index/log)`

`raw/` のファイルは絶対に変更・削除しない。人間が明示的に依頼した場合のみ削除してよい。

### Query

1. まず `index.md` を読んで関連ページを探す。
2. 有望なページを読み、必要に応じてwikilinkを辿る。
3. `[[wikilink]]`引用付きで回答を総合する。
4. 回答後、「これをwikiページとしてfile-backする？」と提案する。
5. 承諾されたらページを作成（通常は analyses/ か concepts/）し、関連する既存ページへのwikilinkを張る。明らかに影響を受ける既存ページがあればリンク・記述を更新し、矛盾が生じたら明示する。index.md と log.md を更新する。

### Lint

「lintして」と言われたら `.agents/skills/llm-wiki-lint/SKILL.md` を読んで従う。
機械チェックは `bash .agents/skills/llm-wiki-lint/scripts/lint.sh`（決定的実行）。
疑問があれば自律的にlintを提案してよい。

### Review（研究の進行管理）

研究の進行状況をまとめ、次のアクションを提案する:

- 仮説ページのfrontmatter status遷移（hypothesis → tentatively-adopted → validated / falsified / extracted）を確認
- 研究課題のTODO状況（`analyses/このWikiの目的と研究課題.md`）を確認
- 研究の完了定義: **テンプレートがこのwikiから分離し、別のwikiがそれを運用し始めたとき**

## 執筆の機械要件

- sourcesページは必ず raw/ へのリンクを含める。引用の流れ: raw → sourceページ → concept/entity
- 出典はfrontmatterに書く: 全ページ任意 `sources:`（`raw/パス` または `[[wikilink]]`、空白を含むパスはダブルクォート）。sourcesページは `raw:` 必須（リスト・1以上）+ `source_url:` / `accessed:` 任意。`raw/`への参照は必ずパス形式で
- `index.md` の各エントリは1行。index.mdはページから導出可能なビューのキャッシュ: 陳腐化・欠損時はページ冒頭を読んで再生成してよい（lintが検証）
- frontmatterは任意だが、あれば有用（tags, dates, status等）
- **赤リンクは許容**: 意図的な前方参照（未作成ページへのリンク）は残してよい。1ページのみから参照されるリンクのためにページを作らない。2+ページから参照されるようになったら（lintのASPECT_HANDLE表示）ページ作成を検討する

## ファイル命名（このwikiの規則）

- `wiki/` 内: 人間の使用言語（日本語）による説明的な自然言語名。`kebab-case` や強制英語にはしない
- `sources/`: `YYYY-MM-DD 短い説明的な名前.md`
- `raw/`: 元のファイル名を保存。曖昧な場合は人間に相談（勝手にrenameしない）
- wikilink: `[[ページタイトル]]` — 大文字小文字は区別しない。ファイルパスの場合は拡張子なしのbasename

## Git規約

- Commit messageは [Conventional Commits](https://www.conventionalcommits.org/) 形式（英語）: `type(scope): summary`
  例: `docs(wiki): file back purpose and research questions page`
- 主なtype: `docs`（wikiページ、AGENTS.md）、`feat`、`fix`、`refactor`、`chore`、`test`
- commit messageを直す場合は `git commit --amend`（未push時）か後続のfix commitを使う
- summary行は命令形・72文字以内。文脈が必要なら本文（空行 + 箇条書き）を書く

## 対話ガイドライン

- **提案主義**: ページ作成・更新を提案し、人間の確認を得てから書く（ingestは「ingestして」自体が確認）。
- **file-back**: 実質的なQuery回答の後は、wikiページとして保存するか提案する。消えていく知識をデフォルトで保存する方向にする。
- **Grow first, split later**: ディレクトリ構成を先取り最適化しない。一領域が大きくなったら、分割（kabuwake）を人間に提案する。分割は移動ではなくコピー。

## よくあるパターン

- **「ingest this PDF」** → PDFを読み、要点を議論し、sources/ページを作成、concepts/entities/index/logを更新
- **「what do we know about X?」** → index.mdを読む → 関連ページ → 回答を総合 → file-backを提案
- **「lint the wiki」** → 機械 + 意味チェックを実行し、結果を報告
- **「what should I read next?」** → index.mdで薄いページ、ソースリンクのない孤立概念、未回答の疑問を確認
- **「ingest this URL」** → web検索/取得でコンテンツを得て、クリーンなMarkdown版を raw/ に保存し、通常のingestとして進める
