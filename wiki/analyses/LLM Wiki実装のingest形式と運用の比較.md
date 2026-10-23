---
status: tentatively-adopted
date: 2026-10-23
tags: [template-design, repos, ingest, cross-cutting]
source: 4 subagentsによる~/git配下LLM Wikiのsurvey（2026-10-23）
sources: "[[パイロット分析 横断所見]]", "[[テンプレート草案ver.1]]", "[[claims対応表]]"
---

# LLM Wiki実装のingest形式と運用の比較

`~/git/`配下のLLM Wiki 8実装と実装repo 1件を、ingestの形式と操作・運用の観点で横断比較した。
対象は自作wiki 5件、外部サンプル3件、実装repo 1件である。
調査は4つのsubagentに分担させ、要となる事実は元ファイルで抜き取り検証した。

比較の目的は、テンプレートのingest手順と運用規則のうち、どの部分が実装間で共通し、どの部分が入力や目的に依存して分岐するかを見極めることにある。
[[テンプレート草案ver.1]]のclaimsと[[claims対応表]]に対する追加のデータ点でもある。

## 調査範囲

| 実装 | 性格 | 規模 | 稼働 |
|---|---|---|---|
| [[txa-xray-ct-wiki]] | 実験・解析の研究wiki | 246ページ、sources 36、analyses 128 | 364 commits、5週間 |
| wings-cfs-wiki | 応募スライドの構成管理 | 30ページ、sources 13 | 61 commits、11日 |
| [[elastic-wave-analyzer-wiki]] | 解析アプリの使い込み | 25ページ、sources 2、concepts 18 | 8 commits、16日で停止 |
| information-seeking | 情報探索の研究wiki | 82ページ、sources 23、entities 0 | 4 commits、2日 |
| llm-wiki-template root | テンプレート研究wiki | 128ページ、sources 15 | 51 commits、2ヶ月 |
| llm-wiki-about-nishio | 個人の知識wiki | 48ページ、sources 14 | 14 commits、6日 |
| llm-wiki-about-delite | 用語カタログの公開wiki | 100+ページ、sources 4 | 9 commits、2日 |
| grasp | 開発wiki | 49ページ、log 392 | 492 commits、10日 |
| microsoft-llmwiki | 運用をソフトウェア化する実装repo | 実運用wikiなし | 232 commits |

`template/`は配布物として別に扱う。
以下の比較では、実装repoであるmicrosoft-llmwikiを運用wikiの傾向から外す。

## ingestの形式

### 入口と単位

ingestの単位は、入力のトポロジーに従って分岐している。

| 入力 | 単位 | 実例 |
|---|---|---|
| 論文・PDF | 1文書=1ページ | txa、EWA、template root |
| Web・APIドキュメント | 1説明単位=1ページ。同一トピックの複数URLを束ねる場合がある | information-seeking、wings |
| 成果物・実験データ | 成果物1ファイルまたは実験ディレクトリ=1ページ | wings、txa |
| Cosenseのグラフ | キーワードまたは1–2hopバンドル=1ページ | nishio |
| コーパス | バンドル全体=1ページの目録 | delite |
| 設計対話・作業ログ | セッション=1ページ | grasp |

テンプレートの「1ソース=1ページ」は文書型にはそのまま当てはまるが、Webのトピック集約、Cosenseのバンドル、実験データのディレクトリには当てはまらない。
`information-seeking`のSMS事例は13本のPDFを1ページに束ね、`nishio`は24,000ページのコーパスからキーワードで切り出した集合を1ページにしている。
単位は「ファイル」ではなく「説明のまとまり」で決まっている。

### sourceページの4類型

sourceページは、どの実装でも同じ役割を担っていない。
観察された類型は次の4つである。

| 類型 | 書かれる内容 | 実例 | 強みと弱み |
|---|---|---|---|
| 要約＋引用台帳 | 書誌、主要結果、既存概念への含意、未解決の問い | txa、EWA、template root | 主張の検証に強い。要約の更新コストが高い |
| データ・成果物の台帳 | 計測条件、ファイル一覧、既知の制約、成果物との対応 | txaの実験データ、wings | 再現と成果物同期に強い。要約としては冗長になりやすい |
| コーパスの目録 | 収録範囲、カテゴリ別の代表ページ、収集メタデータ | delite | 大量資料を俯瞰できる。claim単位の検証は弱い |
| 実装済み事実・決定 | current facts、未実装項目、判断の履歴 | grasp | 実装との同期に強い。出典への遡及は弱い |

