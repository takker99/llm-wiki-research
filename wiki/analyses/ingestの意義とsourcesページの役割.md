---
status: hypothesis
date: 2026-10-23
tags: [template-design, ingest, llm-wiki-pattern]
sources:
  - "[[2026-08-11 Karpathy LLM Wiki Gist]]"
  - "[[LLM Wiki実装のingest形式と運用の比較]]"
  - "[[自作wiki群の構成変異と規約の流通]]"
  - "[[Hermes Agent llm-wiki skillとの比較]]"
  - "[[2026-08-14 SKILL併用LLM Wiki vanillaflava (github)]]"
  - "[[事前にやろうとしない運用哲学]]"
---

# ingestの意義とsourcesページの役割

query: 「HEAD commitで調べたllm wikiは、karpathyの設計思想にそったingestになっているのか？ingestの本質が忘れられていることはないか？そもそもingestの意義は何だったのか？sourcesページの意義が全然わからん」

本ページはquery回答のfile-back。[[LLM Wiki実装のingest形式と運用の比較]]と[[自作wiki群の構成変異と規約の流通]]の2つのsurveyはingestの単位・出典ポインタ・運用実態の観察が焦点で、Karpathy gist原文のingest節への照合は行っていなかった。本ページでraw/karpathy-llm-wiki-gist.mdに戻って照合し直す。

## Karpathyのingest思想の3関節

ingest節の主張は次の3つに分解できる（本ページによる分解。3つの文は同一節内に順に現れる）。

1. **既存ネットワークへの統合** — "It reads it, extracts the key information, and integrates it into the existing wiki — updating entity pages, revising topic summaries, noting where new data contradicts old claims, strengthening or challenging the evolving synthesis"
2. **現状維持** — "The knowledge is compiled once and then *kept current*, not re-derived on every query"
3. **schemaへの明文化** — "It's up to you to develop the workflow that fits your style and document it in the schema for future sessions"

post-ingestのレビュー（"I read the summaries, check the updates, and guide the LLM on what to emphasize"）はKarpathy本人の選好として書かれ、batch ingestは同じ節で明示的に許容されている。つまりレビューループは3関節の外側にある。

## 照合: 2survey × 3関節

### ①統合: 忘れられておらず、むしろ精緻化された

Karpathyが規定しなかった「ingestの単位」が入力のトポロジーで分岐する実測として確定し（1文書・トピック・成果物・コーパス・セッション）、「1ソースが10–15ページ」がwiki種類依存の期待値であることが訂正された（survey 1）。既存ページへの波及は下流wikiでも観察されている（txaで9–16ページ、SP1のre-ingestで新規1・更新16ページ）。surveyの共通する失敗パターン群に「孤立した要約の集合」は現れない。[[ingestにおける編み込みの実際]]の教訓「新規作成だけでは孤立した要約の集合になる」が下流で再発した兆候は観察されていない。

### ②kept current: 検出はKarpathyが先行定義し、修復が未制度化

compile onceの半分は全wikiに普及した。kept currentの半分について、Karpathy自身は**検出側をLintに先行定義している**: "Look for: contradictions between pages, stale claims that newer sources have superseded, orphan pages with no inbound links…"（raw/karpathy-llm-wiki-gist.mdのLint節）。Karpathyの設計は「検出はLintの仕事、修復手順は書かない」であり、修復の制度化は実装群に丸投げされている。本テンプレートのlint機械検査にstale-claims（新ソースに上書きされた主張）項目がなく、検出側から未実装である。

修復（re-ingest）の実態:

- re-ingestは「どのingest SKILLにも手順がない」。古い要約をどう捨てるか、`accessed`を更新するか、commit pinを進めるかが未定義（survey 1）
- wingsのcommit pinは実HEADに追随していない
- PGEの年度raw差し替えはtemplateの不変性例外の未定義域にある（survey 2）
- SP1では`re-ingest`という語彙だけがlogに先出しし、手順の定義が来ていない（survey 2）

一方で、re-ingestを名指す実装は2件ある。

- [[Hermes Agent llm-wiki skillとの比較]]: rawのsha256を保存し、re-ingest時にdrift検出する。調査範囲で唯一の機械検出実装
- [[2026-08-14 SKILL併用LLM Wiki vanillaflava (github)]]: raw/→ingested/移動の状態管理で冪等な再ingest（「再ingestしても害なし」）。`reliability:`の低いソースに強いソースを入れて再ingestすると`## Pending Review`節が消える

限定条件が1つある。re-ingestが要るのは**rawが変異するwikiだけ**である（年度PDFの差し替え、コードpinの進行、コーパスの更新）。raw不変＋時系列append型のwikiでは、stalenessはappend構造に吸収される。したがって「どのSKILLにもre-ingestがない」は「不足」と「入力特性が生む負荷の偏り」の両方を含む観察であり、survey 1の系統分類でtxaが「鮮度劣化が静か」と評価されているのは、インバウンド型wikiでこの劣化が静かに進むことの指摘である。

