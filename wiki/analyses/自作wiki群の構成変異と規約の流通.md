---
status: tentatively-adopted
date: 2026-10-23
tags: [template-design, repos, ingest, cross-cutting]
source: 3 subagentsによる~/git配下LLM Wikiのsurvey＋元ログの抜き取り検証（2026-10-23）
sources: "[[LLM Wiki実装のingest形式と運用の比較]]", "[[パイロット分析 横断所見]]", "[[AGENTS.md+SKILL.md二層設計]]", "[[Wikiとコードリポジトリの関係]]"
---

# 自作wiki群の構成変異と規約の流通

[[LLM Wiki実装のingest形式と運用の比較]]は9実装でingestの単位と出典ポインタを横断比較した。
本ページはその対象外だった講義wiki群と開発wiki群をsurveyし、wiki/の構成原理の分岐、authorityの所在、規約がwiki間をどう移動するかを観察する。
焦点がingestの形式である前ページに対して、本ページはwikiの骨組みと規約の変異に焦点を置く。
主要な事実はlogとAGENTS.mdの元ファイルで抜き取り検証した。

## 調査範囲

| 実装 | wikiの用途 | 先行の分析 |
|---|---|---|
| PGE-2026A | 地盤工学講義の概念wiki。assets運用と手順分離の発祥 | なし |
| SP1-2026A | スパコン講義の概念wiki。年度差分運用 | なし |
| MACS-2026A | 複雑系講義の予習wiki | なし |
| EGME-2026A | 地圏災害講義の予習wiki。2026-10-23開設 | なし |
| EP-2026S | 地震物理学講義の概念wiki | なし |
| FFP-2026A | FFP講義のwiki。規約が届いていない | なし |
| JGS-2026 | wiki未採用のスライド生成プロジェクト | なし |
| AMME-2026S-report | Lean証明の作戦とtooling判断の管理 | [[リポジトリ分析 AMME-2026S-report]] |
| BDL-2026S | DL講義と最終課題の知識基盤 | [[リポジトリ分析 BDL-2026S]] |
| SMS-2026S-report | ソフトマター講義と粒状体レポート | [[リポジトリ分析 SMS-2026S-report]] |
| arduino-stepping-motor-test | ファームウェアrepo内の学習wiki | なし |
| modbus-strain-calibrator | fork元コードベースのwiki化 | なし |

この他にtxa-xray-ct-wikiのworktree運用と、外部実践のarchivalであるllm-wiki-samplesを観察した。
llm-wiki-samplesはmicrosoft・nishio・delite・graspの4サブプロジェクトを包含し、[[LLM Wiki実装のingest形式と運用の比較]]の外部実装を素材として保持している。

## template家族の系譜と規約の流通

講義wiki群はおおむね共通の規約を持つ。その理由は規約のコピーで、移動の履歴が各wikiのlogに残っている。

- 発祥: PGE-2026Aが図版のassets運用を実装した。図のある資料のingest時のみ読む手順を`references/figures.md`に分離し、lintに未使用asset検出を加えた。
- 展開: starter kitのPGE版SKILL.mdがMACS-2026AとSP1-2026Aに届いた。
- 移植: EGME-2026Aの開設ログはstarter kitの展開に加えて、MACS-2026Aで進化した運用規約の移植を明記している。移植対象はGitコミット規約、figure/assets運用、frontmatterの`type`/`summary`、表と図の書き方である。
- 逆輸入: PGE-2026AのlogはSMS-2026S-reportのfrontmatter規約を参考に`type`/`summary`/`sources`を付与した記録を持つ。子wikiから親wikiへの逆方向の移動である。

規約の移動はAGENTS.mdとSKILLのコピーで起こるため、移動を重ねるほどwiki間の差分が蓄積する。
家族内で進化した規約は、家族wikiのlogに刻まれ続ける一方でtemplate配布物へは必ずしも届かない。

### purposeの非空確認と前ページの訂正1件

ここで前ページへの訂正が発生した。

⚠ Contradiction: [[LLM Wiki実装のingest形式と運用の比較]]の「template rootのコピー手順にはpurposeの非空検証がない」vs README.mdのコピー手順は「目的に1文書く。唯一の記入事項。空欄のまま運用しない」を明記する。

README.md:25とtemplate/AGENTS.mdの初期構成手順:63の両方に非空確認は存在する。
さらに家族wikiではMACS-2026AのAGENTS.mdが「空欄のままなら運用しない」を規約に書き、EGME-2026Aは開設日に人間の言語化を経てpurposeを1文で記入した。
規約文書の側の欠落として前ページの指摘は成立せず、欠落はいるとすれば機械検証の側にある。
実際に非空確認の文書が届いているにもかかわらず、下流wikiではEWAのpurposeプレースホルダ、SMS-2026S-reportの`<REPO_NAME>`見出しとpurposeコメントのプレースホルダ、FFP-2026AのAGENTS.md自体の不在という3実例でルールが守られていない。
文書規約を守らせるにはlintによるプレースホルダ警告が必要という前ページの提案の半分は、この3実例によって根拠を得た。

