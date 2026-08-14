# AGENTS.md

このファイルはこのwikiの運用規則。人間とLLMで共進化する。
設計思想（3層・raw/不変・indexカタログ・file-back習慣）を継承していれば、
このファイルを含むすべての構成・形式・手順は**自由に改変してよい**。

## 目的（purpose）

**【ここにこのwikiの目的を1文で書く。唯一の記入事項。】**

迷ったときはこの1文に立ち返る。空欄のまま運用しないこと。

## アーキテクチャ

```
raw/      — 不変。原文ドキュメント。LLMは読むだけで、絶対に変更しない。唯一の例外: 引用時アーカイブの新規追加
wiki/     — LLMが管理する構造化Markdownページ（wikilink付き）
AGENTS.md — 本ファイル。このwikiの運用規則
```

`wiki/`の事実が争われたら `raw/` まで遡って検証する。

## ディレクトリ構成

```
wiki/
  concepts/   — 概念ページ（必須）
  entities/   — 実体ページ（人・組織・製品・場所・イベント）（任意。rename・削除可）
  sources/    — ソース要約ページ（必須）。タイトル `YYYY-MM-DD 短い名前.md`
  analyses/   — 分析・比較・総合ページ。長くなってよい（任意。rename・削除可）

  index.md    — 全ページのカタログ。各エントリ1行。Query時は最初に読む
  log.md      — 追記専用のタイムライン
  overview.md — エントリーポイント。このwikiの俯瞰図
```

`concepts/`と`sources/`は必須。`entities/`・`analyses/`は必要になってから使う。
このwikiに合わなければrename・削除してよい。

## ファイル命名

- `wiki/` 内: 人間の使用言語による説明的な自然言語名。強制英語やkebab-caseにしない
- `sources/`: `YYYY-MM-DD 短い説明的な名前.md`
- `raw/`: 元のファイル名を保存。曖昧な場合は人間に相談（勝手にrenameしない）
- wikilink: `[[ページタイトル]]` — 大文字小文字は区別しない。ファイルパスの場合は拡張子なしのbasename

## 執筆の機械要件

- sourcesページは必ず `raw/` へのリンクを含める。引用の流れ: raw → sourceページ → concept/entity
- sourcesページのfrontmatter（`raw:` 必須 等）の形式は `.agents/skills/llm-wiki-ingest/SKILL.md` に定義
- `index.md` の各エントリは1行: `- [ページタイトル](パス) — 1行要約`
- `log.md` の各エントリ: 見出し `## [YYYY-MM-DD] action | 短い題名` + 詳細は本文
- 赤リンク（未作成ページへのリンク）は許容: 1ページのみから参照されるリンクのためにページを作らない。2ページ以上から参照されるようになったらページ作成を検討

## 初期化（初回のみ）

1. 人間がpurposeを確認・確定する（空欄のままなら運用しない）
2. 最初のingestの種（ソース）は人間が持ってくる
3. 「このソースをingestして」と依頼されたら `.agents/skills/llm-wiki-ingest/SKILL.md` を読んで従う

## オペレーション

### Ingest

「ingestして」と言われたら `.agents/skills/llm-wiki-ingest/SKILL.md` を読んで従う。

### Query（常時行動）

1. まず `index.md` を読んで関連ページを探す
2. 有望なページを読み、必要に応じてwikilinkを辿る
3. `[[wikilink]]`引用付きで回答を総合する
4. 回答後、「これをwikiページとしてfile-backする？」と提案する

### Lint

「lintして」と言われたら `.agents/skills/llm-wiki-lint/SKILL.md` を読んで従う。
疑問があれば自律的にlintを提案してよい。

### File-back（常時行動）

実質的なQuery回答の後や、作業（実装・議論・調査）中に生まれた知見の後は、
wikiページとして保存するか提案する。消えていく知識をデフォルトで保存する方向にする。

## よくあるパターン

- 「このPDF/URLをingestして」 → ソースを `raw/` にアーカイブ（人間が依頼した場合のみ）し、ingest手順に従う。要点を議論し、sources/ページを作成、concepts/entities/index/logを更新
- 「Xについて知ってる？」 → index.mdを読む → 関連ページ → 回答を総合 → file-backを提案
- 「wikiをlintして」 → lint手順に従い、機械+意味チェックを実行し、重大度別に報告
- 「次に何を読むべき？」 → index.mdで薄いページ、出典のない孤立概念、未回答の疑問を確認
