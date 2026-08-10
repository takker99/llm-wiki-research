---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]]
---

# RAG

Retrieval-Augmented Generation。LLMがクエリ時に外部ドキュメントから関連チャンクを検索し、回答を生成する手法。[[NotebookLM]]、ChatGPT file uploads、その他多くのRAGシステムがこの方式。

## LLM Wikiとの対比（Karpathy）

| RAG | LLM Wiki（永続Wiki） |
|---|---|
| クエリ時に知識を再発見 | 知識を事前にコンパイルし最新に保つ |
| 毎回チャンクを検索・結合 | クロスリファレンスはすでに存在 |
| 合成には毎回断片を寄せ集める | 合成知見はすでにwiki上にある |
| 何も積み上がらない | ソース追加・質問のたびに豊かになる |

Karpathy: "Nothing is built up."

## LLM Wikiとの併用

Karpathy gistでは両者は排他的ではない。LLM Wikiのindexベースナビゲーションが限界を迎えた後は、[[qmd]]のような検索（BM25+ベクトル+LLMリランキング）を追加することでRAG的アプローチを補完的に導入できる。ただし基本戦略は「事前コンパイル」であり、RAGはあくまで検索補助。

## 関連概念

- [[永続Wikiと複利効果]] — 対比の詳細
- [[LLM Wikiのスケーラビリティ]] — どこでRAG的補完が必要になるか
- [[qmd]] — LLM Wikiのスケールアップ時の検索ソリューション
