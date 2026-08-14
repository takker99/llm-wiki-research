---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]", "[[リポジトリ分析 microsoft-llmwiki]]"
tags: [template-design, llm-wiki-pattern]
---

# QueryとFile-back

LLM Wikiの3基本操作の1つ。wikiに対して質問し、回答を得るプロセス。回答をwikiページとして保存する[[File-back]]パターンを含む。

## Queryフロー（Karpathy）

1. LLMが関連ページを検索
2. 有望なページを読み、wikilinkを辿る
3. 引用付きで回答を総合する

回答の形態は質問によって変わる: Markdownページ、比較表、スライドデッキ（[[Marp]]）、チャート（matplotlib）、キャンバスなど。

## File-back

Karpathyの重要な洞察: **良い回答はwikiページとして保存されるべき。** 比較、分析、発見したつながり——これらは価値があり、チャット履歴に消えるべきではない。これにより、探索自体が知識ベースに蓄積される（ingestと同様の複利効果）。

保存先は通常 `analyses/` または `concepts/`。

nishioの実践ではfile-backの3パターンがある:
1. 人間が「file backしといて」と指示
2. AI側から「file backしましょうか？」と提案
3. 人間が「このログにfile backすべき知見はある？」と聞く

## スコープ閉鎖性（tsurubeeの実践）

tsurubeeの観察: LLM Wikiへのqueryは**自分がingestしたソースセットだけ**を根拠に答える。汎用LLMの「世の中の研究一般」を題材にした浅く広い回答と違い、自分のキュレーションにスコープが閉じることで「狭いぶん深く、自分の問題意識に密着した」回答になる。回答は`wiki/queries/`に残り、次のqueryやingestが参照できる（チャット履歴に消えていた合成結果の資産化）。

これはRAG批判（[[RAG]]）とは別軸の利点: 知識の累積（[[永続Wikiと複利効果]]）に加えて、**知識の範囲の限定**が回答の質に効く。

## 読まれなくてよい中間産物

Query回答やWikiページは[[読まれなくてよい中間産物|読まれなくてよい]]。読む主体が人間からLLMに移り、Queryが代わりに読む。要約は読まれるために作るが、LLM Wikiはqueryされるために作る。

## 検索の実装例とfile-backの制度化（Microsoft llmwiki）

[[Microsoft llmwiki]] はqueryを**weighted全文検索**（indexエントリの title 3x / summary 2x、本文 1x）として実装。
「index.mdが個人規模で十分機能する」の実装版で、規模超過時はローカル検索ツールを足すupgrade pathを明言
（[[IndexとLog]]、[[LLM Wikiのスケーラビリティ]]）。

file-backはコマンド化・ページ種別化されている: `@wiki /save` チャットコマンド + `queries/` ディレクトリ +
`type: query` ページ（original query・results_countをfrontmatterに保持）。
→ file-backを「追加運用」でなく組み込み操作として設計する実例。[[操作層]]、[[リポジトリ分析 microsoft-llmwiki]]

## 当wikiでの実装

AGENTS.mdのQueryフロー:
1. `index.md` を読んで関連ページを探す
2. 有望なページを読み、wikilinkを辿る
3. `[[wikilink]]`引用付きで回答
4. 回答後「これをwikiページとしてfile-backする？」と提案
5. 承諾されたら analyses/ か concepts/ に作成、index/logを更新

## 関連操作

- [[Ingest]] — ソースからの知識流入
- [[Lint]] — 健全性チェック
- [[IndexとLog]] — Query時のナビゲーション基盤
- [[読まれなくてよい中間産物]] — read-optionalの理論的根拠
- [[複数のLLM Wikiに共通のインプット]] — 複数Wikiへの並列Query
- [[繋げる力]] — query結果がwikiに残ることで生まれる横断的価値
