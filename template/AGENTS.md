# AGENTS.md

このファイルはこのwikiの運用規則。人間とLLMで共進化する。
設計思想（3層・raw/不変・追記ではなく書き換える・conceptsはatomic・frontmatter summary正本・file-back習慣）を継承していれば、
このファイルを含むすべての構成・形式・手順は**自由に改変してよい**。

## 目的（purpose）

**【ここにこのwikiの目的を1文で書く。唯一の記入事項。】**

迷ったときはこの1文に立ち返る。空欄のまま運用しないこと。
初回は人間がpurposeを確定し、最初のソースを持ち込んでからingestを始める。

## アーキテクチャ

```
raw/      — 不変。原文ドキュメント。LLMは変更・削除しない。唯一の例外: ingest時または人間の依頼による新規ソース追加
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

  log.md      — 追記専用のタイムライン
```

`concepts/`と`sources/`は必須。`entities/`・`analyses/`は必要になってから使う。
このwikiに合わなければrename・削除してよい。

## ファイル命名

- `wiki/` 内: 人間の使用言語による説明的な自然言語名。強制英語やkebab-caseにしない
- `sources/`: `YYYY-MM-DD 短い説明的な名前.md`
- `raw/`: 元のファイル名を保存。曖昧な場合は人間に相談（勝手にrenameしない）
- wikilink: `[[ページタイトル]]` — ディレクトリを問わず拡張子なしのbasenameで解決。大文字小文字は区別しない

## 執筆の機械要件

- sourcesページは情報源へのポインタ（frontmatter の `raw:` または `source_url:` の1つ以上。形式は `.agents/skills/llm-wiki-write/SKILL.md`）を必ず含める。引用の流れ: 情報源 → sourceページ → concept/entity/analysis
- frontmatter: 各ページに `summary`（1行・1〜2文。検索と`--catalog`カタログに使われる要約の正本。本文を書き換えたら同じ編集で見直す）を付ける。`tags:` / `dates:` / `status:` / `sources:` 等のメタ情報は必要に応じて付加してよい。idはファイル名（basename）が兼ねる
- concepts/entities/analyses の出典は本文中に sources ページへの [[wikilink]] を置く (claim粒度)
- 外部URLを出典にする場合は frontmatter の `source_url:`（と任意で `accessed:`）を使う。
- 外部文献の内容を主張の根拠にする前に、原典に相当する sources ページを作る
- `log.md` の各エントリ: 見出し `## [YYYY-MM-DD] action | 短い題名` + 詳細は本文
- オープンリンク（未作成ページへのリンク）は許容: 1ページのみから参照されるリンクのためにページを作らない。2ページ以上から参照されるようになったらページ作成を検討
- wiki/のページは追記ではなく**書き換え**で更新する。既存の記述に手を加えず追記だけするのはwikiではない。raw/がsource of truthなので書き換え・削除は自由
- concepts/はatomicに保つ: 1ページ1概念・簡潔に。育って肥大化したら分割（株分け）を人間に提案する
- ページタイプ別の簡潔さの目安: concepts/ 強く簡潔（atomic）・entities/ 簡潔・sources/ 中程度・analyses/ 長め可

## オペレーション

### Ingest

「ingestして」と言われたら `.agents/skills/llm-wiki-write/SKILL.md` を読んで従う。

### Query（常時行動）

1. `bash .agents/scripts/search-pages.sh "<検索語>"`で関連ページや未作成リンクを探す。既定検索はタイトル・要約に加えて本文全文の抜粋も返し、0件時は全文検索へ自動で切り替わる。本文を広く見たい時は`--fulltext`を使う。全体像が必要な時は`bash .agents/scripts/search-pages.sh --catalog`で全ページの要約付きカタログを出力する
2. 有望なページや複数ページから参照される未作成リンクは、必ず`bash .agents/scripts/read-page.sh "<タイトル>"`で読む。1 hop・2 hopの関連ページ一覧はread-page.shが末尾に付けるもので、`read`で直接読むと得られない。末尾の関連一覧と要約から深掘り先を選んで辿る。巨大な2 hopは`--no-2hop` / `--2hop-limit <N>` で絞ってよい。再読や長大ページの部分読みでは直接`read`してよい
3. `[[wikilink]]`引用付きで回答を総合する
4. 回答後、「これをwikiページとしてfile-backする？」と提案する
5. 「次に何を読むべき？」と聞かれたら、`--catalog`とlintの結果で薄いページ、出典のない孤立概念、未回答の疑問を確認する

### Lint

「lintして」と言われたら `.agents/skills/llm-wiki-lint/SKILL.md` を読んで従う。
疑問があれば自律的にlintを提案してよい。

### File-back（常時行動）

実質的なQuery回答の後や、作業（実装・議論・調査）中に生まれた知見の後は、
wikiページとして保存するか提案する。消えていく知識をデフォルトで保存する方向にする。

承諾されたら `.agents/skills/llm-wiki-write/SKILL.md` を読んで従う。