## wiki/構成の分岐

| 構成原理 | 実装 | wikiの骨組み |
|---|---|---|
| 概念軸 | template家族4件、SMS-2026S-report | 講義回用ページを作らない。sources/の日付付きページが目次を兼ねる |
| 講義回軸 | BDL-2026S、EP-2026S | lectures/とhomework/やLECNEP-XXなど講義回単位のページを持つ |
| 製作物軸 | AMME-2026S-report | proofs/のq1からq7のlogとproject/が本体で、証明の進行管理がwikiの本業 |
| API解説軸 | arduino-stepping-motor-test | api/とtutorials/が公式リファレンスの統合層。kebab-case英語名、frontmatter必須 |
| flat構成 | modbus-strain-calibrator | サブディレクトリなしの9ページ。index.mdが読む順序と用語集を持つ |

- 概念軸のwikiではquery後のfile-backに株分けが使われる。SP1-2026Aはquery「台数効果ってなに？」の流れで台数効果を独立ページに分離し、元ページから該当節を削除して配置を整えた。[[株分け（kabuwake）]]の実例が講義wiki側にもある。
- entityの解釈は割れたままである。EP-2026Sは法則・方程式・人物、BDL-2026Sは実験データとADR、SMS-2026S-reportはsourceページをentities配下に置く変則配置、graspはcurrent factsとした。前ページがanalysesの意味の割れを観察したのと同型の問題がentityでも起きている。
- purposeが作業の優先順位を決めている。MACS-2026Aのpurposeは講義前に把握してmini quizと最終レポートに備える実利を書き、SP1-2026Aのindex.mdのエントリはMiyabiの配布日とレポート締切を載せる。台帳が講義の日程表を兼ねる。

## authorityの所在

| authority | 実装 | しくみ |
|---|---|---|
| markdown直編集 | template家族本体、EP、AMME | wiki/を直に書き換え、gitが永続とauditを担う |
| コード | modbus-strain-calibrator | raw/は未使用。コード自体がraw相当であり、AGENTS.mdはデザイン・通信・ポーリングの変更に対応して必ず更新すべきwikiページを列挙する |
| SQLite作業層 | BDL-2026S | sessionごとに一時storeへwikiをimportし、read/search/backlinksをgrasp CLIで行う。wiki/のmarkdownはgitの永続層 |
| SQLite SSOT | SMS-2026S-report | wiki/は読み取り専用の投影。書き込みは`grasp write-page`経由 |
| SQLite SSOT | grasp | 前ページと[[リポジトリ分析 grasp]]を参照 |

- SQLite化の変異が開発wikiから講義・研究wikiに届いた。SMS-2026S-reportが極端形、BDL-2026Sが折衷形である。[[Wikiとコードリポジトリの関係]]のSSOT論点に、講義・研究wiki側からのデータ点が加わる。
- modbus-strain-calibratorのwiki logはtypecheck、lint、test 55/55の結果まで刻む。wikiのlogが実装のoperation ledgerと一本化されている。
- modbus-strain-calibratorのwiki logはエントリを末尾に追加すると明言する。本wikiやgraspがエントリを先頭に追加するのと逆方向であり、logの追加方向も実装間で分岐している。

## rawの取り扱いの変異

- 年度raw差し替え: PGE-2026Aは2026-10-12に第2回講義のPDFを今期配布版へ差し替えてwikiを書き換え、旧版との差分の説明をsourceページに記録した。template/AGENTS.mdが許す不変性の例外は引用時アーカイブの新規追加のみで、差し替えは規約の未定義域にある。
- SOURCES.md manifest: arduino-stepping-motor-testはrawをgit管理から外し、raw直下の`SOURCES.md`にファイル・内容・出典URLの表と収集日を手動で維持する。gitignore型rawではmanifestだけが出典確認の層として残る。[[rawディレクトリの取り扱い]]のmanifest論点へのデータ点である。
- worktree参照: txa-xray-ct-wiki-papergraphはGitHub forkではなくtxa-xray-ct-wikiのworktreeで、`.git`はworktreeのgitdirを指す。単一のfeature開発のための第二チェックアウトであり、forkでもsubmoduleでもないwiki+app一体repoの分岐手段が現れた。

## 失敗の3段階

欠落の程度が3段階で観察できる。

- purpose空欄: EWAがプレースホルダのまま停止した、SMS-2026S-reportの見出しとpurposeがプレースホルダのまま、という前ページ観察の追加実例が2件。
- AGENTS.md不在: FFP-2026A。gitは初期化のみでcommitが1つもなく、AGENTS.mdが存在しない。wiki側はindex/log/overviewとskillsが揃い、シラバスingestでconcepts10本まで育っている。wikiの中身だけが規約なしで先行した状態である。
- wiki不在: JGS-2026。wiki/を作らず、AGENTS.mdに研究コア情報全文とスライド生成規則を書いてwikiの代わりとする。パターンの縮退ではなく、wikiを導入しない選択の記録として残る。

