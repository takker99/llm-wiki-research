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
- nishio | OKFとLLM Wiki | https://scrapbox.io/nishio/OKFとLLM_Wiki | 2026-08-11 | sha256:8448ca68809bf08ea872984d2eb47233545ece32cad42ed2b5c01f6cd6a5a993 | raw/cosense/nishio/OKFとLLM Wiki-2026-08-11.md
- nishio | 一貫・網羅・頂点 | https://scrapbox.io/nishio/一貫・網羅・頂点 | 2026-08-11 | sha256:c60dcb0ee867959d5b06be0ca160851b6b9c9027181fa00a36efcf3ec4e37a77 | raw/cosense/nishio/一貫・網羅・頂点-2026-08-11.md
- villagepump | 2026/06/13（日記） | https://scrapbox.io/villagepump/2026/06/13 | 2026-08-11 | sha256:72bcf8386680d86cb5f977a9ae18d62555e10be1e870ba5095349f6fcad77a28 | raw/cosense/villagepump/2026-06-13-2026-08-11.md
- gist (stakiran) | OKFとMetadata as Codeをめぐる考察 | https://gist.github.com/stakiran/be335dc48f8b55538063871005382fa1 | 2026-08-11 | sha256:e60ded0c4a0887369cc1cb94154019e7ef39e16a80e3ca376b2ce11f15fa1132 | raw/cosense/villagepump/stakiran-OKFとMetadata_as_Code-2026-08-11.md

## GitHub repos（発見層）

分析対象のLLM Wikiリポジトリ。cloneは `~/git/llm-wiki-samples/`（発見層）にあり、raw/にはコピーしていない。
形式: `- <owner/repo> | <clone_date> | <commit_hash> | <license> | <description> | <local_path>`

- nishio/llm-wiki-about-nishio | 2026-08-12 | e6117d05432667968bd12947e059f36dfa8b75a8 | None | 個人成熟型LLM Wiki。自己紹介ページ更新が第一目的 | ~/git/llm-wiki-samples/llm-wiki-about-nishio
- nishio/grasp | 2026-08-12 | a7ff7d339a610db02d7d5ee9651bbe9b89092ea3 | MIT | Code+Wikiハイブリッド。Cosenseデータ処理CLI + LLM Wiki | ~/git/llm-wiki-samples/grasp
- takker99/AMME-2026S-report | 2026-08-12 | d3f10b83d9da1e24dd733e7aea88a2d0e1d237e1 | (private) | 研究レポートLLM Wiki。最薄AGENTS.md (1.9KB) | ~/git/AMME-2026S-report
- takker99/BDL-2026S | 2026-08-12 | 42826ad5c20762ba27e1090269d91a945e2ec879 | (private) | 講義用LLM Wiki。330p/62K行の最大規模 | ~/git/BDL-2026S
- nishio/llm-wiki-about-delite | 2026-08-12 | 4181dd42ff78d72a5e5a05512a59dc37d7ef97a2 | None | CLAUDE.mdのみ。43時間で停止。Quartz公開 | ~/git/llm-wiki-samples/llm-wiki-about-delite
