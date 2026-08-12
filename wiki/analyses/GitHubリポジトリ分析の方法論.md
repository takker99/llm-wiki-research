---
status: tentatively-adopted
date: 2026-08-12
tags: [template-design, ingest, methodology, research-design, repos]
source: subagent-consultation (3 agents × 1 round)
sources: [[rawディレクトリの取り扱い]], [[テンプレート草案ver.1]], [[このWikiの目的と研究課題]]
---

# GitHubリポジトリ分析の方法論

実際にLLM Wikiを運用しているGitHubリポジトリを複数収集・分析し、
schema/formatの具体例とbest practice/bad practiceを抽出するための方法論。

subagent 3体との相談（2026-08-12）に基づく。

## 技術方式

### 発見層＋選択的アーカイブ（二層構造）

- **発見層**（`raw/` 外、例: `~/git/llm-wiki-samples/<repo>/`）: 分析対象repoを `git clone` した全ファイル。全文横断検索・パターン分析に使用
- **raw/（アーカイブ層）**: 実際に引用したファイルのみをコピー。`raw/<repo-name>/` に元の相対パスを保持
- clone丸ごとを `raw/` に入れるのは役割混在のため避ける

### 更新・再現性

- commit hash固定（`git clone` 後に `git checkout <hash>` で固定）。`git pull` は分析途中の参照先変動リスクがあるため禁止
- 追従する場合は再clone（別commit hashとして）＋新旧比較。wikiの進化観察として価値が高い
- ⚠ `llm-wiki-about-nishio` の「再生成可能だからgitignore」という理由付けは研究の再現性要件と整合しない。repo削除・force pushで再生成不能になるため

### manifest.md 拡張

現行のmanifest.md（Cosenseページ向け）に加え、GitHub repo向けのフィールドが必要:

- `repo_url`（clone元URL）
- `clone_date`
- `commit_hash`（フルSHA）
- `license`（SPDX identifier または "None"）
- `description`（なぜ分析対象にしたか）
- `copied_files`（raw/にコピーしたファイルリスト、または「発見層のみ」の注記）

manifest.mdが肥大化する場合はセクション分割または `raw/manifest-repos.md` に分離。

### 引用形式

sourcesページでの引用: `raw/<repo>/AGENTS.md@<commit-hash-short>:L42` 形式。
これによりcommit hash・ファイルパス・行番号が特定でき、研究の再現性が担保される。

## 研究デザイン

### 事前注目点

決めすぎない。ただし完全白紙は非効率なので、以下の緩いguiding questionsを持つ:

**構造（静的）**:
- AGENTS.mdの行数・構造・抽象度
- ディレクトリ構成のパターン（何分類か、命名規則）
- frontmatterの使い方（tags, dates, status等）
- wikilinkの密度と運用

**プロセス（動的）**:
- コミット履歴パターン（誰が・どの頻度で・何をトリガーに）
- 誤り訂正メカニズム（人間はどうやってwikiの誤りに気づくか）
- 放棄パターン（なぜ・どの時点で更新が止まるか）
- ツールチェーン（どのエージェント/IDEを使っているか）

**逸脱**:
- AGENTS.mdの規範とwiki/の実態の乖離（文書化バイアスの検出）
- テンプレートがどう適応され・破られ・書き換えられているか
- 何が捨てられ何が残ったか（git履歴の時系列変化）

### 分析方法

質的調査の **Template Analysis** 手法を採用:
1. a prioriテーマ = [[テンプレート草案ver.1]] の8 claims
2. パイロット（2〜3 repo）分析後にテーマ改訂
3. 拡大（〜10 repo）分析
4. 飽和チェック（新パターンが出現しなくなったら打ち切り）

### 設計空間マップ（v2より優先）

テンプレートを具体化する前に、分析のレンズとして使える設計次元マップを作る:

| 設計次元 | 両極 |
|---|---|
| 人間の関与度 | read-optional ↔ read-required |
| 構造の硬さ | 固定ディレクトリ ↔ 自由形式 |
| 規模想定 | 10ページ凍結 ↔ 1000ページ運用 |
| ソース管理 | raw/分離 ↔ 混在 |
| ingest頻度 | 監視付き1件ずつ ↔ バッチ一括 |
| エージェント設定 | 単一AGENTS.md ↔ マルチファイル（.claude/, skills/等）|

これは「答え」ではなく「問いの体系」であり、確証バイアスのリスクが低い。

## リスクと対策

→ 詳細は [[外部リポジトリ分析のリスクと罠]] に分離。

主なリスクカテゴリ:
- ライセンス・法的・倫理（派生物問題、ライセンス不在、同意の不在）
- 分析の質の罠（文書化バイアス、観測不能、初期条件バイアス、再帰問題、氷山問題、原因と結果の混同）
- プロジェクト管理（スコープクリープ、比較の指数的複雑性、technical debt、操作的定義の循環）
- 情報の劣化（陳腐化、git履歴喪失、メタデータ欠落、削除・非公開化）
- 見落としパターン（AGENTS.md非依存、マルチエージェント、CI/CD統合、ハイブリッド運用）

深刻度×検出難易度のリスクマトリクスは [[外部リポジトリ分析のリスクと罠]] を参照。

## 選定基準（未確定・要議論）

- [[テンプレート草案ver.1]] 準拠（AGENTS.md + raw/ + wiki/ の3層を持つ）
- nishio派生 / Karpathyパターン準拠 / 独立系 のバランス
- 成功例だけでなく失敗例（放棄・停滞）も含める
- 日本語圏 / 英語圏 のバランス

## 未解決

- [ ] 分析対象repoの選定基準の明文化
- [ ] 設計空間マップの正式ページ化
- [ ] 分析結果のwiki/構造化方針（repoごとsources？クロス比較analyses？）
- [ ] 再分析時のtechnical debt対策（既存ページの修正プロトコル）
- [ ] ライセンス非互換repoの扱い基準

## 関連

- [[rawディレクトリの取り扱い]] — 発見層＋選択的アーカイブの先行分析
- [[テンプレート草案ver.1]] — a prioriテーマとして使用する8 claims
- [[このWikiの目的と研究課題]] — 研究の完了定義との整合性確認
- [[LLM Wikiの実運用データ]] — nishioの25 Wikiデータ（主観的選定の補完）
- [[LLM Wikiの本質定義]] — 「LLM Wikiとは何か」の操作的定義の循環問題
