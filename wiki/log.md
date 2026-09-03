# Log

Append-only timeline of wiki operations.
Format: `## [YYYY-MM-DD] action | 短い題名` + 詳細は本文。

Parse with: `grep "^## \[" log.md | tail -5`

## [2026-08-01] init | wiki created

wiki created for llm-wiki-template research

## [2026-08-01] file-back | このWikiの目的と研究課題

created analyses/ page, updated index/log

## [2026-08-11] source-loss | raw/の6ソース誤削除

raw/の6ソース（nishio 4 + villagepump 2）がユーザー誤削除。raw/はgitignore対象のため復元不可。再取得予定

## [2026-08-11] refactor | 役割分離

AGENTS.mdを運用規則のみに縮小、テンプレート草案をanalyses/テンプレート草案ver.1へ移管、README/overview修正 (touched 6 pages)

## [2026-08-11] refactor | テンプレート草案ver.1をポインタページ化

本文コピー（220行）を削除し原文は git 6c821c1:AGENTS.md を参照 (touched 3 pages)

## [2026-08-11] ingest | LLM Wikiの作文リスク

concept page。きっかけ: overview.mdのソース一覧が実在1件のみと判明

## [2026-08-11] repo-rename | llm-wiki-template → llm-wiki-research

## [2026-08-11] file-back | Cosenseソースのingest方式

subagent相談結果をanalyses/に提案として保存。status: hypothesis、決定ではない。index/log更新

## [2026-08-11] file-back | rawディレクトリの取り扱い

gitignoreの動機・二面性・発見層とrawの分離・manifest.md。repo cloneはraw/外に置く方針。status: hypothesis, open question。index/log更新

## [2026-08-11] adopt | Cosenseソースのingest方式を仮採用

subagent相談2往復+lint正規表現実機検証。仮採用セット10項目。AGENTS.md・lint.sh・.gitignore・提案2ページ・index/log更新

## [2026-08-11] ingest | Karpathy LLM Wiki Gist

touched 33 pages: 1 source + 17 concepts + 9 entities + 4 existing updated + 2 index/log; later +11 existing cross-link updates

## [2026-08-11] ingest | Cosense LLM Wiki議論

villagepump AIを使った知識マネジメント + nishio KarpathyのLLM Wiki勉強会 + 2-hop先7ページ; touched 53 pages: 2 sources + 23 concepts + 15 entities + 11 existing updated + 2 index/log

## [2026-08-11] refactor | 編み込み修正

既存11ページにCosense ingestのクロスリンクを追加

## [2026-08-11] file-back | ingestにおける編み込みの実際

2回のingest実績データ + nishioの定式 + 3層波及構造 + 教訓。index/log更新

## [2026-08-11] file-back | ingestステップの設計判断

3提案のsubagent検証 + 採用/却下の判断。index/log更新

## [2026-08-11] refactor(agents) | ingestステップ改善

既存照合+未カバー領域特定を追加、logフォーマットを内訳付きに拡張、Lintにingest空白指摘の集約を追記

## [2026-08-11] file-back | ingestの監視頻度とソース数の2軸

analyses/新規 + バッチIngest・事前にやろうとしない運用哲学にクロスリンク + index/log更新。きっかけ: nishioのチェック省略はバッチingestと同型という気づき

## [2026-08-11] query | concept/entity境界の検証

raw全ソースに定義なし、villagepumpの表は簡潔さポリシー、入リンク実測でentityもハブ化（Obsidian 9, qmd 7, Marp 6）。4分類は実質3分類＋ナビゲーション用タクソノミ。研究課題の追記 + テンプレート草案ver.1 evidenceに追記

## [2026-08-11] ingest | zenn tsurubee記事

raw/にアーカイブ + manifest追記。touched 13 pages: 1 source + 2 concepts new (繋げる力, 理解のボトルネック) + 8 existing updated + 2 index/log。評価: 要約どまり。理解のボトルネック vs 読まれなくてよい中間産物の対立を研究課題に追加、草案ver.1 claim#7に反証データ点を記録

## [2026-08-11] query | 理解のボトルネックへのnishioの回答

勉強会raw L177-196: LLM Wikiは知識のネットワークを人間の外側で作る。内部ネットワークは手段にすぎない。人間の役割は目的の言語化。概念ページに追記 + 手段の目的化の問い直しを考察として追加 (touched 3 pages: concept + source + index/log)

## [2026-08-11] ingest | OKF (Open Knowledge Format)

raw/に4アーカイブ: nishio OKFとLLM Wiki + 一貫・網羅・頂点 + villagepump 2026/06/13 + stakiran gist。manifest追記。touched 8 pages: 1 source + 1 entity new (OKF) + 1 concept new (一貫・網羅・頂点) + Lint・研究課題更新 + index/log

## [2026-08-11] file-back | nishioのOKF評価

query回答をanalyses/に保存: format層のみ標準化 + cross-run stability批判 + 撤回の内実はドメイン違い。index/log更新

## [2026-08-12] file-back | AIランチエ

query回答をconcepts/に保存: パレートのランチエ/スペキュラトゥール由来、接地の衛生の委譲と境界監督の落とし穴。index/log更新

## [2026-08-12] file-back | GitHubリポジトリ分析の方法論

subagent 3体との相談結果をanalyses/に保存。発見層+選択的アーカイブ、Template Analysis、設計空間マップ、リスク一覧。index/log更新

## [2026-08-12] split | 外部リポジトリ分析のリスクと罠

GitHubリポジトリ分析の方法論からリスク編を分離・拡充。6+3類型の分析罠、リスクマトリクス追加。親ページ・index/log更新

## [2026-08-12] file-back | パイロット分析4ページ

subagentによる3 repo並行分析 → 個別3ページ + 横断所見1ページ。nishio/llm-wiki-about-nishio + grasp + takker99/AMME-2026S-report。index/log更新

