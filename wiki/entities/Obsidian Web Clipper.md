---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
---

# Obsidian Web Clipper

[[Obsidian]]のブラウザ拡張。Web記事をMarkdownに変換し、Obsidianのvault（LLM Wikiでは`raw/`）に保存する。

## LLM Wikiでの役割

- ソース収集の主要ツール。手動コピペなしでWebコンテンツをraw/に取り込める。
- 画像をローカルにダウンロードする設定と組み合わせると、URL切れの心配なくLLMが参照できる。

## 設定Tips（Karpathy）

- Obsidian設定 → Files and links → "Attachment folder path" を `raw/assets/` に
- ホットキー設定 → "Download attachments for current file" にショートカット（Ctrl+Shift+D等）を割り当て
- 注意: LLMはインライン画像付きMarkdownを一度に読めないため、テキストを先に読み、必要に応じて画像を個別参照するワークアラウンドが必要

## 関連概念

- [[Obsidian as IDE]] — ツールチェーン全体
- [[Obsidian]] — ホストアプリケーション
