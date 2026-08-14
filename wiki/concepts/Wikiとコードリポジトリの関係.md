---
sources: "[[2026-08-14 Wikiとコードリポジトリの関係 (nishio)]]"
tags: [template-design, llm-wiki-pattern]
---

# Wikiとコードリポジトリの関係

LLM Wikiとソースコードのrepoの関係には2つのパターンがある: **同一repo型**（成果物とwikiが同じgit履歴を共有）と**別repo参照型**（コードは開発repoのまま、wiki repoは知識層だけを持ち`work/`などにcloneして参照）。nishioのcosenseでは後者（wiki-driven workflow）が実践されている。

## 2つのパターン

| | 同一repo型 | 別repo参照型（nishio） |
|---|---|---|
| 例 | grasp, BDL-2026S | kouchou-ai-developer-wiki, dd2030-wiki |
| コードのSSOT | wiki repo自身 | 開発repoのまま（wiki repoはclone・参照のみ） |
| git履歴 | 成果物とwikiが共有 | 分離（コードはwiki repoに入らない） |
| wikiの役割 | 成果物の一部にもなりうる（SSOT） | 純粋な知識層（why/what） |
| 典型シナリオ | 新規立ち上げ・wiki=実装SSOT | 既存repoへの後付け・公開範囲の分離 |
| 同期コスト | なし（同一履歴） | work/のclone・pull・staleness管理が必要 |
| Agentコンテキスト | 1 repoで完結 | 2 repoを跨ぐコンテキスト構築が必要 |
| 分離の容易さ | コピーで別repo化可能（株分け） | 移行理由はほぼ発生しない |

## 構造（別repo参照型）

```
work/  — ソースコードのリポジトリ（開発repoをclone）
raw/   — 過去の議事録・Slackログ
wiki/  — 両方から抽出されたより抽象度の高いwhy/what
```

ソースコードに書かれているのは具体的な実行のhow。whyやwhatは人間とのコミュニケーションデータ（Slack・GitHubのやりとり）にありがちで、議事録に転記されても流れ去る。wiki repoはコードとログの両方を参照し、why/what層を保存する。

## 特徴

- **量的観察**: コードをrawにcloneするケースでは「raw 1ページあたりwikiページ < 1」。コードは1ファイル=1概念ではないため、Cosense exportなどと違い、wikiページの生成効率が低い。むしろAgentic Retrievalの参照対象として扱われる（[[LLM Wikiの実運用データ]]）
- **読む主体の設計**: この型のwikiは「人間が読むためにAIが書いている」のではなく「人間も読める形でAIが自分の理解を書き留めている」。AIが読む想定
- **読む主体はrepo型を決めない**: 読む主体の設計（人間向け/AI向け）とrepo型は無関係。dd2030（人間が読むためにAIが書く）とkouchou-ai-developer-wiki（AIが読む想定）は読む主体が違うのに両方別repo型。graspはcoding agent向けだが同一repo型
- **目的軸とrepo型軸は直交**: 「研究目的 vs プロジェクト目的」（[[研究目的Wikiとプロジェクト目的Wiki]]）の軸と「同一repo vs 別repo」の軸は直交する。BDL-2026Sは「研究目的風の概念知識 + プロジェクト目的風の成果物管理」を同居させており、両軸を混ぜない方がよい
- **目的は記憶の外部化**: 隙間時間のOSS開発での「どうしてこうなってるんだっけ」を解決。実装中の発見は「今は対処しない、Wikiに書いといて」で保存される
- **成果物管理は従来のまま**: issue/PR/CIなど開発repoの仕事は変わらない。wiki repoは知識層だけを追加する

## 由来

- dd2030-wiki: 「リポジトリをrawの中にcloneして分析させた」が最初の事例（経緯のAgentic Retrieval）
- kouchou-ai-developer-wiki: 既存ソフトウェアの開発でも開発対象のコードをwikiの参照対象にする方式として発展。wiki-driven workflowとして解説公開

## テンプレート設計への含意

プロジェクト目的Wikiでは「コードをwiki repo内に持つか（同一repo型）、外部repoを参照するか（別repo参照型）」がディレクトリ構成の中心的な選択肢になる。ただしrepo型は目的（知識の蓄積 vs 成果物管理）では決まらない（grasp・BDL-2026Sが知識蓄積+同一repo、dd2030-wikiが成果物管理+別repoの反証例）。

選択は以下を順に考える:

1. **コードの有無**: 研究目的Wiki・個人知識Wikiはコードを持たない。repo型の問題は発生せず、「wiki単独repo」が自明のデフォルト（本節の適用対象外）
2. **生まれ方**: 新規立ち上げ → 同一repoがデフォルト（分離はニーズが明らかになった後、コピーで行う）。既存repoへの後付け（権限外・公開OSS・履歴汚染の回避）→ 別repo参照型
3. **知識の向き**: wikiが実装のSSOT（wiki→コード生成）→ 同一repoが実質必須。wikiが実装の解説・記憶の外部化（記述的）→ どちらでも可
4. **公開性**: コードとwikiの公開範囲が異なる場合 → 別repo参照型

テンプレートは両方の選択肢を許容し、デフォルトを同一repo型とする。別repo参照型はオプショナル構成とし、work/の運用規定を添付する。

## オプショナル構成: 別repo参照型のwork/

3層アーキテクチャとの整合の鍵は「raw/ = 管理内SSoT」と「work/ = 外部SSoTのミラー」の対比。どちらもwiki/から見て「読むだけで変更しない参照層」だが、不変性の根拠が異なる（raw/はアーカイブ、work/はclone）。

```
work/     — 開発repoのclone。読むだけで変更しない。更新は人間が git pull し、log.md に記録する
raw/      — 不変の原文（議事録・Slackログ等）。管理内SSoT
wiki/     — LLMが管理する構造化Markdownページ。work/ と raw/ の両方を参照してwhy/whatを抽出
AGENTS.md — 運用規則
```

- **位置づけ**: work/は外部SSoTのミラー。wiki/の事実が争われたら raw/ または work/ まで遡るが、work/ は取得時点のcommitに対して検証する
- **参照の記録**: work/ 内のコードを引用したsourcesページは `raw: work/<パス>` を必須とし、frontmatterに取得commitを記録する（`clone_date` / `commit`）。staleness対策の基本
- **gitignore**: work/ は gitignore に含める（再取得可能な派生物）
- **更新ループ**: 人間が `git pull` → log.md に「work/更新」を追記 → LLMが更新を検知し、影響範囲の再ingestを提案する
- **更新の非同期性**: コードが更新されてもwikiが古くてもよい（記述的知識は陳腐化耐性がある）。規定的知識（wikiがSSOT）をwork/側に持つ場合は同一repo型を選ぶべき

要点: stalenessを「防ぐ」のではなく「記録する」。取得commitの記録とlog.mdによる更新イベント通知があれば、wikiがどのコード状態に基づくかを常に追跡できる。

## 関連概念

- [[Wiki駆動開発]] — 構造・効果の詳細。本ページはrepo関係の対比に焦点
- [[研究目的Wikiとプロジェクト目的Wiki]] — プロジェクト目的Wikiの典型
- [[Coding Agentの歴史とLLM Wikiの位置づけ]] — 知識外部化の歴史的位置づけ
- [[LLM Wikiの実運用データ]] — raw 1ページあたりwikiページ数の量的データ
- [[dd2030-wiki]] — 先駆例
- [[注釈駆動Wiki]] — 同じくkabuwakeされたプロジェクト目的Wiki
