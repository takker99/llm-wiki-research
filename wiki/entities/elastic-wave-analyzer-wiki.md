---
tags: [template-design, 下流wiki, M2]
---

# elastic-wave-analyzer-wiki

作者の下流wikiの1件目。template v0.1 から instantiate された、弾性波解析アプリ elastic-wave-analyzer の使い込み用wiki。
M2（templateでこの研究wiki以外のwikiを立ち上げ育て、このrepoが評価）の検証対象であり、**最初のフィードバック元**。

## 基本情報

- 場所: `~/git/elastic-wave-analyzer-wiki`
- 目的: 三軸試験中に計測した弾性波（特にせん断波）の理解・解析を通じて、elastic-wave-analyzer を使いこなせるようになる（`wiki/overview.md` に記載）
- **⚠ purpose-hoist未運用のデータ点**: 2026-09-25時点で AGENTS.md の目的欄はテンプレートのプレースホルダ（「【ここにこのwikiの目的を1文で書く。唯一の記入事項。】」）のまま。目的は overview 側にのみ存在する。「空欄のまま運用しない」指示が守られていない実例
- 構成: 3層（`raw/`・`wiki/`・`AGENTS.md`）+ concepts/entities/sources/analyses。template準拠（frontmatter は sources のみ、など）
- ドメイン: 技術・解析系。この研究wikiとは purpose が独立（= 検証オラクルとして成立）

## このwikiへの貢献（フィードバック）

- **2026-09-03**: instantiate直後の確認で frontmatter が sources のみ（concepts 17・entities 2・analyses 1・index/overview/log 全て無し）と判明 →「書いても書かなくてもよい」を1行で宣言する教訓に落地し、template AGENTS.md に frontmatter 任意の宣言を追加
  - 記録: `wiki/log.md` 2026-09-03 エントリ「observation | template instantiateのfrontmatter沈黙」

## 関連

- [[txa-xray-ct-wiki]] — 下流wiki 2件目
- [[このWikiの目的と研究課題]] — 目的の再定義（設計対象・検証オラクル）
- [[配布形式の決定とテンプレートの動機]] — M2の定義と検証方針
- [[目的明示（purpose-hoist）]] — 上記の purpose 未記入が指摘する運用課題
