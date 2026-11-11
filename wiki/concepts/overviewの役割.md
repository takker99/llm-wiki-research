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
- **ソース一覧を書く罠**: overviewにソース一覧を書くと陳腐化し、[[LLM Wikiの作文リスク]]の温床になる。実例: 2026-08-11時点でoverviewが7件のraw/ソースを列挙していたが実在は1件のみ（LLM Wikiの作文リスク）

## テンプレート骨格からの除外決定（2026-10-28）

subagent相談（GLM-5.3-Flash Free max）を経て、**template/ の骨格から overview.md を完全に除外する（Option A）**ことを決定した。

### 根拠（主根拠の差し替え）

- 「LLMが読まない（PGE実験）」は主根拠にできない。overviewの想定読者は当初から人間であり、LLM Queryフローには設計上一度も組み込まれていない。PGE実験で誰も読まなかったのは役割分担どおりの動作確認に過ぎない
- 真の根拠: (1) claims対象外の骨格継承品（[[テンプレート草案ver.1]] にoverviewのclaimなし）、(2) AGENTS.md目的欄＋配布READMEと機能重複、(3) 陳腐化罠の実証（7件列挙→実在1件）、(4) Optionality原則との整合（[[LLM WikiテンプレートのOptionality]]）。tsurubeeの最小構成（index/logのみ・overviewなし）が独立に観察済み

### 下流wikiの stub 実使用データ（2026-10-28 調査）

Option B（任意に降格）の中間案を検討する材料として、下流3 wiki のローカル実態を調査した結果、stubは **3件中3件で実際に使われた**:

- [[txa-xray-ct-wiki]]: overviewへ16 commits・最終更新4日前（早見表の新設と接続）— 活発に維持
- PGE-2026A: 講義知識構造のASCII俯瞰図＋入口＋現状に育成（複数commitで更新）
- [[elastic-wave-analyzer-wiki]]: 4 commits・約1.5ヶ月前

stubの「初回: 目的と最初のingestが終わったら書き換え」導線が機能した実績。ただし「検証されていないデフォルトを配らない」方針純度を重く見て Option A を採用した。この3/3データは本ページの論点として残す（将来の再検討材料）。

### 実装時の必須変更

- `template/AGENTS.md` ディレクトリ構成節からoverview行を削除
- `template/wiki/overview.md` を削除
- `template/wiki/index.md` の top-level overview エントリを削除（lintのstale-entries誤報回避）
- scripts×5 の overview ハードコードは無変更（メタファイル判定のパターンマッチ。ファイル不在でも無害。独立フォークがoverviewを持ち続けるため残す）
- 配布側root README.mdはoverviewに言及していないため無変更

### 本wiki自身（研究wiki）は残す

[[overviewの役割]] の研究対象であること、template修正を研究repoに後方適用しない既存規定により、研究wikiとtemplateの骨格差異は許容範囲内。撤去する根拠は乏しい。

重複解消の具体策（禁則checklist）:

- overviewを「wiki/内部の俯瞰＋入口リンク集」に1〜2行へ削減
- ソース一覧を書かない（既知罠）
- AGENTS.md原則の転記をしない
- 「次にやるべきこと」をrestatementしない（目的ページへのリンクで足りる）

### usability testは不要

index.md廃止と失敗モードの非対称性が逆。index廃止の失敗は「不可視・検出不能・全セッション影響・出口なし」だが、overview撤去の失敗は「人間が入り口を欲しがった時に無い」= 可視・目立たない・wiki単位で可逆。LLM被験体では人間向け入口の価値を測れない。作者のdogfooding（次にtemplate修正版から立ち上げる新規wiki1件）で十分。

## 関連概念

- IndexとLog — 対になる2つの特殊ファイル