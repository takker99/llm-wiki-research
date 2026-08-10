# raw manifest

`raw/` は gitignore 対象（git管理外）のため、アーカイブの一覧をここに記録する。
このファイルのみgitにコミットされる（`.gitignore` の `!raw/manifest.md`）。

## 記録規則（[[Cosenseソースのingest方式]] 仮採用セットより）

- **追記のみ**。既存エントリは変更・削除しない（`raw/` 不変原則の例外の範囲内）
- エントリ形式: `- <project> | <title> | <URL> | <YYYY-MM-DD> | sha256:<hash> | <path>`
- ハッシュは `sha256sum` で取得。ページの同一性判定に使う
- URL+タイトルはgit logに残るため、非公開にしたい出典は載せない

## エントリ

- zenn | Andrej Karpathy氏のLLM Wikiを1ヶ月運用してわかった、LLMの知識を『繋げる力』 | https://zenn.dev/tsurubee/articles/llm-wiki-connecting-knowledge | 2026-05-15 | sha256:77c34e700b23a261bdc6747d2557c4c2306005d73d452b1fae9e6bd0f495ae77 | raw/zenn-tsurubee-KarpathyのLLM_Wikiを1ヶ月運用してわかった繋げる力.md