テンプレートはsourceページを「要約＋関連concept/entityへのリンク＋rawへのリンク」としか定義していない。
このため見出し骨格は実装ごとに分岐した。
txaは`## 本 wiki への含意`で既存概念の書き換えまで書き、wingsは`## スライド作成との関係`で成果物との対応を書き、information-seekingは`## 設計含意`で探索経路への組み込みを書く。
同じ「含意」の節が、実装ごとに異なる仕事をしている。

### 出典ポインタの4モード

「rawがsource of truth」という原則は、実装では4つの異なる形で運用されている。

| モード | 実現方法 | 実例 | 検証可能性 |
|---|---|---|---|
| アーカイブ型 | rawに原文を置き、frontmatterからパスで指す | txa、template root | 原文に遡れる。rawの管理コストが高い |
| URL型 | `source_url`と`accessed`だけを持ち、本文を複製しない | information-seekingの22/23 | 取得時点は示せる。URLが変わると遡れない |
| commit固定型 | 外部repoをsubmoduleにし、`commit`を記録する | wingsのtxa参照 | 版を固定できる。pinの更新漏れが起きる |
| セッション型 | 日付、話者、要約、未確認事項をラベルで残す | wingsの面接原稿・想定問答 | 口頭知識を残せる。rawに遡れない |

`information-seeking`はrawが0ファイルで、23 sourcesのうち22がURLのみである。
`grasp`とnishioのコーパスはrawをgitignoreしている。
`wings`のsubmoduleはsourceページの`commit: 07d7a6c`が実HEAD `b7d810e`に追随していない。
「rawが唯一のsource of truth」は、少なくとも実装の傾向としては、複数モードのうちの1つにすぎない。

### 1回のingestの波及

| 実装 | 1回の新規・更新ページ | 備考 |
|---|---|---|
| txa | 9–16ページ | 論文ingest。実験データは5ページ程度 |
| template root | 33–53ページ | entityを9–15個作る初回ingest |
| wings | 1–26ページ | 初回バッチは26ファイル、通常は1–5ページ |
| information-seeking | 約3.4 concepts/source | entityを作らない |
| EWA | 2ソースから22ページ | 初回。conceptを厚く作る |

テンプレートの「1ソースで10–15ページ」は、entityを作りconceptを厚く書くwikiでは成立する。
entityを作らないwikiでは3–4ページ、成果物型では1–5ページになる。
数値はwikiの種類に依存する期待値であり、普遍的な正常値ではない。

## 操作・運用

### 実行手順の正本

| 実装 | 手順の正本 | lint | 更新様式 |
|---|---|---|---|
| txa | ingest SKILL＋用語ゲート＋文献探索・DOI検証 | 8種の機械チェック＋11項目の意味チェック | 書き換え。correctionとfixで訂正 |
| wings | ingest SKILL | SKILLはprovenance検査を約束するがscript未実装。logに実行記録0 | 版を別sourceとして追加、または上書き |
| EWA | 旧ingest SKILL | 旧lint。BROKEN 2件のみ | 再ingestでsourceをリネームし更新履歴を残す |
| information-seeking | templateと同一のSKILL | orphan 0、broken 1 | analysesは節の追記もあり |
| template root | AGENTS.md直書き。ingest SKILLなし | root版scriptはraw検査を追加 | 書き換え＋編み込み修正 |
| nishio | AGENTS.md | 手順のみ。スクリプトなし | `## Updates`で追記、`## Open Questions`で未解決を明示 |
| delite | CLAUDE.md | `verify_links.py`のみ決定的 | 書き換え＋`## 先行概念` |
| grasp | AGENTS.md＋runbook＋CLI | `lint_wiki.py` | 種別ごとに事実更新、decision追記 |

注目すべきは、txa以外の実装でlintが日常運用に入っていないことである。
wingsは39エントリのlogにlintの記録が0回、EWAはコミット本文に1回だけ、information-seekingは2日間で1回も記録がない。
txaだけが用語チェックと未解決の問いの棚卸しをlintに組み込み、ingestの前段と後段に接続している。

### ingest以外の操作が主経路になる

長期運用に入ると、ingestよりfile-back、訂正、編み込み修正、成果物同期が主な作業になる。

| 実装 | 主なactionの内訳 |
|---|---|
| txa | analysis 60、file-back 39、edit 36、fix 33、ingest 30 |
| template root | file-back 27、refactor 12、ingest 9 |
| wings | 初回ingest後はslides修正とfile-backが中心 |
| EWA | 初回ingest後は再ingestとfile-backが中心 |