## [2026-08-12] file-back | パイロット分析追加2件 + 横断所見更新

BDL-2026S: 最大規模330p + llm-wiki-about-delite: 43時間停止/CLAUDE.mdのみ/Quartz。横断所見を5件に拡張、停止の2類型・init.txtパターン・命名規則2派・grasp名目利用の乖離を追加。index/log/manifest更新

## [2026-08-12] file-back | パイロット発見のconcept化

5新規: purpose-hoist, 二層設計, 徒歩レビュー, 統合解説層, CLA.md管理 + 4更新: Schema, IndexとLog, スケーラビリティ, Post-ingestレビューにパイロット知見反映。index/log更新

## [2026-08-14] ingest | Wikiとコードリポジトリの関係

nishio cosense: 勉強会「中にコードリポジトリを持つパターン」+ kouchou-ai-developer-wikiページ。raw/に1アーカイブ追加 + manifest追記。touched 6 pages: 1 source new + 1 concept new (Wikiとコードリポジトリの関係) + 3 existing updated (Wiki駆動開発, dd2030-wiki, 研究目的Wikiとプロジェクト目的Wiki) + index/log。内容: 同一repo型vs別repo参照型の対比、SSOTの所在、raw 1ページあたりwiki<1の量的観察、「AIが読む想定」、記憶の外部化が目的

## [2026-08-14] review | 目的↔repo型の対応を検証

subagent相談2往復で「知識の蓄積→別repo参照型・成果物管理→同一repo型」の対応を検証 → 不成立と判定。反証例: grasp/BDL-2026S=知識蓄積+同一repo、dd2030-wiki=成果物管理+別repo。代替基準: コードの有無→生まれ方→知識の向き（wiki=SSOTか）→公開性。新規立ち上げは同一repoがデフォルト。concepts/Wikiとコードリポジトリの関係.md を改訂: 比較表更新 + 含意節の4段階選択 + work/運用規定追加（stalenessは防ぐのではなく記録する）。index/log更新

## [2026-08-14] file-back | repo型の知見を4ページに分散

1: 概念ページに「読む主体はrepo型を決めない」「目的軸とrepo型軸は直交」を追記。2: リポジトリ分析BDL-2026Sに分類ラベル補正（主目的=知識蓄積の同一repo型反証例）。3: 研究課題に配布形式の要件「wiki/単独で取り出せる」を追記。4: 横断所見に#12「分類ラベルは目的ラベルでありrepo型ラベルではない」を追加。index/log更新

## [2026-08-14] file-back | raw/不変性の設計思想

query: Karpathyの不変 vs nishioの実運用とgitignore repoでは不変でない。subagent相談2往復: 観察は部分正しく2類型の混在、不変性の3機能（検証/書き換え自由の担保/LLM範囲境界）、入場時の誓約（性質文→時間規則で例外条項消滅）、コーパスモードの条件付き正当化、「git=不変性担保」撤回と新軸「可視性×転載可能性」。analyses/rawディレクトリの取り扱いを更新（claims候補・未解決論点改訂）+ concepts/3層アーキテクチャの乖離修正（概念文言とAGENTS.md運用の矛盾を解消）+ index/log更新

## [2026-08-14] fix | lint.shのraw参照チェックの偽陽性を解消

正規表現の除外文字に全角括弧（）と→を追加。`・`は実在ファイル「一貫・網羅・頂点-2026-08-11.md」を壊すため追加せず、AMME分析の三層定義セルと方法論のmanifest分離記述は文言を意味保持のまま微修正。MISSING RAW 0件に。index/log更新

## [2026-08-14] file-back | log.mdとgit logの分工

query: 「git管理下ならcommit messageで操作履歴を賄えlog.md不要では？」をsubagent相談2往復で検証。結論: 部分的正しく全体としては誤り。操作時刻vsコミット時刻のズレ、git履歴の書き換え可能性、log.mdにしか書けない7種の情報、粒度のトリレンマ、既存議論はDiors.techのGit+log.md分工とCHANGELOG論争のみ。テンプレート示唆: log.md維持+1行規約・ローテーション・lintサイズチェックの軽量化デフォルト化。analyses/新規 + index/log更新

## [2026-08-14] refactor | log.mdエントリ形式の変更

見出しを `## [DATE] action | 短い題名` に短縮し、詳細は本文（body）に移動。rendering時の見づらさ解消。既存エントリは情報を保持したまま再整形（追記専用の例外として明示的に実施）。`grep "^## \["` によるパースは引き続き可能。AGENTS.mdのフォーマット仕様2箇所・analyses/log.mdとgit logの分工の推奨文案を更新

## [2026-08-14] file-back | log.md形式の既存実装調査

query: 既存llm wikiのlog.md形式を実リポジトリで調査（about-nishio/delite/graspはraw.githubusercontentで実地確認、BDL/AMMEはprivateのためwiki記録のみ）。結果: 見出しは全実装で短い（`## [DATE] action | 短い対象名`がデファクト）、詳細は本文に書くのが標準。種別語彙はabout-nishio (filing-back/deliverable/correction/scaffold)・grasp (implementation+file-back複合) へ拡張。粒度はabout-nishio/graspが時刻まで、deliteは日付のみ。当wikiの旧形式（見出し長文込み）は例外的で、2026-08-14の変更でデファクトに追いついた。concepts/IndexとLogに形式バリエーション節を追加。index/log更新

## [2026-08-14] ingest | microsoft-llmwiki

