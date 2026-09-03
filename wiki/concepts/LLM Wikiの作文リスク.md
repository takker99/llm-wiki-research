# LLM Wikiの作文リスク

LLMが「存在しないソースや事実をもっともらしく作文（捏造）してしまう」リスク。
LLM Wikiでは `wiki/` は派生物であり、ソース一覧を書いたページ（[[index]]、[[overview]]）が
あっても、そのソースが実在するとは限らない。リストの作文は特に起きやすい。

## 観察記録（このwikiでの実例）

- 2026-08-11: [[overview]]が7件のraw/ソースを列挙していたが、実在したのは1件のみ。
- 原因はユーザーによる誤削除（nishio 4件、villagepump 2件）で、**LLMの作文ではない**。
- ただし、`raw/`と照合するまで「虚偽の一覧」であることを**人間もLLMも検出できなかった**。
  つまり実在確認なしに流通したソース一覧は、原因が何であれ同じリスクを帯びる。
- さらに、`raw/`は`.gitignore`対象（`raw/*`）のため**git履歴から復元できない**。
  このwikiの3層構造ではraw/が唯一の原本であり、原本が失われるとwiki/側にも検証不可能な
  記述が残り続ける。

## 対策

- **`raw/`がソース・オブ・トゥルース**。`wiki/`の主張が争われたら必ず`raw/`に遡る。
- **主要防御は sources frontmatter の `raw:` 必須化** + lint チェック（template で実装済み）。wiki/ ページの frontmatter に `sources:` を強制する必要はなく、sources ページが `raw:` を持ち lint で検証する形が [[LLM Wikiのmain value]] の知識 network 中心モデルと整合する
- sourcesページは必ず raw/ へのリンクを含める（引用の流れ: raw → sourceページ → concept/entity）。
- lint（`scripts/lint.sh`）で「参照されているrawファイルが実在するか」を機械チェックする。
- 検証されていないソース一覧を流通させない。一覧を書くときは実在を確認してから。

## 防御メカニズムの位置付け（2026-09-03 補遺）

[[raw SSOT原則への根本検証]] の議論により、raw/ SSOT は **補助装置** として再評価された:

- **最も重要な防御機能**は **sources ページの `raw:` frontmatter 必須化 + lint チェック** — raw/ SSOT 中心でなくても実用上十分
- raw/ の **検証可能性** は knowledge network の信頼性を増す**補助機能**
- raw/ の **不変性** は LLM 範囲境界の**権限マップ**として機能
- 過度に raw/ SSOT を厳格化すると（例: 全 wiki/ ページに frontmatter `sources:` 必須）、過剰防衛になり軽量な LLM Wiki 運用と緊張する

詳細は [[LLM Wikiのmain value]] を参照。

## 研究への接続

- これはテンプレート設計課題そのものである:
  「テンプレートは情報信頼性（作文リスク）にどう対処すべきか？」
- 3層構造（`raw/`・`wiki/`・AGENTS.md）の主な根拠はこのリスクへの対処であり、
  この概念ページはその根拠を具体化したもの → [[テンプレート草案ver.1]] の検証材料。
  Karpathy自身も[[3層アーキテクチャ]]の第1層としてraw/の不変性を定義している → [[2026-08-11 Karpathy LLM Wiki Gist]]。
- nishioの[[Wikiはワークショップ]]概念も、wikiをsource of truthにしないことでこのリスクに対処している。
  wikiは動的合成層であり、気軽に書き換え・削除できる。信頼できる情報源（raw/）と明瞭分離されていることに意味がある。
- **2026-09-03 補遺**: ただし raw/ SSOT は [[LLM Wikiのmain value]] の意味で **補助装置** であり、knowledge network の main value を支える機能の1つにすぎない。template 設計では過剰防衛を避け、sources frontmatter 検証 + lint チェックで実用上対処する

## 関連

- [[overview]] — ソース一覧の掲載箇所（今回の実例の現場）
- [[テンプレート草案ver.1]] — 検証対象の設計
- [[このWikiの目的と研究課題]] — 研究課題との対応
- [[Wikiはワークショップ]] — wikiをsource of truthにしない設計
- [[3層アーキテクチャ]] — raw/の不変性の理論的基盤
- [[LLM Wikiのmain value]] — raw/ は補助装置・価値は knowledge network 自体
- [[raw SSOT原則への根本検証]] — 「raw/ SSOT = main value」は派生解釈の根拠
