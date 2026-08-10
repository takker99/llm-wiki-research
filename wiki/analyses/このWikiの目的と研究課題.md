# このWikiの目的と研究課題

このWikiは、**汎用のLLM Wikiテンプレート**を研究・開発するための実験台である。
ここでの知見は最終的に別途配布するテンプレート（repo / ディレクトリ / CLI — 形式未定）に凝縮される。
テンプレート設計の仮説は [[テンプレート草案ver.1]] に集約されており、
このWiki自身の運用がその検証実験になっている。

## 目的

1. **知識基盤を作る** — KarpathyのLLM Wikiパターン、nishioの実践知（20+ Wiki）、villagepumpコミュニティの議論をingestし、[[overview]]に記した通り知識ネットワークを育てる。
2. **テンプレート設計を検討する** — 以下の問いに答えを出す。
3. **最終成果物として汎用テンプレートを出力する** — 配布形式はこのWikiでの検討を通じて決定する。

## 中心となる研究課題

- [ ] 汎用テンプレートとして何を提供すべきか？ 何をユーザー任せにするか？
- [ ] 汎用`AGENTS.md`には何を書くべきか？ 何を書かないべきか？（→ [[テンプレート草案ver.1]]）
- [ ] ディレクトリ構成のベストプラクティスは？
  - 2026-08-11時点の考察: concepts/entitiesの境界はrawソース群（Karpathy gist・nishio・villagepump）のどこにも定義がない。villagepumpの表（`villagepump-AIを使った知識マネジメント.md` L253-259）は「簡潔さの強さ」のポリシーであって分類定義ではない。入リンク実測でもentityがハブ化する（Obsidian 9, qmd 7, Marp 6）が、最上位ハブは概念が独占。4分類は実質「sources / analyses / それ以外」の3分類＋ナビゲーション用タクソノミと言える。→ [[テンプレート草案ver.1]] claim#2のevidenceに追記
- [ ] 配布形式はどうするか？（別リポジトリ / `template/` ディレクトリ / GitHub Template Repository / `npx create-llm-wiki` / その他）
- [ ] 既存の実装（Microsoft llmwiki、llm-wiki.app、各種CLIツール）との差別化は？
  - 2026-08-11: [[OKF]]（Google、2026-06-12発表）を追加。OKFは成果物（format）層のみの標準化で操作（足場）層を標準化しない（nishioの考察1）——テンプレートは操作層（AGENTS.md）を提供する点で差別化可能。赤リンクはOKFが許容・本wikiがエラー扱いという設計分岐もある（[[Lint]]）。詳細は [[2026-08-11 OKFとLLM Wiki (nishio+villagepump)]]
- [ ] Cosenseの設計原理をどう具体的なデフォルトに落とし込むか？
  - 2026-08-11: OKF議論から「同一の赤リンクを共有するページ群を2-hop関連として提示する」Cosenseの仮想ページ挙動を、lintの改善（エラーと発見の分離）として輸入する余地（[[Lint]]）
- [ ] `AGENTS.md`はどこまで薄くできるか？ — **このwiki自身の存続が最小スキーマの実証になる**
- [ ] テンプレートは「人間が読む前提」の可読性設計（overview重視・辞書的消費への警鐘）か、read-optional設計か？ — [[理解のボトルネック]]（tsurubee）と[[読まれなくてよい中間産物]]（nishio）の対立。2026-08-11 ingestで顕在化。[[テンプレート草案ver.1]] claim#7の検証データ
- [ ] 情報信頼性（[[LLM Wikiの作文リスク]]）にテンプレートはどう対処すべきか？

## 現状

- `raw/` に実在するソースは9件（Karpathy gist + Cosense 8ページ: villagepump 2 + nishio 6）
- `AGENTS.md` は運用規則のみに縮小済み（2026-08-11）。テンプレート設計の主張はすべて
  [[テンプレート草案ver.1]] に仮説として移管
- 2026-08-11: Karpathy gist ingest（27ページ） + Cosense議論 ingest（26ページ）。合計50+ページ

## 関連

- [[overview]] — エントリーポイント
- [[index]] — ページカタログ
- [[テンプレート草案ver.1]] — テンプレート仮説（status: hypothesis）
- [[Cosenseソースのingest方式]] — Cosenseソースの取り込み方式の提案（研究課題「情報信頼性」「配布形式」へのインプット）
- [[rawディレクトリの取り扱い]] — raw/のgitignore・プライバシー・ライセンス・発見層の区別（open question）
- [[LLM Wikiの作文リスク]] — 情報信頼性の概念