「Microsoft製のLLM Wiki製品repoをingestしてほしい」の依頼で実施。運用repo5件とは異なる**実装repo（ツール型）**として分析。cloneは発見層 ~/git/llm-wiki-samples/microsoft-llmwiki@b44df6ae（raw/コピーなし・ユーザー選択）。抽出した知見: 3層アーキテクチャの独立収束（index/log形式も当wikiとほぼ同一）、init生成の7セクションAGENTS.mdテンプレート（ガチガチ側の極）、lint 6分類（stale-entries/index-completeness）、weighted query（title 3x/summary 2x/body 1x）、操作層の完全ソフトウェア実装（MCP 14ツール・@wiki /save）、Copilot依存。研究課題「既存の実装との差別化」「配布形式」のTODOにデータ点を追加。
(touched 9 pages: 3 new [リポジトリ分析 microsoft-llmwiki / 操作層 / Microsoft llmwiki] + 6 existing updated [3層アーキテクチャ, Schema, Lint, QueryとFile-back, IndexとLog, バッチIngest, 横断所見, 研究課題] + index/log)

## [2026-08-14] file-back | microsoft-llmwikiの草案への落とし込み候補

query「microsoft/llmwikiからテンプレート草案づくりに有用な手法は？」の回答をfile-back。有用5点: lintのstale-entries/index-completeness分離、weighted query（title 3x/summary 2x/body 1x）、init scaffold最小セット、queries/+type:queryのfile-back制度化、MCP write系安全検証の執筆規約への翻訳。不採用: 7セクション全量・slugify・.wiki/埋め込み・Copilot依存。テンプレート草案ver.1のclaims#2/#4にevidence追記（Microsoftもinitで4分類固定＝初期固定型の分岐、index方式の独立実装+保守コスト対策）。リポジトリ分析ページに落とし込み候補セクション追加。index/log更新
## [2026-08-14] ingest | cosense-link-concepts

「2 hop linksや赤リンクなど、Cosenseのリンク概念を取り入れるのが望ましい。基本概念からLLM wikiとの組み合わせまで幅広くingestしたい」の依頼で実施。前半はvillagepump/nishioの基本概念、後半はLLM Wikiとの組み合わせ（nishio+villagepump+grasp理論+実践例BDL/SMS）。

収集元: villagepump/nishioのCosenseページ群（grasp store + cosense CLI browsePage、Cosenseページ14枚をアーカイブしmanifest.md追記）。確認結果: **BDL-2026S（AGENTS.md:231-236, lint_wiki.py参照数分割）とSMS-2026S-report（lint_wiki.py:3-8）の両方がリンク概念を実装使用していた**（ユーザーの記憶通り）。

抽出した知見: ①Cosenseの2 hop linkは「具体→抽象→別の具体」で思考ジャンプを生むshokai由来の概念。②赤リンク=情報の不在の表現で、LLM WikiのOpen Questionと同型（nishio）。③AIによる赤リンクの延伸（赤リンクをベクトル検索の入力にしてページを生成）。④リンクの4仕事（recall/attention/navigation/読者ケア）を1つの`[X]`に束ねるCosenseの設計と、recallを剥がすgrasp最適設計。⑤come-from（用語-大域の1宣言で全出現をgather）がAI default 裸（AI生成ページのリンク疎）問題の解。⑥参照数分割lint（1頁=broken/error、2+頁=aspect_handle/info）が赤リンク論争への第3の選択肢。

(touched 12 pages: 5 new [Cosenseのリンク概念, 赤リンクとLLM Wiki, リポジトリ分析 SMS-2026S-report, sources×2] + 7 existing updated [リポジトリ分析 BDL-2026S, リポジトリ分析 grasp, このWikiの目的と研究課題, Lint, 赤リンクの数の議論のLLM Wiki, index, log] )

## [2026-08-14] refactor | lintに参照数分類を実装、AGENTS.mdに赤リンク許容を明文化

ingestしたリンク概念をこのwikiの運用に取り込んだ。

- `scripts/lint.sh`: 壊れたwikilinkを参照数で分類（1頁参照=BROKEN=typo or 意図的赤リンク、2+頁=ASPECT_HANDLE=ページ作成候補）。併せてエイリアス解決（`[[X|表示名]]`）とインラインコード内wikilinkの除外
- AGENTS.md: Lintセクションに参照数分類を追記、執筆の機械要件に「赤リンクは許容」を追加
- 既存リンク整理: `[[リポジトリ分析 横断所見]]`→`[[パイロット分析 横断所見]]`（typo修正）、`[[vault-separation]]`→`[[Vault分離と人間-AIの境界|vault-separation]]`（リンク解決）、`[[File-back]]`→テキスト化
- `[[fact-wiki-separation]]`（3頁参照=ASPECT_HANDLE）を概念ページ化 — 参照数分類lintの最初の実地適用事例
- 残存: `[[Low-background steel]]`、`[[LLMと盆栽]]` は意図的赤リンクとして放置（LLMと盆栽はrawソースあり、ingest候補）

(touched 5 wiki pages: 1 new [fact-wiki-separation] + 4 existing updated [QueryとFile-back, リポジトリ分析 SMS-2026S-report, Wikiはワークショップ, Lint] + index/log、非wiki 2 files [lint.sh, AGENTS.md] )

## [2026-08-14] adopt | MCP不採用・AGENTS.md+SKILL.md二層採用

query: 「MicrosoftはMCP多用のガチガチ構成。本repoのテンプレートではMCPを採用せず、中間的立ち位置のAGENTS.md+SKILL.mdを採用したい。なぜなのか自分にめっちゃ質問を繰り返したうえでsubagentと相談検討して」の依頼で実施。自己質問8問（context圧迫の実体と定量・デメリット網羅・利点の代償・中間の正しさ・単層との差・固有リスク・表現の正確性・実験台の自己整合性）の後、subagent相談2往復。

