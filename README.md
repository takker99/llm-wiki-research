# LLM Wiki Research

LLM Wikiテンプレートの研究・開発を目的とした**研究wiki**です。
KarpathyのLLM WikiパターンとCosense（Scrapbox）コミュニティの知見をingestし、
汎用で実用的なテンプレートを研究します。

## これは何か（ではない何か）

- これは**研究リポジトリ**であり、テンプレート本体ではありません。
- テンプレートは研究の**出力**であり、`template/` ディレクトリとしてこのrepoに実装されています。
- このrepo内の `AGENTS.md`・`wiki/` の構造は**仮説の実装**であり、検証対象です。
  テンプレート設計の主張は [wiki/analyses/テンプレート草案ver.1.md](wiki/analyses/テンプレート草案ver.1.md) にまとまっています。
- 研究の設計・研究課題の詳細は [wiki/analyses/このWikiの目的と研究課題.md](wiki/analyses/このWikiの目的と研究課題.md) を参照。

## Starter kitの使い方（template/）

`template/` はLLM Wikiを始めるためのstarter kit。中身を新規wikiのrootにコピーすれば、すぐに動き始められる。

### コピー手順

1. `template/` の中身をすべて新規ディレクトリにコピーする（`raw/`・`wiki/`・`.agents/` を含む）
2. `git init` する
3. `AGENTS.md` の「目的」に、そのwikiの目的を1文書く（**唯一の記入事項**。空欄のまま運用しない）

### 最初の30分

1. 目的を書く（上の手順3）
2. 最初のソース（読みたい記事・PDF・メモ等）を `raw/` に置く
3. 「このソースをingestして」とLLMに依頼する
4. LLMが `wiki/sources/` に要約ページを作り、`index.md`・`log.md` を更新する

### 設計思想（継承してほしいもの）

- **3層**: `raw/`（不変の原文）→ `wiki/`（LLMが管理するページ）→ `AGENTS.md`（運用規則）
- **raw/は不変**: wikiの事実が争われたらrawまで遡る
- **追記ではなく書き換え**: ページ更新は既存記述と統合して書き直す。既存の記述に手を加えず追記だけするのはwikiではない
- **conceptsはatomic**: 概念ページは簡潔に保ち、肥大化したら分割を提案する
- **indexカタログ**: `index.md` を最初に読む。検索基盤なしでスケールする
- **file-back習慣**: 回答・議論はデフォルトでwikiに保存する

### 改変は自由（これはstarter kit）

このtemplateは最初のお膳立て（立ち上げ品質の保証）を目的としている。
**設計思想さえ継承していれば、ディレクトリ構成・形式・手順・文言はあなたのプロジェクトに合わせて自由に改変してよい。**
- `entities/`・`analyses/`は任意（rename・削除可）
- skill（`.agents/skills/`）も不要なら削除してよい
- 気軽に試すこと

### 実証済みの経路

template v0.1は**個人・研究・読書・プロジェクト（開発）系**のwikiで実証されている。
複数人での利用・承認フロー・チーム運用（ビジネス/チーム系）は未実証。その場合も基本的な構造は動くが、運用の調整が必要になる。

## 研究課題（抜粋）

- 汎用テンプレートとして何を提供し、何をユーザー任せにするか
- 汎用 `AGENTS.md` には何を書くべきか。何を書かないべきか
- ディレクトリ構成のベストプラクティスは何か
- 配布形式はどうするか（`template/` ディレクトリ / 別repo / `npx create-llm-wiki` / 他）
- 既存実装（Microsoft llmwiki、llm-wiki.app、各種CLIツール）との差別化
- `AGENTS.md` はどこまで薄くできるか（このwiki自身が実験台）

## 現状

- **M1達成**: `template/` v0.1実装済み（2026-08-14）
- 次はM2: templateで外部wikiを立ち上げ・育て、このrepoが読んで評価する
- 研究wikiは120ページ（ingest/analysisともに多数の知見蓄積済み）

## ライセンス

MIT