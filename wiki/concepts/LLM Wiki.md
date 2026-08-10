---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]", "[[2026-08-11 AIを使った知識マネジメント (villagepump)]]"
tags: [template-design, llm-wiki-pattern]
---

# LLM Wiki

LLMが永続的なMarkdown wikiを段階的に構築・保守するパターン。人間はソースのキュレーション・問い・方向付けを担い、LLMが要約・相互参照・ファイリング・帳簿管理をすべて行う。

Karpathyの定式化: 「Obsidian が IDE、LLM がプログラマ、wiki がコードベース」。つまり:
- 人間は wiki を直接書かない（または稀にしか書かない）
- LLMが会話に基づいて編集し、人間はリアルタイムで結果をブラウズする
- リンクを辿り、グラフビューを見て、更新されたページを読むのが人間の役割

nishioによる[[LLM Wikiの本質定義|本質定義]]: 「文脈情報をファイル化しindexで分割、AI自身がメンテナンスする仕組み」。これは[[LLM Wikiは要約の改良版ではない|要約の改良版ではない]]——情報を圧縮せず、[[注意の足場]]を作る。

nishioの20+ Wiki実践（[[LLM Wikiの実運用データ]]）では、[[Wikis-as-personas|各Wikiが仮想的人格として振る舞い]]、[[研究目的Wikiとプロジェクト目的Wiki|研究目的とプロジェクト目的で構造が分化]]し、育ったWikiから[[株分け（kabuwake）|株分け]]するライフサイクルが観察された。

## 関連概念

- [[永続Wikiと複利効果]] — RAGとの対比で「compounding artifact」を説明
- [[LLM Wikiは要約の改良版ではない]] — 情報を圧縮せず注意の足場を作る
- [[LLM Wikiの本質定義]] — nishioによる最も簡潔な定義
- [[3層アーキテクチャ]] — raw / wiki / Schema
- [[Ingest]] / [[QueryとFile-back]] / [[Lint]] — 3つの基本操作
- [[Obsidian as IDE]] — 具体的なツールチェーン
- [[Memex]] — Vannevar Bush の先駆的ビジョンとの接続
- [[LLM Wikiの応用領域]] — 個人・研究・読書・ビジネス等
- [[LLM Wikiの実運用データ]] — 25 Wiki/1647ページの定量データ
- [[事前にやろうとしない運用哲学]] — nishioの実運用から導かれた中核哲学
- [[Wikis-as-personas]] — 各Wikiが仮想的人格として振る舞う
- [[株分け（kabuwake）]] — 育ったWikiから別Wikiを派生
- [[LLM WikiテンプレートのOptionality]] — パターンと実装の分離