1往復目: microsoft/llmwikiのMCP 14ツール定義を実測 — 6.3KB≈1.6-2.0Kトークン/ターン常駐で**単独では軽微**（実害は集約環境・注意容量・キャッシュ無効化）。SKILL.mdもfrontmatter ~100トークン/skillが常駐（ゼロコストではない）。Agent Skillsは2025-12オープン標準化・40+プラットフォームで形式互換（発見パスのみ非標準、`.agents/`へ集約進行・Claude Codeのみ例外）。自己不整合ではないが「薄さはAMME由来の外部実証・自己適用は厚さ側のデータ点」と明文化が必要。1.9KBはスコープ限定で売りにしない。

2往復目: 推奨構成 = 3層同梱（AGENTS.md 4-6KB自己完結 + `.agents/skills/llm-wiki/SKILL.md` + root `scripts/lint.sh`、GitHub Template Repository配布）。lint.shはskill内に移さない（skill非ロード環境から到達不能）。明示パス参照が主契約・auto-discoveryはボーナス。OpenAIがAGENTS.md+`.agents/skills/`+scripts構成を公式OSS運用に採用（文書+skill構成の実証）。

決定: **MCPはデフォルト不採用・オプション追加可**。理由の複合化（context圧迫は単独軽微のため主理由から降格 → 集約環境での加算+セットアップ障壁+環境非依存維持+透明性+scripts/SKILL.mdでの代替可能性が主）。analyses/新規 + テンプレート草案ver.1にclaim#9+evidence追記 + 研究課題に自己適用実験TODO追加。index/log更新
(touched 5 wiki pages: 1 new [MCP不採用とAGENTS.md+SKILL.md二層採用の根拠] + 3 existing updated [テンプレート草案ver.1, このWikiの目的と研究課題, index] + log)

## [2026-08-14] file-back | 配布形式の決定とテンプレートの動機

ユーザーが動機（お決まり経路の再発明防止・llm-wiki.mdからの立ち上げ品質の揺れ対策）と配布形式（`template/`ディレクトリを新規wiki rootに手動コピペ・お膳立てがメイン）を提示。subagent相談2往復で妥当性検証し合意内容をanalyses/に保存。

1往復目: コピペ方式は妥当だが「最終状態ファイルのコピー」であり「init指示のコピー」ではないことが条件（delite init.txt失敗例）。ドリフトは同期機構なしで許容+バージョン記載。研究repoの文言は絶対コピー禁止。形式例はインラインコードブロックのみ。npx create-llm-wiki却下。

2往復目（反論4点: claim#7の2軸性・検証済みonlyの薄さ・複数LLM検証のコスト・customization pointsの矛盾）: ①claims対応表を「記述的検証×規範的決定」の2軸に（未決のままデフォルトは決められる）②「検証済みのみ焼き込み」は撤回・文種4分類（実証済み知見/お決まり経路/多数派デフォルト/研究repo固有）③v0.1検証は1モデル×2回+lint+構造diff（2 LLM×2目的はM2へ繰り下げ）④customization points撤回・設定事項0/記入事項1（purposeのみ）、variant guideへ移行。

template/ v0.1の構成スケッチ（AGENTS.md 9セクション+README+lint.sh+raw/manifest.md+wiki空骨格）とbootstrap成功基準（Stage 0/1/2）も同ページに記録。研究課題の配布形式TODOに暫定採用+クローズ条件（M1/M2/M3）を追記。
(touched 3 pages: 1 new [配布形式の決定とテンプレートの動機] + 1 existing updated [このWikiの目的と研究課題] + index/log)

## [2026-08-14] ingest | SKILL併用LLM Wiki 6事例

「mcpを使ったllm wikiの事例としてmicrosoft/llmwikiをingestした。SKILLを併用している事例を探したい」の依頼でweb検索 → raw/に7ファイルアーカイブ（Astro-Han 1.9k★・jackwener・vanillaflava・toolboxmd・micuintus・ivankuznetsov×2、manifest.md追記済み）→ 観点「SKILL+Wikiの二層設計の詳細比較」でingest。

抽出した知見:
- **AGENTS.md/SKILL分担の5パターン類型化**: A: SKILLがSchema層を吸収（Astro-Han・micuintus） / B: entry file数十行+操作skillの二層（jackwener、**本wikiと同一構造の独立収束**） / C: 薄いCLAUDE.md+外部スキーマ/設定ファイル分離（vanillaflava） / D: hooksによる自動注入（toolboxmd、プラットフォーム固定を許容） / E: 1行トリガー+skill+MCP併用（ivankuznetsov）
- SKILL分割粒度: 単一+lazy-loading（Astro-Han・micuintus）vs 操作別分割4-6個（jackwener・vanillaflava・ivankuznetsov）vs loader+分割（toolboxmd）
- **Astro-Hanが「MCP・hooksはtool-agnostic skillの範囲外、agent harnessの仕事」をDesign Boundariesで明言** → MCP不採用決定の独立収束の追証
- ivankuznetsovはskill→QMD MCPツール呼び出しの併用で実運用成功 → 「デフォルト不採用・オプション追加可」の拡張パス実証
- 大規模実装は「検証・決定的実行はコード（scripts/CLI）、手順はskill」を共通採用、全6実装のが共通のスキーマ外部化（wiki-schema.md）は人間編集とskill手順の分離に有効
- 残課題: lucasastorian/llmwiki（808★・MCP-native）とPratiyush/llm-wiki（229★・16 lint規則コード化）を別途分析候補に追加

(touched 12 pages: 7 new [sources×6 + リポジトリ分析 SKILL併用6事例] + 3 existing updated [AGENTS.md+SKILL.md二層設計, 操作層, MCP不採用とAGENTS.md+SKILL.md二層採用の根拠] + index/log + raw/manifest.md)

## [2026-08-14] file-back | SKILL併用6事例はライト分析で完了と記録