nishioはre-ingestという語彙を持たない（raw/と勉強会原文のgrepで出てこない）。しかしkept current問題に対して、名指しなしの4戦略を持つ。

1. 時系列の重ね書き — 変化する値は古いページを改めず新しい時点をappend（猫wiki・家計wiki型）
2. 発見駆動の一括修正 — ingest検証を毎回しない代わりに「間違いに気づいたら一括修正」（[[事前にやろうとしない運用哲学]]）。KarpathyのLint検出とほぼ同型の「使用時に発見 → まとめて修復」
3. 作り直し — 壊れたwikiを直さず、rawから新wikiを作る（[[株分け（kabuwake）]]のraw-source方式）
4. 深化型の再ingest — Deep Researchレポートをingest後、参照先論文を取得して再ingestする2段構え（[[ChatGPT ProとLLM Wikiの併用]]）。re-ingestを「再現」でなく「拡張」の文脈で使う

「LLMによるcost inversion」の帰結として、定型的なre-ingest手順を候補から外したと読める。

Karpathyの複利（[[永続Wikiと複利効果]]）は「編み込み × kept current」の積で成立する。検出・修復ともに制度化されていないままでは複利効果の半滅だが、使用時発見戦略が機能しているwikiでは損失は緩い。

### ③schemaへの明文化: 実質的に失敗している

Karpathyの契約は「選んだスタイルをschemaに書け」である。しかしsurveyが示すのは、schemaが選択の反映から化石へ転じる変質である。

- template自身がAGENTS.md・ingest SKILL・lint SKILL・lint.shの4箇所で出典規約が一致しない（survey 1）
- wingsのSKILLはprovenance検査を約束するがscriptは未実装。microsoftのREADMEは矛盾の記録をうたうがlintに矛盾カテゴリがない（survey 1）
- information-seekingはAGENTS.mdだけを緩めてskillを同期せず、22/23をURLのみで運用する（survey 1）
- 家族wiki間の規約のコピー差分が蓄積し、家族内の進化はtemplate配布物へ届かない（survey 2）

### レビューループ: 消滅ではなく記録の消失

「3–5要点を議論」はbatch運用で実行不能になり、人間の関与は選択と決定に移った（survey 1）。これはKarpathy自身がbatchを許容しているので思想違背ではない。ただし「要約を読み、何を強調するかガイドする」（[[Post-ingestレビューループ]]）の機能は消えうる。information-seekingの一括再ingest（14 sources）は人間の関与の痕跡をlogに残していない。代わりに人間の判断はrawの配置・用語の決定・成果物の採否・次アクションとして現れる。つまりレビューは前段的照合から後段的判断への据え替えであり、消えた場所に残っている。

## 本質は忘れられていない。半分が欠けている

wiki内でのingestの本質の定義は「孤立した要約でなく既存ネットワークに織り込む」ことである（[[Ingest]]）。

surveyの実測では、長期運用の主経路がingestの外に移っている。txaはanalysis 60・file-back 39・edit 36・fix 33・ingest 30、template rootはfile-back 27・ingest 9で2026-08-14以降ingest 0回（survey 1）。これは本質が忘れたのではなく、**編み込みという本質がingestという名前から脱退してfile-backとanalysisに移住した**と読むのが正しい。[[ingestとfile-backの反映方法の同型性]]は両者が同じ編み込み操作だと結論している。

忘れかけているのは編み込み側ではなく②で述べた現状維持側。内訳は、検出（KarpathyがLintに先行定義したが本wikiのlint機械検査にstale-claims項目がない）と修復（re-ingest手順）の両方が実装されていないこと。ただしre-ingestの必要性はrawが変異するwikiに偏る。編み込みの忘却が将来観測されるなら、徴候は孤立要約の増加である。

## ingestの意義

Karpathyの出発点はRAGとの対比にある。RAGは「毎回ゼロから知識を再発見する。何も蓄積しない」。wikiは「一度コンパイルし、維持する」。ingestはこのコンパイルを起こす入口である。

wiki内の定式を重ねると、ingestの役割は次の3つで記述できる。

- 1ソース → 複数concept = networkの種まき（claim#6の再解釈。[[LLM Wikiのmain value]]）
- 「100ページ目をingestする時、AIは既存の99ページと結びつく箇所を探す。要約を100回別々に作っても起きない現象」（[[LLM Wikiは要約の改良版ではない]]）
- 情報を捨てずに認知負荷を下げる層を作る操作（[[注意の足場]]）

本ページの定式: **ingestの意義は「後に来る全ての問いとソースの結合確率を高める初期投資」であり、要約を作ることではない**。価値の本体はingestが触れた先に積もる。txaはsources 36に対しanalyses 128、template rootはsources 15に対しwiki 128ページ（survey 1）。ingestはfront-loadedな作業であり、種まき期が終わると主経路はfile-backに譲る。ingestの実行回数が減るのは崩壊ではなく、役割が果たされた後の正常な状態である。

## sourcesページの4仕事

