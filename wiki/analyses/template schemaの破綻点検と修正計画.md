---
summary: "templateのAGENTS/SKILL/lintをLLM Wiki・Cosense思想で点検。初回ingestデッドロック、raw必須とsource_url許容の衝突、未実装のlint検査列挙、write-onlyなtype必須、summary単一行前提の未明記など12件の修正計画と、rootの現行schema移行を記録（status: tentatively-adopted, 2026-11-17）"
status: tentatively-adopted
date: 2026-11-17
tags: [template-design, schema, lint, cosense, consultation]
sources: "[[テンプレート草案ver.1]]", "[[index.md存廃の設計判断]]", "[[Cosense Skillとgraspに学ぶQuery近傍読解とIngest書き込み設計]]", "[[raw SSOT原則への根本検証]]", "[[AGENTS.md+SKILL.md二層設計]]", "[[LLM Wiki実装のingest形式と運用の比較]]"
---

# template schemaの破綻点検と修正計画

`template/` の schema（AGENTS.md・2つの SKILL・scripts）に、LLM Wiki と Cosense の設計思想から見て明らかに矛盾する指示・初日から誤作動する指示・不要な指示が混じっていないかを点検した記録。相談先は agy の Gemini 4 Argon (High) で2往復。相談元Agentの仮見解12項目を検証させ、2往復目で BRE・rename・表セル・系譜・初期化・`type` の反論を突き合わせ、主要な指摘はコードと履歴で再確認した。

## 点検結果（重大度順）

| # | 指摘 | 対象 | 判定 |
|---|---|---|---|
| C1 | 初回ingestで概念ページ作成がデッドロック。「新規は2+ページ言及で作る」が「ingestソースの中心概念を切り出す」を塞ぎ、`sources/` が ORPHAN になる | `write/SKILL.md:25,60`、`AGENTS.md:55` | 修正（2+規則をオープンリンク昇格に限定し、ingestの中心概念を例外化） |
| C2 | sourcesの `raw/` 必須と `source_url:` 許容が矛盾。`lint.sh` も同じポインタ検査を二重実装 | `AGENTS.md:47-48`、`lint.sh:42-44,158-167` | 修正・統合（`raw:` か `source_url:` の1以上に統一、重複検査を削除） |
| C3 | lint SKILLが実装されていない機械検査（provenance・著者-年・analyses sources）を列挙。`raw/` 検査は `.md` 固定でPDFを素通りし、空白区切りの複数参照を1パスとして誤認 | `lint/SKILL.md:21`、`lint.sh:149` | 削除・修正（provenance lintは [[raw SSOT原則への根本検証]] で不採用済み） |
| C4 | 未参照の研究用スクリプトが template に混入。作者のローカルパス・`/tmp/opencode`・`gawk` 依存 | `template/.agents/scripts/diagnose-wiki.sh`、`number-dup-check.sh` | 削除（root側にのみ残す） |
| C5 | `entities/`・`analyses/` はrename可と宣言しながら、lintは4ディレクトリ名を固定。大小文字非区別の約束とも不一致 | `AGENTS.md:28-36,43`、`lint.sh:19-27,45,75` | 修正（全サブディレクトリ走査・大小文字非区別） |
| H1 | 下流wiki（txa/SP1）固有の文体・来歴規則が template SKILL に逆流（系譜・判別パターン、`p.XX` 基本化、表セル1リンク、transcript、年度別表、reproducibility manifest） | `write/SKILL.md:37,49,51-57,63-64,82`、`AGENTS.md:50,52`、`lint/SKILL.md:28` | 削除・層移動（系譜保持の一般原則1文だけ手順4に残す） |
| H2 | `type` はlintが存在だけ見て `--catalog` も消費せず、write SKILLは書き方を指示しない。SKILL通りに書くとlintで落ちる罠 | `AGENTS.md:49`、`lint.sh:40` | 削除（`summary` のみ必須に） |
| H3 | `summary` は単一行パーサなのに「1行で書く」が未明記。YAML例にも `summary:` がない | `AGENTS.md:49,53`、`write/SKILL.md:68-74`、`lint.sh:41` | 修正（1行を明記し、空・複数行をlintで検出） |
| M1 | 検索は通常時も全文検索を共走・0件時自動フォールバックするのに、AGENTSは「見つからない時は `--fulltext`」のまま | `AGENTS.md:74`、`search-pages.sh:20` | 修正（説明を実装に同期） |
| M2 | `summary` 定義の重複、`## 初期化` と `## よくあるパターン` がオペレーション節・SKILLと重複してドリフト | `AGENTS.md:49,53,57,60-65,91-96` | 圧縮（初期化は目的節に1文、パターンはQuery節へ1行統合） |
| M3 | `direct-read` の自己申告は逸脱観測用テレメトリで、配布templateには不要 | `AGENTS.md:75` | 削除（直接 `read` の例外許可だけ残す） |
| M4 | `raw/` へのアーカイブ条件が3箇所で食い違う。URLソースの扱いが曖昧 | `AGENTS.md:16,93`、`write/SKILL.md:14,68-80` | 修正（ingest時または人間の依頼で新規追加、URLは指示がなければ `source_url:`） |

## 2往復目で撤回・降格したもの

- **正規表現メタ文字・大小文字**: `grep` はBREなので `()` `+` はリテラル。Criticalから降格。ただし大小文字非区別の約束違反は残るため、lint側を修正する。
- **系譜・判別パターンの全削除**: 全削除だと訂正時の単純上書きで棄却仮説・旧値が消える。一般原則「旧→新の系譜と理由を残す」1文だけ手順4に残し、具体3項目は下流wikiへ移す。
- **初期化セクションの全削除**: 「初回は人間がpurposeを確定し、最初のソースを持ち込む」ゲートは有効。目的節の1文に圧縮して残す。
- **`summary` の1〜2文**: 文数はlintで検査せず、ソフトな粒度目安として残す。代わりに「1行」を機械検査する。

