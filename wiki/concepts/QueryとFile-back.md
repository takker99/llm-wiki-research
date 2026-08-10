---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]"
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

## 読まれなくてよい中間産物

Query回答やWikiページは[[読まれなくてよい中間産物|読まれなくてよい]]。読む主体が人間からLLMに移り、Queryが代わりに読む。要約は読まれるために作るが、LLM Wikiはqueryされるために作る。

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