「sourcesページの意義がわからん」という感覚は、観測事実と整合する。sourceページは実装によって4類型に割れており（要約＋引用台帳・成果物の台帳・コーパスの目録・実装済み決定。survey 1）、templateは「要約＋関連concept/entityへのリンク＋rawへのリンク」としか定義しておらず、「同じ『含意』の節が実装ごとに異なる仕事をしている」状態。1つに固定した理解がそもそも破綻している。

意義を分解するとsourcesページには4つの仕事がある。

1. **出典単位の主張の台帳** — conceptページは合成なので「どの主張がどのrawから来たか」を請け負う中間層。引用の流れ「raw → sourceページ → concept/entity」の結節点。frontmatterの`raw:`必須化は作文リスク防衛の大部分を占める（[[LLM Wikiのmain value]]）
2. **編み込みの照合台帳** — 「このソースが本wikiに何を変えたか」を記録する。既存ページとの照合の判定場（[[ingestにおける編み込みの実際]]）
3. **stalenessのハンドル** — rawが更新されたとき「どの要約が古くなったか」を特定する単位。re-ingestを制度化するならその対象リストは既存のsourcesページである
4. **人間レビューの接点** — "guide the LLM on what to emphasize"。batch運用では④が消え、①〜③の台帳役だけが残る

結論: sourcesページの意義はwikiの型（survey 1の4系統）によって①〜④の配分が変わる**可変役割**であり、単一の定義で説明しようとすると破綻する。survey 1の提法案にある`role:`軸とデフォルト骨格は、この可変役割を設計語として固定する試みである。

## テンプレートへの含意

- re-ingest制度化は、出典規約の一致とは独立の論点として切り出される根拠を持つ。survey 1の優先順位では「出典規約の一本化と規則・実装の一致テスト、次にre-ingestの定義」となっているが、②の照合はre-ingestの欠落をingest思想の半分の欠落として位置づける
- kept currentの検出はKarpathyがLintに割り当てている。template側から着手するなら手順（re-ingest）より先にlintのstale-claims検査項目を追加するのが筋がよい。pin drift・`accessed`陳腐化の機械検査はその次
- re-ingestの制度化の射程はrawが変異するwiki型（講義型・コードrepo一体型・コーパス型）に限定すべきで、raw不変＋append型wikiに手順を義務化すると規約が実態に合わなくなる
- re-ingestの対象は既存のsourcesページ（仕事3）である。sourcesページの骨格（`## 要点`・`## 含意`・`## 関連`）とre-ingestの手順は同時に設計すると整合する
- batch運用を続けるなら、人間の判断の痕跡の形式を決める必要がある。これはsurvey 1の「口頭知識のprovenanceがない」と同型の問題であり、`source: session`形式の必要性の根拠を強める

## 未解決

- [ ] kept currentの欠落をlintで検知できるか。Karpathyは検出をLintに割り当てているため、まずstale-claims（新ソースに上書きされた主張）検査項目をlintに足すかどうかが論点。pin driftや`accessed`の陳腐化の機械検査はその次で、survey 1の`--self-check`論点に接続する
- [ ] nishioの4戦略（重ね書き・一括修正・作り直し・深化型再ingest）をkept currentの選択肢としてvariant guideに記載するか
- [ ] sourcesページの4仕事のうちテンプレートに既定するのはどれか。`role:`で分けるかvariant guideに回すか、骨格との関係をどうするか
- [ ] 編み込み忘却の徴候（孤立要約の増加）をどう検知するか
- [ ] 3関節の分解自体は本ページの提案。Karpathyの他の言及や他実装との照合で反例があるか

## 関連

- [[Ingest]] — 3基本操作の1つ。本ページの照合対象の概念ページ
- [[LLM Wiki実装のingest形式と運用の比較]] — survey 1。ingest単位・4類型・4モード・運用実態の観察
- [[自作wiki群の構成変異と規約の流通]] — survey 2。構成原理・authority・規約流通・re-ingest語彙先行の観察
- [[2026-08-11 Karpathy LLM Wiki Gist]] — 照合の原文
- [[ingestにおける編み込みの実際]] — 編み込みの構成要素と波及の3層
- [[ingestとfile-backの反映方法の同型性]] — 編み込みの脱移先
- [[Post-ingestレビューループ]] — 3関節の外側の選好
- [[LLM Wikiのmain value]] — knowledge networkと補助装置の分解
- [[LLM Wikiは要約の改良版ではない]] — 99ページ結合の原典
- [[永続Wikiと複利効果]] — 複利 = 編み込み × kept current
- [[注意の足場]] — ingestが作る層構造
- [[Hermes Agent llm-wiki skillとの比較]] — rawのsha256保存とre-ingest時のdrift検出。re-ingestを名指す実装
- [[2026-08-14 SKILL併用LLM Wiki vanillaflava (github)]] — ingested/状態管理による冪等な再ingestと`reliability:`更新
- [[事前にやろうとしない運用哲学]] — 発見駆動の一括修正。kept currentのnishio流の解法
- [[株分け（kabuwake）]] — rawから作り直すkept current