段階ごとに手当てが違う。
purpose空欄は機械検証、AGENTS.md不在はstarter kitの再配布、wiki不在は非wikiパターンとして記録するかwikiを導入するかの判断である。
配布するstarter kitはwikiの骨組みと規約を同窓で届けており、3段階目は配布の外側にある状態として観察している。

## re-ingestはlogの語彙に先に出現する

- SP1-2026Aは過年度のrawと本年度のtranscriptをrawに持ち、2026-10-13に`re-ingest | 2026年度ガイダンス差分の書き換え漏れ修正`としてlogを刻んだ。subagent4本を並列でwiki走査に使い、新規1・更新16ページで、旧対照注記の全ページ削除とfrontmatterの旧raw参照の修正まで行っている。
- 一方、SP1・PGE・SMSのどのSKILLにも`re-ingest`や`再ingest`の手順は存在しない。語彙だけがlogに先に出現しており、手順の定義が後に来ている。
- 前ページが指摘したre-ingestの未定義域は、単なる空欄ではなく運用が手順に先行した状態である。template側のaction語彙定義には実運用側で生まれた語彙の最初の実例が供給された。

## lintの利用密度

- 前ページはtxa以外でlintが日常運用に入っていないと観察した。講義wiki群では逆に、立ち上げ当日からlintを回している。
- EGME-2026Aは開設日にstarter kit展開と同時にlintクリーンを確認し、43ページ時点でもlintの全項目クリアを記録した。PGE-2026Aはlintに未使用asset検出を追加してlint自体を育てた。
- 成熟側でもtxaはlintを運用に組み込んでいる。lintの利用密度はwikiのphaseだけでは説明が付かず、wikiごとの保守の選択に近い。
phase差として整理するには観察期間が足りない。

## テンプレートへの含意

- entityの解釈: analysesの割れと同型の問題がentityでも観察された。concepts/entities/sources/analysesの各ディレクトリに実例を1つずつ書くだけで、wikiごとの再解釈が減る可能性がある。
- purpose: 非空確認はREADME、template/AGENTS.md、家族wikiの規約に既に存在し、欠落しているのは機械検証の側である。前ページの提案は手順追加から外し、下流wikiで守られなかった3実例を挙げてlintのプレースホルダ警告の必要性を示す方向に絞る。
- raw差し替え: 引用時アーカイブに並ぶ例外として年度差分の差し替えを明記するか、差し替えをre-ingestの手順に統合して差分説明をsourceページに残す運用を規約化するか。
- JGS型: wikiなしのAGENTS.md全文型を非wikiパターンとして記録する位置がtemplateにはない。starter kit配布の届かない状態をどこまで想定するかという問いになる。

## 未解決

- [ ] entitiesの解釈を実例付きでtemplateに書くか
- [ ] lintにpurposeのプレースホルダ・非空警告を足すか。lint.shかSKILLか
- [ ] rawの年度差し替えを不変性の例外に明記するか、re-ingest手順に統合するか
- [ ] re-ingestの手順をingest SKILLに足すか、log種別の運用に任せるか
- [ ] FFP-2026Aの規約をstarter kitの再配布で補うか
- [ ] JGS型のwikiなし運用を非wikiパターンとして記録するか
- [ ] logの追加方向の分岐をtemplateで統一するか、per-repo宣言に任せるか
- [ ] lint利用密度のphase差の観察を継続するか

## 関連

- [[LLM Wiki実装のingest形式と運用の比較]] — ingest単位と出典ポインタの9実装横断。本ページを補完し、purpose非空手順の指摘1件を訂正する
- [[ingestの意義とsourcesページの役割]] — Karpathy gist原文のingest節への照合。本ページのre-ingest語彙先行の観察をkept currentの欠落として位置づけ直す
- [[パイロット分析 横断所見]] — AGENTS.mdのサイズとindex/log配置の横断
- [[AGENTS.md+SKILL.md二層設計]] — 家族wikiを通じて広がった二層化
- [[Wikiとコードリポジトリの関係]] — コードSSOT型とSQLite型のデータ点
- [[rawディレクトリの取り扱い]] — manifestと不変性の例外のデータ点
- [[テンプレート草案ver.1]] — 検証対象のclaims
- [[claims対応表]] — claimごとの追跡器
- [[IndexとLog]] — 台帳が講義スケジュールを兼ねる実例
- [[株分け（kabuwake）]] — query後のfile-backでの実施行
- [[elastic-wave-analyzer-wiki]]、[[txa-xray-ct-wiki]] — template由来の下流wiki
- [[リポジトリ分析 AMME-2026S-report]]、[[リポジトリ分析 BDL-2026S]]、[[リポジトリ分析 SMS-2026S-report]]、[[リポジトリ分析 grasp]] — 先行のパイロット分析