template rootは2026-08-14以降ingestが0で、以後は設計判断のfile-backとobservationが中心である。
txaはanalyses 128ページに対してsources 36ページで、成長の主経路は分析のpage化にある。
ingestは入口の一つであり、wikiを育てる操作の大部分はingestの外にある。

### 人間の関与

人間の関与は「3–5の要点を議論する」ステップより、選択と決定に集中している。

- wingsはlogの40箇所に人間の指示・判断が現れ、ほぼ全エントリが人間の発話に紐づく。
- txaは用語の採否、主指標の決定、次回試験の設計に人間が関与する。
- template rootはテンプレート設計の判断を人間が行い、subagent相談を重ねる。
- information-seekingは14 sourcesを一括再ingestし、議論ステップの痕跡を残していない。
- EWAはlogに人間の記述が0回で、誰の判断で何を変えたかが残らない。

バッチingestでは「3–5の要点を議論」が実行不能になりやすい。
代わりに、rawの配置、用語の決定、成果物の採否、次アクションの判断に人間が現れる。

## 系統分類

調査結果は、設計空間を4系統に整理できる。

| 系統 | 代表 | 中心 | 得意 | 苦手 |
|---|---|---|---|---|
| インバウンド知識分解型 | txa、EWA | 原典をconceptに分解する | claim単位の引用、用語統制、知識の遡及 | 鮮度劣化が静か。sourceが増えないと成長しない |
| アウトバウンド成果物型 | wings | 成果物を中心に構成する | 意思決定の再構成、締切駆動の速度 | 仕様の多重管理、来歴ドリフト、conceptの再利用困難 |
| 軽量ネットワーク型 | information-seeking、nishio、delite | concept間のネットワーク | 立ち上げの軽さ、資料横断の接続 | live URL依存、出典の現物検証が弱い |
| エージェント運用型 | grasp、microsoft | 書き込みの統制と自動化 | current factsの管理、並行write、UI連携 | 規約の肥大化、実運用の証拠不足 |

自作wikiは思想上は軽量ネットワーク型に近く、規約上はインバウンド知識分解型に近い。
txaは両方を足して用語統制と文献パイプラインを加えた、最も重装備な実装である。
wingsは成果物型に振り切った結果、conceptがスライドの節になり、締切後に再利用できなくなった。

## 共通する失敗パターン

### 出典規約が文書間で一致しない

テンプレート自身がこの問題を抱えている。

- `template/AGENTS.md`は「sourcesページは必ず`raw/`へのリンクを含める」と書く。
- 同じファイルの別の行は「frontmatterの`raw:`必須」と書く。
- ingest SKILLは「`raw:`または`source_url:`が1つ以上必須」と書く。
- lint SKILLは「`raw:`を持たないsourcesページ」を機械チェックとして列挙する。
- `template/.agents/skills/llm-wiki-lint/scripts/lint.sh`はこの検査を実装していない。

この状態では、lintが通ったのに規約違反、という最も検出しにくい失敗が起きる。
information-seekingはAGENTS.mdだけを緩めてskillを同期せず、22/23をURLのみで運用している。
txaには`raw:`にURLを入れた違反が残り、lintは検出しない。

### 規則と実装がずれる

wingsのlintはprovenance検査を約束するが、scriptはorphan、broken、indexしか見ない。
microsoftのREADMEは矛盾の記録をうたうが、lintに矛盾カテゴリがなく、`/save`はスタブである。
graspのlintには存在しない`wiki/analyses`への参照が残る。
規約が先に書かれ、実装が追随しないパターンが繰り返されている。

### 意図的赤リンクとlintが衝突する

EWAは再ingestでsourceをリネームし、旧タイトルへのリンクを赤リンクとして残す。
wingsはtxa側のページ名をwikilinkで参照するが、自wikiにはページがない。
txaはパス形式のwikilinkがBROKENの相当部分を占める。
いずれも意図的な参照だが、lintはtypoや未消化として扱う。
「赤リンクは許容」という原則と、参照数でエラーと発見を分けるlintが、実装間で接続されていない。

### purposeが空文化する

EWAはAGENTS.mdのpurposeがプレースホルダのままで、実質的な目的は`overview.md`にある。
template rootのコピー手順にはpurposeの非空検証がない。
「唯一の記入事項」と書いても、機械的な確認がなければ守られない。

### re-ingestが一次操作として存在しない

information-seekingは14 sourcesを再ingestし、EWAはrepoを再ingestしてsourceをリネームした。
wingsはsubmoduleの更新をsourceページに反映していない。
しかし、どのingest SKILLにもre-ingestの手順がない。
古い要約をどう捨てるか、`accessed`を更新するか、commit pinを進めるかが未定義である。