## templateとrootの分岐（2026-11-17 root移行）

点検中に、研究wiki自身（root）が現在の template を dogfooding していないことが分かった。rootは依然 `index.md` と「frontmatter任意」で、`write/SKILL.md:24` には「過去sourcesを時点要約として維持」という、実運用で要約更新漏れを起こした既知のバグ文言が残る。`AGENTS.md` の「このwiki自身の存続が最小スキーマの実証になる」という主張と現状がずれているため、rootを移行するか、旧schemaのforkとして維持するかを決めて [[log]] に残す必要があった。

**判断: rootを旧schemaのforkとして維持せず、現行template schemaへ移行する。** 研究wiki自身が仮説の実装であり続けることを優先した。2026-11-17の移行内容:

- `.agents/skills/llm-wiki-write`・`.agents/skills/llm-wiki-lint`・`.agents/scripts/read-page.sh`・`.agents/scripts/search-pages.sh` を `template/` の実装に同期した。root専用の研究スクリプト（`diagnose-wiki.sh`・`number-dup-check.sh`）はrootに残す
- `wiki/index.md` と `wiki/overview.md` を廃止し、全150ページのfrontmatter `summary:` を検索と `--catalog` の正本にした。summaryは旧index.mdの1行要約を移し、既存summaryがあるページは維持した
- `AGENTS.md` を現行schemaに合わせ、frontmatter summary必須・`raw:`/`source_url:` 統一・`direct-read`削除・Queryの `--catalog` 化を反映した。研究固有の目的・Review・Git規約は残した
- `index.md`・`overview.md` を参照していた運用上のリンクを更新した。廃止を議論した分析ページ内の歴史的記述は残す
- 移行後のlintはORPHAN 0・summary欠落0。残る `[[overview]]`/`[[index]]` のオープンリンクは歴史的記述のものだけ

## 実装順序

1. C1 + H2 + C2 + H3（初回ingestのロック解除、`type` 削除、`raw:`/`source_url:` 統一、`summary` 1行要件）
2. C3 + C5（未実装検査の削除、lintの走査統一・大小文字・`raw/` 正規表現）
3. C4 + H1 + M2 + M3（未参照script削除、下流固有規則の削除、AGENTS.md圧縮、`direct-read` 削除）
4. 再検証（lint単体テスト、SKILLとlint出力の照合、空wikiでの初回ingestシミュレーション）
5. root/template分岐の記録（2026-11-17にroot移行を実施）

## 実装（2026-11-17）

上記1〜4をsubagent分担で実装し、`/tmp/opencode` のfixtureで検証した。

- `template/AGENTS.md`: `type` 削除、summaryの「1行・1〜2文」化、`raw:`/`source_url:` の統一、`direct-read` 削除、初期化・よくあるパターンの圧縮、fulltext説明の同期
- `template/.agents/skills/llm-wiki-write/SKILL.md`: 初回ingestの中心概念を2+規則の例外に、系譜保持の一般原則1文を追加、下流固有規則・`p.XX`基本化・表セル1リンク・transcript・年度別表・reproducibility manifestを削除
- `template/.agents/skills/llm-wiki-lint/SKILL.md`: 未実装のprovenance/著者-年検査を削除、summaryの空・複数行検査を明記
- `template/.agents/skills/llm-wiki-lint/scripts/lint.sh`: 全サブディレクトリ走査、大小文字非区別、タイトルのメタ文字安全、summaryの空・複数行検出、raw参照の拡張子可変・空白誤認解消、sourcesポインタ検査の一本化、`find -exec` 化による空wikiのstdin待ち回避
- `template/.agents/scripts/`: 未参照の研究用スクリプト2本を削除

検証は、summary正常/空/複数行、raw PDFの参照切れと空白区切り、ディレクトリrename、大小文字・alias・anchor付きリンク、sources孤立、空wiki、1ソース・1概念の最小wikiと `--catalog` までPASS。

### 2回目レビューと追加修正

実装後にGemini 4 Argonへ再レビューを依頼し、以下を追加修正した。

- N1（回帰）: Markdown表の `[[Page\|Alias]]` がOrphan判定とread/searchのリンクグラフで解決されない。lintの正規表現に `\\` を戻し、read/searchで末尾の `\` を剥がす
- N3: `summary: # TODO`、空白のみ、インデント継続の複数行を検出できていなかった。awkで値と次行を検証し、search/readのクォート剥がしをシングルクォートにも対応
- N4: `[[#見出し]]` が `OPEN_LINK` として誤報される。アンカー先が空ならスキップ
- N5: 引用フローの `concept/entity` に `analysis` が漏れていた
- N2: 空白入りrawパスが検査対象外だった。クォートされた `"raw/..."` / `'raw/...'` を別途抽出し、空白入りパスも実在検査する

残課題は `[` を含むタイトル（既存制約）とmacOS実機未検証。

## 関連

- [[テンプレート草案ver.1]] — 検証対象のclaims
- [[index.md存廃の設計判断]] — frontmatter `summary:` 正本・`--catalog` への反転根拠
- [[Cosense Skillとgraspに学ぶQuery近傍読解とIngest書き込み設計]] — 近傍同梱・リンク選定・固定スタイルを増やさない原則
- [[raw SSOT原則への根本検証]] — provenance lint不採用の根拠
- [[AGENTS.md+SKILL.md二層設計]] — AGENTS.mdを薄く保つ分担基準
- [[LLM Wiki実装のingest形式と運用の比較]] — 規則とlintの不一致の先行観察