「深掘り分析必要そう？」の問いに対し、不要判断（microsoft-llmwikiのclone実測は設計決定の直接参照点だったが、6事例は既に二層採用決定を支持するデータ点で設計判断は抽出済み。[[事前にやろうとしない運用哲学]]に整合）。深掘りのトリガー（①テンプレートSKILL.md執筆時 ②claim争われた時 ③MCP-native実装がMCP指針の参照点になる時）を付して研究課題ページの「既存の実装との差別化」TODOに記録。
(touched 2 pages: 1 existing updated [このWikiの目的と研究課題] + log)

## [2026-08-14] file-back | AGENTS.mdとSKILL.mdの分担基準

人間との設計議論をfile-back。常時行動（queryの作法・file-back提案・lint発動ポリシー）はAGENTS.md、トリガー操作（ingest）はSKILL.md、機械チェックはscripts/の3分解。opencode仕様（[[2026-08-14 opencode Agent Skills仕様]]、raw/にアーカイブ+manifest追記）からskillロードはagentの自律判断＝LLMの想起依存と判明し、常時行動をskillに置くと信頼性が落ちる根拠に。トリガー表・保険サマリは不要（2025-12-18オープン標準化で非対応環境消滅）、明示パス参照1行のみ残す。 (touched 6 pages: 1 new source + 3 existing updated + index/log)

## [2026-08-14] adopt | v0.1スコープ決定（二層構成・対象範囲・規範のみ原則）

「そろそろtemplateを作れるだけの議論が整ったか」のsubagent相談2往復（外部コンサル2往復）の結果を決定として記録。結論: 議論はv0.1作成水準に達している。事前決定3点:

1. **v0.1は二層構成（skill同梱）で作る。単層自己完結案は撤回** — 単層の根拠だった「配布管理コスト」はGitHub Template Repository（別repo前提）時代の論点で、コピペ方式では消滅。分担基準（skill必須同梱・保険サマリ不要）は配布スケッチより後発決定（log.md順で確認）。二層は最もエビデンスの強い構成要素（AMME実証・jackwener独立収束・6事例全件）で、M2検証の一回性から後回しにできない
2. **claims対応表の骨組み作成**（[[claims対応表]]）— 9 claims × 2軸（記述的検証×規範的决定）の追跡器。確信度タグとしてv0.1執筆の迷いを消す
3. **対象範囲: ビジネス/チーム系以外** — 個人・研究・読書・プロジェクト（開発）系が実証経路（パイロット6件中5件+grasp）。プロジェクト系固有要素（コードrepo・attribution・Qバックログ）は構造の外の追加物で留保不要。ビジネス/チーム系のみvariant guide（実証なし）。スコープ限定はREADMEに明示（暗黙の限定はサイレント離脱を生む）

**執筆原則: templateは規範のみ** — 「こうする」という指示だけを書き、検証状態・エビデンス・根拠・動機は一切書かない（「動機不記載」の一般化）。実証されているかは研究wikiの領分であり、templateを使う側のwikiにとってはどうでもいい。

(touched 5 pages: 1 new [claims対応表] + 2 existing updated [配布形式の決定とテンプレートの動機, このWikiの目的と研究課題] + index/log)

## [2026-08-14] adopt | 検証方針改訂 — determinism撤回・育成評価へ

人間の指摘でQAゲートを改訂。「Stage 1: 同一モデル×2回の決定性」は撤回（再現性は目的ではない。揺れ対策の狙いは「いまいちな方向に進まない」方向付けであり、効果はbootstrap時点で測れず育ったwikiでしか評価できない）。新方針: 立ち上げスモークはM2 wikiが兼ねる（バグは立ち上げ時に自明）、主たる検証は「templateで外部wikiを立ち上げ育て、ある程度大きくなったらこのrepoが読んで評価」— 既存のGitHubリポジトリ分析方法論を適用し、結果をv0.2へフィードバック。confoundは外部リポジトリ分析のリスクと罠のフレームで扱う。旧Stage 0/1/2・構造diff・log形式一致は廃止。
(touched 2 pages: 2 existing updated [配布形式の決定とテンプレートの動機, このWikiの目的と研究課題] + log)

## [2026-08-14] feat | template/ v0.1実装

M1達成。事前決定（v0.1スコープ決定）を実装に落とした。

人間の設計指摘2件を反映:
- **必須/任意の2分類**: concepts/ + sources/ は必須、entities/ + analyses/ は任意（rename・削除可。analyses相当はsynthesis/decisions等の名前が存在）。templateには4分類同梱、AGENTS.md+READMEに任意性を明記
- **skillは操作別分割**: llm-wiki-ingest / llm-wiki-lint の2つ（6事例の操作別分割が多数派）。query/file-backは常時行動としてAGENTS.mdに残留（分担基準維持）。不要なskillはユーザーが削除可=Optionality
- **starter kit原則**: templateはstarter kitであり改変は前提・推奨。継承すべきは設計思想（3層・raw/不変・indexカタログ・file-back習慣）のみ。改変はdriftではなく適応（git履歴で戻せる）。README+AGENTS.mdに宣言を明記

実装ファイル（15ファイル）: AGENTS.md 4.8KB（9セクション）/ README.md（コピー手順・最初の30分・設計思想・スコープ宣言・改変自由宣言）/ scripts/lint.sh（研究repo版からraw検証2種を除去し一般化。赤リンク参照数分類は維持）/ skills×2（スタンドアロン可読）/ raw/manifest.md / wiki骨格（index・log・overview + 4分類.gitkeep）

スモークテスト: templateを /tmp にコピーしlint.sh実行 → 空骨格でクリーン。検証方針（2026-08-14改訂）に従い、正式な検証はM2（templateで育てた外部wikiをこのrepoが読んで評価）。

(touched 3 pages: 2 existing updated [配布形式の決定とテンプレートの動機, claims対応表] + template/ 15ファイル新規 + log)

