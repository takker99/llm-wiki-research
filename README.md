# LLM Wiki Research

LLM Wikiテンプレートの研究・開発を目的とした**研究wiki**です。
KarpathyのLLM WikiパターンとCosense（Scrapbox）コミュニティの知見をingestし、
汎用で実用的なテンプレートを研究します。

## これは何か（ではない何か）

- これは**研究リポジトリ**であり、テンプレート本体ではありません。
- テンプレートは研究の**出力**であり、研究の結論として別途公開されます（配布形式も研究課題）。
- このrepo内の `AGENTS.md`・`wiki/` の構造は**仮説の実装**であり、検証対象です。
  テンプレート設計の主張は [wiki/analyses/テンプレート草案ver.1.md](wiki/analyses/テンプレート草案ver.1.md) にまとまっています。
- 研究の設計・研究課題の詳細は [wiki/analyses/このWikiの目的と研究課題.md](wiki/analyses/このWikiの目的と研究課題.md) を参照。

## 研究課題（抜粋）

- 汎用テンプレートとして何を提供し、何をユーザー任せにするか
- 汎用 `AGENTS.md` には何を書くべきか。何を書かないべきか
- ディレクトリ構成のベストプラクティスは何か
- 配布形式はどうするか（別repo / `template/` ディレクトリ / `npx create-llm-wiki` / 他）
- 既存実装（Microsoft llmwiki、llm-wiki.app、各種CLIツール）との差別化
- `AGENTS.md` はどこまで薄くできるか（このwiki自身が実験台）

## 現状

- `raw/` には `karpathy-llm-wiki-gist.md` 1件（nishio/villagepumpのソースは誤削除のため再取得予定）
- `AGENTS.md` は運用規則のみに縮小済み。テンプレート草案は `wiki/analyses/` に仮説として移管
- `wiki/` のingestはこれから

## ライセンス

MIT
