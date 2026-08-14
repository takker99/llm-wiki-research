---
sources: "[[2026-08-11 Karpathy LLM Wiki Gist]]", "[[2026-08-11 AIを使った知識マネジメント (villagepump)]]", "[[2026-08-14 SKILL併用LLM Wiki vanillaflava (github)]]"
tags: [template-design, llm-wiki-pattern]
---

# overviewの役割

wiki最上位に置かれる入口ページ。このwikiが何のためにあるか（目的）・スコープ（研究課題）・現状・次のステップを1ページで俯瞰する。

## 位置づけ: 人間向けの入口ページ

| ファイル | 主な読者 | 役割 |
|---|---|---|
| index.md | LLM | 全ページのカタログ。Query時最初に読む |
| log.md | LLM | 追記専用の時系列記録 |
| **overview.md** | **人間** | 目的・スコープ・現状・次のステップの俯瞰。入門の1枚 |

LLMのQueryフローでは必須ではない（index.mdで足りる）。人間が「このwikiは何か・どこに向かっているか」を知るための入り口であり、新しいLLMセッションに初期文脈として渡すこともできる。[[IndexとLog]]の対で「3つ目の特殊ファイル」として位置づけられる。

## 原型には存在しない

Karpathyのgistが定義する特殊ファイルはindex.mdとlog.mdのみ（`raw/karpathy-llm-wiki-gist.md`）。raw/の全ソースを調べてもoverviewというファイルは登場しない。本wikiでは初期コミット（760517a）で人間がスキャフォールドに置いた独自発明であり、`template/`の骨格に引き継がれて配布される。

## 機能の元ネタ

- nishioの実測「家族が読める1枚（overview）＝全体の12.6%」（`raw/nishio-LLM_Wikiは要約の改良版ではない.md`）— [[注意の足場]]の入口ページ概念
- vanillaflavaのwiki-configがHome/Overviewを生成（[[2026-08-14 SKILL併用LLM Wiki vanillaflava (github)]]）

名前は違えど「入門の1枚」は実装で自然発生する。

## 設計上の論点

- **人間可読設計 vs read-optional**: overviewの重視は「人間が読む前提」の可読性設計の代表例で、[[理解のボトルネック]]の未解決課題（read-optional vs 可読性設計、[[テンプレート草案ver.1]] claim#7関連）の論点の一つ。本wiki自身が実験データ点
- **目的ページとの重複**: [[このWikiの目的と研究課題]]と内容が重複している。テンプレート的にはoverviewを入れない選択肢（人間向けは配布側READMEで足りる）もある
- **ソース一覧を書く罠**: overviewにソース一覧を書くと陳腐化し、[[LLM Wikiの作文リスク]]の温床になる。実例: 2026-08-11時点でoverviewが7件のraw/ソースを列挙していたが実在は1件のみ（[[LLM Wikiの作文リスク]]）

## 関連概念

- [[IndexとLog]] — 対になる2つの特殊ファイル
- [[注意の足場]] — overviewが担う入口ページ機能の理論
- [[理解のボトルネック]] — overview重視 vs read-optionalの対立
- [[LLM Wikiの作文リスク]] — ソース一覧陳腐化の実例