## [2026-08-14] file-back | ingestとfile-backの反映方法の同型性

query: 「ingestとfile-backはrawから抽出かログから抽出かの違いで、反映方法は同じでは？」の検証をsubagent相談2往復で実施。結論: 設計思想レベルで正しい（gist L13/L39: 複利は同型、nishio L240定義+L222実践=新規+既存更新の複数ページ編み込み）。本当の違いはソースの性質・義務性・grounding契約・動機の4点のみ。頻度制御=非対称維持・実行深さ=軽同型の2軸分解を採用。template/AGENTS.mdのFile-back節に実行契約の欠損を実地確認（研究wikiのstep5よりさらに欠損）。analyses/新規 + concepts/QueryとFile-back.mdに注記（「このログ」=会話ログ）+ 当wiki実装の更新 + index/log更新
(touched 3 pages: 1 new [ingestとfile-backの反映方法の同型性] + 1 existing updated [QueryとFile-back] + index/log)

## [2026-08-14] refactor(agents) | file-backに実行契約を追加

研究wiki AGENTS.md Query step5とtemplate/AGENTS.md File-back節に「既存ページへのwikilink・明らかに影響を受けるページの更新・矛盾の明示・index/log更新」を追加（ingestの実行契約の軽量版。頻度制御の非対称は維持。フィルタ規則は追加せず人間ゲートに委任）
(touched 2 files: AGENTS.md + template/AGENTS.md + log)

## [2026-08-14] refactor | template v0.1レビュー反映（README移動・メタ文言削除・frontmatter委譲）

人間のtemplateレビュー指摘4点を反映:

1. **template/README.md廃止** — コピー先の既存README.mdと衝突するため。コピー手順・最初の30分・設計思想・スコープ宣言は配布側repoのroot README.mdに移動（root READMEの陳腐化修正も兼ねる: 「raw/は1件のみ」等の乖離解消）
2. **バージョン番号を全部削除** — templateに自己言及メタ文言を置かない。配布形式ページの「templateにバージョン+日付の1行記載」も撤回（改変される前提なら番号は無意味）。migration noteは配布側READMEのみ
3. **AGENTS.mdから出所・git履歴の言及を削除** — 「このwikiはStarter Kit（v0.1）からコピー」「改変はgitの履歴に残るので気軽に試せる」を除去し、冒頭の設計思想継承+改変自由の2行に統合
4. **frontmatter形式はingest skillに委譲** — file-backは既存wikiページを形式例として参照するため、最初のページ生成に使うingest skillに書くだけで足りる（AGENTS.mdの機械要件は引用の流れ・index行・log行・赤リンク許容のポリシーのみに縮小）。index行・log行はingest/file-back/lintの交差点のためAGENTS.mdに残留（分担基準の交差点ルール）

(touched 4 pages: 3 existing updated [配布形式の決定とテンプレートの動機, claims対応表, overview] + README.md刷新 + template/ 5ファイル修正 + log)

## [2026-08-14] refactor | template調整（manifest廃止・file-back拡張・PDF方針1行）

人間の事前レビュー指摘5点への対応。M2着手前の軽微調整:

