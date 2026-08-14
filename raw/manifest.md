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
- nishio | kouchou-ai-developer-wiki | https://scrapbox.io/nishio/kouchou-ai-developer-wiki | 2026-08-14 | sha256:28c2b56d273654dffe5734b048a6f2efca418028b4400b30130b6ac846a0607a | raw/cosense/nishio/kouchou-ai-developer-wiki-2026-08-14.md
- nishio | AIによる赤リンクの延伸 | https://scrapbox.io/nishio/AIによる赤リンクの延伸 | 2026-08-14 | sha256:839486feb9ec480ec2a8fafdf3fd8562d7338fad17ac11afaaff5bf9ed103c77 | raw/cosense/nishio/AIによる赤リンクの延伸-2026-08-14.md
- nishio | Open Questionと赤リンクの延伸 | https://scrapbox.io/nishio/Open_Questionと赤リンクの延伸 | 2026-08-14 | sha256:87611721c02e37b8afa8a51f607223a02dcfe6fa3396187966202c917136d188 | "raw/cosense/nishio/Open Questionと赤リンクの延伸-2026-08-14.md"
- nishio | 予測のリンクと不測のリンク不足 | https://scrapbox.io/nishio/予測のリンクと不測のリンク不足 | 2026-08-14 | sha256:8f24d9b168da690f365aeea55f8acfebf80ea516a59fa70784b45a8023c8a973 | raw/cosense/nishio/予測のリンクと不測のリンク不足-2026-08-14.md
- nishio | リンクは弱い情報 | https://scrapbox.io/nishio/リンクは弱い情報 | 2026-08-14 | sha256:3e4eb4cdd848a128fc14432659e3f4f8e48a8d3c216203d267918533a68adace | raw/cosense/nishio/リンクは弱い情報-2026-08-14.md
- nishio | 多すぎるリンク | https://scrapbox.io/nishio/多すぎるリンク | 2026-08-14 | sha256:845d2b46cbbbfea34e2cf3d699ece2ce1d2693c5d5e5850f81171fcbca256db2 | raw/cosense/nishio/多すぎるリンク-2026-08-14.md
- nishio | 公開PKMが読者ケアのせいでover-linkを産む | https://scrapbox.io/nishio/公開PKMが読者ケアのせいでover-linkを産む | 2026-08-14 | sha256:758ac56e74801cc8e983e8121ff63fb5998fd831da3278e9bc39dc6f8fcf3bfd | raw/cosense/nishio/公開PKMが読者ケアのせいでover-linkを産む-2026-08-14.md
- nishio | howmのcome-fromリンク | https://scrapbox.io/nishio/howmのcome-fromリンク | 2026-08-14 | sha256:af0f0d8267abc7792d29593febc6ca5724ebb2381d26fd17465506ee9ea763d5 | raw/cosense/nishio/howmのcome-fromリンク-2026-08-14.md
- nishio | 赤リンク | https://scrapbox.io/nishio/赤リンク | 2026-08-14 | sha256:96413b72deefb1463b8ea80035d1e13869fa01b7c0c5a0fd70840392582bafbf | raw/cosense/nishio/赤リンク-2026-08-14.md
- villagepump | 2 hop link | https://scrapbox.io/villagepump/2_hop_link | 2026-08-14 | sha256:c4b98bdaeff909b8a33307c0ebab8b0e4855c6b177e062535fe14781c76af7da | "raw/cosense/villagepump/2 hop link-2026-08-14.md"
- villagepump | 大きなリンク | https://scrapbox.io/villagepump/大きなリンク | 2026-08-14 | sha256:1a776f32eb177ead449ab0a03a45fe3a9e5d297b796891024e4123e8c2502e56 | raw/cosense/villagepump/大きなリンク-2026-08-14.md
- villagepump | 2 hop linkを使っていますか？ | https://scrapbox.io/villagepump/2_hop_linkを使っていますか？ | 2026-08-14 | sha256:89688d0591de225bf0828384d042d4335efab57d3eea5c2a020494121323e4e9 | "raw/cosense/villagepump/2 hop linkを使っていますか？-2026-08-14.md"
- villagepump | 光る言葉リンク問題（赤リンクの利点） | https://scrapbox.io/villagepump/光る言葉リンク問題（赤リンクの利点） | 2026-08-14 | sha256:fa416c6c6b067a437cc5644537e7b33302c3fe3c826a97d1351d3098ddde4bea | raw/cosense/villagepump/光る言葉リンク問題（赤リンクの利点）-2026-08-14.md
- villagepump | 関連ページリスト | https://scrapbox.io/villagepump/関連ページリスト | 2026-08-14 | sha256:62ea7e9fed881c25686667e0a4b2ec52bc74a320c5f7f0d9672d2888949f752b | raw/cosense/villagepump/関連ページリスト-2026-08-14.md
- villagepump | 赤リンクの数の議論のLLM Wiki | https://scrapbox.io/villagepump/赤リンクの数の議論のLLM_Wiki | 2026-08-14 | sha256:75b7a9e3237c46154956af4062e70c7fcb272da338aa7f65c552fd6a2aa49e96 | "raw/cosense/villagepump/赤リンクの数の議論のLLM Wiki-2026-08-14.md"

## GitHub repos（発見層）

分析対象のLLM Wikiリポジトリ。cloneは `~/git/llm-wiki-samples/`（発見層）にあり、raw/にはコピーしていない。
形式: `- <owner/repo> | <clone_date> | <commit_hash> | <license> | <description> | <local_path>`

- nishio/llm-wiki-about-nishio | 2026-08-12 | e6117d05432667968bd12947e059f36dfa8b75a8 | None | 個人成熟型LLM Wiki。自己紹介ページ更新が第一目的 | ~/git/llm-wiki-samples/llm-wiki-about-nishio
- nishio/grasp | 2026-08-12 | a7ff7d339a610db02d7d5ee9651bbe9b89092ea3 | MIT | Code+Wikiハイブリッド。Cosenseデータ処理CLI + LLM Wiki | ~/git/llm-wiki-samples/grasp
- takker99/AMME-2026S-report | 2026-08-12 | d3f10b83d9da1e24dd733e7aea88a2d0e1d237e1 | (private) | 研究レポートLLM Wiki。最薄AGENTS.md (1.9KB) | ~/git/AMME-2026S-report
- takker99/BDL-2026S | 2026-08-12 | 42826ad5c20762ba27e1090269d91a945e2ec879 | (private) | 講義用LLM Wiki。330p/62K行の最大規模 | ~/git/BDL-2026S
- nishio/llm-wiki-about-delite | 2026-08-12 | 4181dd42ff78d72a5e5a05512a59dc37d7ef97a2 | None | CLAUDE.mdのみ。43時間で停止。Quartz公開 | ~/git/llm-wiki-samples/llm-wiki-about-delite