### analysesの意味が割れる

txaは分析、wingsは仕様と決定ログ、EWAは提案と実務ガイド、information-seekingは研究ノートとしてanalysesを使う。
テンプレートは「分析・比較・総合」としか定義しておらず、ディレクトリ名が仕事を規定していない。
`grasp`のようにdecisionsとbacklogを第一級にする実装、`delite`のようにsynthesesを持つ実装もある。

### 口頭知識のprovenanceがない

wingsの面接原稿と想定問答、EWAの一般知識由来のDFT、txaの分析判断はrawに遡れない。
日付ラベルやlogが唯一の痕跡である。
file-back中心の運用には、会話・口頭知識用のsource形式が必要になる。

## テンプレートへの含意

| 論点 | 現状 | 提案 |
|---|---|---|
| 出典ポインタ | `raw`必須とURL許容が文書間で矛盾 | `provenance:`モードを導入し、`archived`、`url`、`commit`、`session`をlintがモード別に検査する |
| sourceの骨格 | 見出し未定義で実装ごとに分岐 | デフォルト骨格を提示する。`## 要点`、`## 含意`、`## 関連`を最小とし、変更可と明記する |
| sourceの役割 | すべて「要約」と呼ぶ | `role:`を任意で持たせ、summary、ledger、inventory、decisionで粒度の期待値を変える |
| ingestの語彙 | 新規追加のみ | `ingest`、`re-ingest`、`batch ingest`、`refactor`、`file-back`をaction語彙として定義する |
| 波及範囲 | 「10–15ページが正常」 | entityを含む場合の条件付き期待値に変えるか、削除する |
| 規則と検査の一致 | SKILLの約束をscriptが実装していない | lintに`--self-check`を設け、宣言された検査名と実装の対応を検証する |
| purpose | 「唯一の記入事項」だが空欄が発生 | コピー手順に非空検証を追加し、lintでもプレースホルダを警告する |
| コピー配布 | root、template、下流で3変種に分岐 | template由来ファイルのマーカーと同期手順、または差分を戻す運用を明文化する |
| 外部repo | commit pinがdriftする | `commit:`と最終確認日を必須にし、再ingestのトリガーをlogに残す |
| 口頭・会話知識 | rawがない | `source: session`用の形式を用意する。日付、話者、要約、未確認事項を必須にする |

優先度が高いのは出典規約の一本化と規則・実装の一致テストである。
次にre-ingestの定義が必要になる。
どちらも、実装間で繰り返し観察された失敗に直結している。

## 未解決

- [ ] provenanceモードを1つのfrontmatterキーで表現するか、sourceの種類ごとに別のキーにするか
- [ ] sourceの`role:`をテンプレートの規範に含めるか、variant guideに回すか
- [ ] re-ingestをingest SKILLの節として足すか、別skillに分けるか
- [ ] lintの`--self-check`をどの粒度で実装するか。検査名の対応だけか、出力の存在まで確認するか
- [ ] analysesの意味をテンプレートで定義するか、ディレクトリ名を利用者に委ねるか
- [ ] purposeの非空検証をlintに入れるか、コピー手順だけで足りるか
- [ ] `information-seeking`と`wings-cfs-wiki`をentityとして登録するか

## 関連

- [[自作wiki群の構成変異と規約の流通]] — 対象外であった講義wiki群と開発wiki群12実装のsurvey。構成原理の分岐、authorityの分布、規約の家族内流通を補い、purpose非空手順の所在を訂正する観察を含む
- [[パイロット分析 横断所見]] — 外部repo 5件の横断比較。本ページは自作wikiと運用実態を加えた拡張
- [[テンプレート草案ver.1]] — 検証対象のclaims
- [[claims対応表]] — claimごとの記述的検証と規範的决定
- [[ingestにおける編み込みの実際]] — 1ソースの波及範囲の実測
- [[ingestの監視頻度とソース数の2軸]] — バッチingestと監視の設計
- [[raw SSOT原則への根本検証]] — 出典ポインタの複数モードとmain valueの議論
- [[rawディレクトリの取り扱い]] — rawのgitignoreとmanifest
- [[赤リンクとLLM Wiki]] — 意図的赤リンクとlintの参照数分類
- [[Lint]] — 機械チェックと意味チェックの分担
- [[elastic-wave-analyzer-wiki]] — 下流wiki 1件目
- [[txa-xray-ct-wiki]] — 下流wiki 2件目
