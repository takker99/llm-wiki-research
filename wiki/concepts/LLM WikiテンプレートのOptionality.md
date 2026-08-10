---
sources: [[2026-08-11 Karpathy LLM Wiki Gist]], "[[2026-08-11 KarpathyのLLM Wiki勉強会 (nishio)]]", "[[2026-08-11 AIを使った知識マネジメント (villagepump)]]"
tags: [template-design, llm-wiki-pattern]
---

# LLM WikiテンプレートのOptionality

Karpathy gistのメタ設計原則。パターン（抽象的なアイデア）と実装（具体的なディレクトリ構造・ページフォーマット・ツール）を明確に分離し、すべてを「オプショナルでモジュラー」と位置づける。

## Karpathyの定式

> "This document is intentionally abstract. It describes the idea, not a specific implementation. The exact directory structure, the schema conventions, the page formats, the tooling — all of that will depend on your domain, your preferences, and your LLM of choice. Everything mentioned above is optional and modular — pick what's useful, ignore what isn't."

## Optionalityの例

| 要素 | Optionalな理由 |
|---|---|
| 画像処理 | ソースがテキストのみなら不要 |
| 検索エンジン（[[qmd]]） | 小規模wikiでは[[IndexとLog\|index.md]]で十分 |
| スライドデッキ（[[Marp]]） | Markdownページだけで十分な場合がある |
| 出力フォーマット全般 | ユーザーのニーズ次第で完全に異なるセットでもよい |
| [[Vault分離と人間-AIの境界\|Vault分離]] | 単一Vaultでも運用可能。分離はKarpathyのpatternの一部ではなくコミュニティ発展 |
| [[事前にやろうとしない運用哲学\|事前検証の省略]] | 監視レベルは個人のスタイル。Karpathyはstay involved派 |
| [[株分け（kabuwake）\|株分け機構]] | 単一Wikiで完結するユースケースも多い |

## 導入の3ステップ（tsurubeeの実践）

tsurubeeはテンプレート配布スタイルを取らない立場を明確化した上で、個人導入の手順を提示:
1. **gistをLLMに読ませて雛形を作らせる** — 完成形の配布ではなく、gist（抽象アイデア）→ schema + ディレクトリ構造の具体化をLLMとの協働で行う
2. **5本ほどingestしてみる** — 「テンプレが完璧かどうか」ではなく「生成された概念ページが自分にとって読み返したい形か」を見る
3. **テンプレを育てる** — schemaとスキルは静的な設定ではなく、運用を通じて使い方を学習する動的成果物

配布する「完成形」を作るか、gistのような「種」を配るか——この2段階モデルは配布形式の研究課題への実証的な回答の1つ。

## ミニマム構成の実例（tsurubeeのリポジトリ構成）

```
llm-wiki/
├── CLAUDE.md                       # schema：ディレクトリ規約・ワークフロー定義
├── .claude/skills/
│   ├── ingest-paper/SKILL.md       # 論文PDFをingest
│   ├── ingest-article/SKILL.md     # Web記事をingest
│   ├── query/SKILL.md              # wikiに質問する
│   └── lint/SKILL.md               # ヘルスチェック
└── vault/                          # Obsidian Vaultとして開く
    ├── raw/                        # （papers/ + articles/、不変）
    └── wiki/
        ├── index.md / log.md
        ├── papers/ articles/ concepts/ queries/
```

- エージェント別対応（Claude Code → Codex）は`CLAUDE.md`→`AGENTS.md`、`.claude/skills/`→該当ディレクトリの読み替えで済む、という前提
- SKILL.mdの最小例（ingest-paper全文）が記事内にあり、スキルは「この程度の簡素さで動く」と報告
- スキルのセクション設計（横断的知見・未解決の問い）が概念ページの成長を方向付ける → [[Ingest]]

## nishio実践からの追加原則

- **研究目的/プロジェクト目的の区別**（[[研究目的Wikiとプロジェクト目的Wiki]]）は必須ではないが、Wikiが育つと自然に分化する
- **複数Wiki連携**（[[Wikis-as-personas]]）もoptionalだが、育った先で必要になる
- [[LLM Wikiの実運用データ]]が示すように、多くのWikiは1日で凍結する。全機能が必要なわけではない

## テンプレート設計への含意

この原則は、LLM Wikiテンプレートが答えるべき核心的問いを提起する:
- 汎用テンプレートとして**何を提供すべきか**（必須デフォルト）
- **何をユーザー任せにするか**（optionalな拡張ポイント）
- [[Schema（AGENTS.md）]]には**何を書くべきか、何を書かないべきか**
- 複数Wiki時代のテンプレートは、単一Wikiの枠を越えるべきか

当wikiの研究課題そのもの → [[このWikiの目的と研究課題]]

## 関連概念

- [[LLM Wiki]] — 全体パターン
- [[Schema（AGENTS.md）]] — Optionalityを具体化する設定文書
- [[Obsidian as IDE]] — optionalなツールチェーンの一例
- [[株分け（kabuwake）]] — optionalだが有用な拡張パターン
- [[このWikiの目的と研究課題]] — この原則をテンプレート設計にどう落とし込むか
- [[繋げる力]] — 「読み返したい形に育てる」実践の概念化