1. **raw/manifest.md廃止** — 研究repoのmanifestは「raw/*がgitignoreされる」前提の存在記録だった（例外構成の実証例）。templateはraw/追跡デフォルトなのでgitが一覧・履歴を提供し、出典URLもsourcesページfrontmatter（source_url:）で記録済み → 重複メンテ作業なので削除。README・ingest skill・treeスケッチも修正
2. **file-backを広義化** — トリガーを「Query回答後」から「Query回答後や作業（実装・議論・調査）中の知見の後」に一般化（nishioのプロジェクト目的Wiki「実装中に発覚したことを書く」がエビデンス）
3. **PDF等の非テキストingest** — ingest skillの注意に1行追加: 「まずテキスト抽出で読む。図表が重要と判断したページのみ、当該ページと前後数ページを画像化して視覚モデルで読む」。詳細手順（references/化）は初回実遭遇時に書く（事前にやろうとしない）
4. **言語（英語化）は現状維持で記録のみ** — AGENTS.mdは人間と共進化するファイルで、wiki本文が日本語なら指示も日本語で一貫が整合的。英語化は国際配布（M3）時の選択肢
5. **AGENTS.md肥大化は既存知見で解決済みと確認** — BDL 15.8KBの原因はドメイン知識（skillで吸収不可）、解決はvanillaflava Cパターン（外部スキーマファイル分離、ver.2採用検討）。v0.1はvariant guide候補に維持

(touched 3 pages: 2 existing updated [配布形式の決定とテンプレートの動機, README.md] + template/ 4ファイル修正 + log)

## [2026-08-14] file-back | overviewの役割

query: 「overview.mdの役割は？Karpathyの原型にはなかったのでは」→ 検証結果: 原型（gist）の特殊ファイルはindex/logのみで、overviewは本wikiの初期コミットでの独自発明。ただし機能（人間向けの入門の1枚）はnishio実測12.6%・vanillaflava Home/Overviewに元ネタあり。人間向けの入口ページとして位置づけ、concepts/新規作成。index/log更新のほか、理解のボトルネック・このWikiの目的と研究課題にリンク追加
(touched 3 pages: 1 new [overviewの役割] + 2 existing updated [理解のボトルネック, このWikiの目的と研究課題] + index/log)

## [2026-08-14] file-back | templateに書き換え原則とconcepts atomicを反映

query: 「conceptsはatomicに保ち、追記ではなくページそのものを書き換える」話の所在確認 → raw源を検証し2話の隣接を特定（villagepump L253-260: concepts/強く簡潔（atomic）/リンクハブの簡潔さポリシー + L244: nishio「source of truthがあると追記追記になってしまう」）。[[Wikiはワークショップ]]・[[fact-wiki-separation]]にfile-back済みだったため新規ページなし。これをtemplate v0.1に反映（人間の承認済み・A+B+C全部）:

1. **A: template/AGENTS.md冒頭** — 設計思想リストに「追記ではなく書き換える・conceptsはatomic」を追加
2. **B: template/AGENTS.md執筆の機械要件** — 「wiki/のページは追記ではなく書き換えで更新（raw/がsource of truthなので書き換え・削除は自由）」「concepts/はatomicに保つ（肥大化したら株分け提案）」「ページタイプ別簡潔さの目安（concepts強く簡潔/entities簡潔/sources中程度/analyses長め可）」の3行
3. **C: ingest SKILL.md手順4** — 「追記ではなく既存記述と新ソースを統合して書き直す」を明示

整合のため設計思想リストを3箇所同時更新: root README.md（設計思想セクションに2項目追加）+ claims対応表starter kit原則 + 配布形式の決定とテンプレートの動機
(touched 3 pages: 2 existing updated [claims対応表, 配布形式の決定とテンプレートの動機] + README.md + template/ 2ファイル修正 + log)

## [2026-08-14] file-back | 書き換え原則の適用外

query: 「統合した書き換えではなく追記が適しているパターンは？」→ 判別軸は状態vs出来事。概念（状態）は書き換え、時系列の蓄積（出来事）は追記。具体例: log.md・日記（[[IndexとLog]]・[[日記とLLM Wikiの併用]]）、履歴が価値のページ（nishio実Wikiの## Updates追記、[[リポジトリ分析 llm-wiki-about-nishio]]）、人間の手が入った領域。注釈: 追記も永続せず蓄積の後に整理（書き換え）が来る（villagepump L226の1日単位の切り取り）。[[fact-wiki-separation]]に「書き換え原則の適用外」節として追記
(touched 2 pages: 1 existing updated [fact-wiki-separation] + index/log)

## [2026-08-14] file-back | index.md存廃の設計判断

query: 「index.mdは本当に必要か？Cosenseの思想ではindexは筋悪に見える。肥大化のデメリット vs 廃止のデメリットはどちらが大きいか？」→ subagent相談2往復で検証。結論: **index必須維持**（廃止のデメリットが大きい）。Cosense批判の分解: 大きなリンク論は適用範囲外（indexはwikilinkグラフ外）、本質はプラットフォーム非対称性、真の核心は「明示的登録作業」への違和感。代替4案（ls/検索/タグ/グラフ）は部分地図に過ぎず、組み合わせは分散した非決定的indexに退化。肥大化は可視・有界・出口あり（カテゴリ分割/1/8圧縮/株分け）、廃止は不可視・サイレントなrecall低下。推奨3段階（未実装）: ①lintにstale-entries追加 ②AGENTS.mdに「indexはキャッシュ」宣言 ③生成型indexをvariant提示。analyses/新規作成、IndexとLog・LLM Wikiのスケーラビリティにリンク追加
(touched 3 pages: 1 new [index.md存廃の設計判断] + 2 existing updated [IndexとLog, LLM Wikiのスケーラビリティ] + index/log)

## [2026-08-14] feat | index.md存廃の結論をtemplate v0.1に反映

「index.md存廃の設計判断」の3段階アクションを実装（人間の承認済み）:

1. **stale-entries lint追加** — `scripts/lint.sh`・`template/scripts/lint.sh`に「indexエントリ→実在ファイル」チェックを追加（URLエンコード%20デコード対応。ヘッダ例示行は除外）。負荷テスト: 実在しないエントリをSTALE検出→復元で0件を確認
2. **「indexはキャッシュ」宣言** — `template/AGENTS.md`・本wiki `AGENTS.md`の執筆の機械要件に「index.mdはページから導出可能なビューのキャッシュ。陳腐化・欠損時はページ冒頭を読んで再生成してよい（lintが検証）」を追加。lint手順の機械チェック一覧にもstaleを追記（本wiki AGENTS.md + template lint SKILL.md）
3. **生成型index variant** — `template/VARIANTS.md`を新規作成（frontmatter要約+生成スクリプト方式とトレードオフ）。README.md「改変は自由」にVARIANTS.mdへの言及追加

(touched 2 pages: 1 existing updated [index.md存廃の設計判断] + template/ 6ファイル修正 [AGENTS.md, scripts/lint.sh, .agents/skills/llm-wiki-lint/SKILL.md, VARIANTS.md(新規)] + 本wiki AGENTS.md + scripts/lint.sh + README.md + log)

## [2026-08-14] refactor | VARIANTS.md撤回（改変事例集は不要）

前エントリで作成した `template/VARIANTS.md`（生成型indexの改変事例集）を削除し、READMEの言及もrevert。理由（人間の判断）: 「改変は自由（starter kit）」宣言がある以上、**改変の仕方は各wikiのagentが自分で考えればよく、改変事例集を配布する必要はない**。生成型indexのトレードオフ分析は[[index.md存廃の設計判断]]の検証メモに残存。1・2（stale-entries・「indexはキャッシュ」宣言）は有効のまま
(touched 2 pages: 1 existing updated [index.md存廃の設計判断] + template/VARIANTS.md削除 + README.md revert + log)

## [2026-08-14] refactor | lint.shをskillディレクトリ内へ移動（記録済み決定の撤回）

query: 「templateにscripts/lint.shがあるけど、.agents/skills/llm-wiki-lint/に移していいのでは？rootに置く意味が薄い」→ 記録済み決定（2026-08-14 adopt: 「lint.shはskill内に移さない」）の撤回議論を経て、**本wiki + template 両方に自己適用**（人間が「template + root自己適用」を選択）。

- **撤回の根拠**: 旧決定の理由「skill非ロード環境から到達不能」はauto-discoveryとfile-reachabilityの混同。同一決定内の「明示パス参照が主契約」と矛盾——AGENTS.mdがパスを明示すれば、スクリプトはskillロードの有無と無関係にファイルとして実行可能
- **新配置の利点**: ①手順（SKILL.md）と決定スクリプトの凝集性（lint.shの出力解釈はSKILL.mdに定義されている） ②root `scripts/`名前空間の解放（既存コードrepoに埋め込む場合のdev用スクリプトとの衝突・`scripts/lint.sh`の曖昧さを回避） ③skill単位の移植性
- **6事例との関係**: 「検証・決定的実行はコード」の分担原則は維持（配置は規定しない）。6事例のroot `scripts/`配置は記述的な観察であり規範ではない
- 実装: 本wiki + template のlint.shを `.agents/skills/llm-wiki-lint/scripts/` へ移動（自己相対パスを `../../../wiki` に修正）、本wiki AGENTS.mdのLintセクションをスキル委譲に書き換え（手順は `.agents/skills/llm-wiki-lint/SKILL.md` 新規に移管。root初のskill）、template lint SKILL.mdのパス参照を更新
- 自己適用実験の部分着手: lint操作のskill化（[[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]残課題TODOに記録。ingest等の他操作は未実施）

(touched 8 pages: 7 existing updated [MCP不採用とAGENTS.md+SKILL.md二層採用の根拠, 配布形式の決定とテンプレートの動機, このWikiの目的と研究課題, Lint, AGENTS.md+SKILL.md二層設計, リポジトリ分析 SKILL併用6事例, index.md存廃の設計判断] + log + 非wiki [本wiki AGENTS.md, .agents/skills/llm-wiki-lint/SKILL.md 新規, lint.sh×2移動, template lint SKILL.md])

## [2026-09-03] observation | template instantiateのfrontmatter沈黙

`~/git/elastic-wave-analyzer-wiki`（template v0.1 で instantiate）を確認したところ、frontmatter が `sources/*.md`（2ファイル）にしか付いていなかった。concepts（17）・entities（2）・analyses（1）・index/overview/log は全て frontmatter なし。subagent 相談の結果:

- 挙動は template + ingest SKILL.md の明示的仕様に忠実（`raw:` は sources のみ必須）。concepts/entities/analyses の frontmatter は template AGENTS.md で完全に沈黙
- lint も frontmatter を検査しない＝「書いても書かなくてもよい」領域
- ユーザーには「意図してない結果」に見え、沈黙は無自覚に発生している
- 研究wiki AGENTS.md には「frontmatter は任意」と明記、template には不在 → 二層間のポリシー不一致

1. `template/AGENTS.md` 執筆の機械要件に「frontmatter は任意（sources 以外）。書く場合はページ種別に応じて `tags:` / `dates:` / `status:` / `sources:` 等のメタ情報を付加してよい。書かなくても wiki は機能する」を追加。沈黙を「意図された沈黙」に変える最小介入
2. AMME-2026S-report（パイロット3、100ページ・frontmatter 不使用）と独立した2例目の「frontmatter 最小運用」事例として記録

教訓: template の沈黙は実装上は最小哲学と整合するが、instantiate 側が「concept にもメタ情報が載る」挙動を期待すると意図の不一致になる。沈黙は書かないことが正解ではなく、**「書かなくてよい」を1行で宣言する**ことが正解。

## [2026-09-03] refactor | LLM Wiki main value = knowledge network の明文化

ユーザーの「knowledge graph の側面のほうが大事に思える」指摘を出発点に、subagent と深く相談。根底的な発見:

1. **「raw/ が唯一の source」は gist に書かれていない派生解釈** — Karpathy は raw/ を source of truth として定義するが、**価値の中心として 3 回繰り返される主張（compounding artifact / cross-references / synthesis）に raw/ への言及は一度もない**。file-back も明示的に 2 つ目の source として位置付け（gist line 39）
2. **nishio の raw/ への態度は 3 段階で変遷**: 厳格視 → 階層化・分散化 → 「再生成可能なら gitignore 可」。**捨てたのではなく役割を 2 種類に分けた**（スナップショット型/ライブ型）
3. **LLM Wiki の main value = knowledge network** — Karpathy/nishio/全パイロット実装/ユーザーの直感の全てが支持。raw/ SSOT は補助装置（4 機能: 検証可能性・作文リスク防衛・ライセンス・LLM 範囲境界）

反映:

- 新規ページ 2 件: `analyses/raw SSOT原則への根本検証.md`（605行、根本検証の包括的議論）+ `concepts/LLM Wikiのmain value.md`（統合的結論のサマリ）
- 既存ページ 3 件更新: [[3層アーキテクチャ]] に「価値の中心は knowledge network」を明記・[[rawディレクトリの取り扱い]] に「補助装置」補遺セクション追加・[[LLM Wikiの作文リスク]] に「主要防御は sources frontmatter」を明文化
- [[claims対応表]] に新規 claim#10 追加（文種②お決まり経路）。既存 claim#1/#6/#8 の規範的決定欄に補助装置視点を追記
- template への反映は保留（v0.1 はほぼ妥当、v0.2 への minor 反映で足りる）

教訓: 過剰解釈（raw/ SSOT = main value）の解消は、本質（knowledge network = main value）の明文化と同義。 template 設計にとって重要な方針転換であり、ver.2 以降の claims に反映する価値がある。 M2（template で育てた外部 wiki をこの repo が読んで評価）で事後検証する。

(touched 6 pages: 2 new [raw SSOT原則への根本検証, LLM Wikiのmain value] + 4 existing updated [3層アーキテクチャ, rawディレクトリの取り扱い, LLM Wikiの作文リスク, claims対応表] + index/log)
