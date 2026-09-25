---
tags: [template-design, 下流wiki, M2]
---

# txa-xray-ct-wiki

作者の下流wikiの2件目。template v0.1 から instantiate された、ガラスビーズ供試体の三軸弾性波+X線CT同時計測実験のデータ・解析記録wiki。
M2 の検証対象であり、**出典運用フィードバックの元**。

## 基本情報

- 場所: `~/git/txa-xray-ct-wiki`
- 目的（AGENTS.md purpose）: ガラスビーズ供試体の三軸弾性波+X線CT同時計測実験（博論8.2節後続）のデータと解析を逐次記録し、骨格構造変化と弾性波速度変化の対応関係を実証する
- 構成: 3層（`raw/`・`wiki/`・`AGENTS.md`）+ `.agents/` に加え、app/・tests/・pyproject.toml を持つ**コードrepo一体型**（[[Wikiとコードリポジトリの関係]] の同一repo型）
- ドメイン: 実験・研究記録系。この研究wikiとは purpose が独立（= 検証オラクルとして成立）

## このwikiへの貢献（フィードバック）

- **2026-09-25**: 「conceptsページが出典（frontmatter `sources:`）を持たない」という不満が elastic-wave-analyzer-wiki の2026-09-03 observation と同型で再発 → 出典の正本を**本文中のsourcesページwikilink**と明文化、analyses の frontmatter `sources:` を reproducibility manifest と定義し直す。template AGENTS.md と lint に provenance 検査を追加
  - 記録: `wiki/log.md` 2026-09-25 エントリ「feedback | 下流wiki (txa-xray-ct-wiki) の出典運用の明文化を取り込み」
  - 正本の設計記録: 該当wikiの `wiki/analyses/出典運用の設計判断.md`

## 関連

- [[elastic-wave-analyzer-wiki]] — 下流wiki 1件目
- [[このWikiの目的と研究課題]] — 目的の再定義（設計対象・検証オラクル）
- [[配布形式の決定とテンプレートの動機]] — M2の定義と検証方針
- [[LLM Wikiの作文リスク]] — 出典・信頼性への対処の文脈
