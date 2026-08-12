---
status: tentatively-adopted
date: 2026-08-12
tags: [template-design, repos, pilot-analysis, nishio, abandoned, quartz]
source: subagent analysis of repo
sources: "[[GitHubリポジトリ分析の方法論]]"
repo_url: https://github.com/nishio/llm-wiki-about-delite
commit: 4181dd42ff78d72a5e5a05512a59dc37d7ef97a2
clone_date: 2026-08-12
license: None
type: 逸脱・停止型
---

# リポジトリ分析: llm-wiki-about-delite

パイロット分析5件目。nishioのdelite（デライト）作者・宇田川浩行氏の思想を理解するためのLLM Wiki。
CLAUDE.mdのみ（AGENTS.mdなし）、Quartzで静的公開、わずか43時間で停止。

## 構造

| 項目 | 値 |
|---|---|
| CLAUDE.md | 7,489 bytes / 124行（AGENTS.mdなし） |
| wiki/ 総ページ数 | 100+ concepts, 4 syntheses, 2 people |
| index.md | 16KB、wiki/配下 |
| log.md | 53KB / 490行 |
| 運用期間 | **2026-05-22 〜 05-24（約43時間）** |
| コミット数 | 9 |
| 公開 | Quartz + GitHub Pages |
| raw/ | Scrapboxエクスポート + Webスクレイピング2,005件 |
| tools/ | 7つの運用スクリプト |

## 停止の原因分析

### 仮説1: 実験の成功裏の完了（最有力）
目的（宇田川氏の思想を特殊用語抜きで理解可能にする）は43時間で達成。
4ソースingest、100+概念・4統合解説ページ作成、Quartz公開まで完了。
「未着手」リストは山積みだが、nishioは「complete」で満足して本命の自己Wikiに戻ったと推定。

### 仮説2: 並行プロジェクトとしての優先順位低下
nishioの自己WikiのAGENTS.mdにdelite Wikiが `projects/Delite-LLM-Wiki` として明記されており、
「他人の思想をLLM Wiki化する実験」という副次的プロジェクトだった。

### 仮説3: スコープ爆発
宇田川氏の全公開輪郭は19.6万件。2,005件しか処理できておらず、
指数的に増えるingest対象に対して人間の確認が追いつかなくなった。

### 仮説4: Quartzの複雑性
最終commitがQuartz設定。`ignorePatterns`に多数のファイルを列挙する必要があり、
ファイル追加のたびにconfig更新が必要な運用負荷。

## 逸脱要素

### CLAUDE.mdのみ（AGENTS.mdなし）
意図的な選択。Claude Code特化。ただし他のLLMツールからのアクセスを制限し、
「nishioがClaude Codeを使う時だけ」のWikiになった。

### init.txt（427 bytes）
極小の初期指示。「宇多川」→「宇田川」の誤記をCLAUDE.md側で訂正する二重管理が発生。
テンプレート設計上の教訓: 初期指示の誤り訂正は元ファイルで行うべき。

### 「先行概念マッピング」
全概念ページに `## 先行概念` セクションを義務化。
宇田川氏の造語に対して既知の先行概念を列挙するメタレイヤー。
他人の思想を分析するWikiならではの発明。維持コストは高い。

### 統合解説層（syntheses/）
概念辞書の上に「特殊用語を使わずに全体像を描く」メタページ群。
delite Wikiの最大の発明であり、テンプレートとして抽出価値がある。

### スクリプト事故
`normalize_broken_links.py` が非wikiリンクまで一律 `.md` 変換して破壊。
LLM生成スクリプトの危険性を示す典型例。dry-runの義務化が必要。

## テンプレート研究への示唆

### 失敗から学ぶ教訓

| 問題 | 教訓 |
|---|---|
| init.txt誤記の二重管理 | ソース・オブ・トゥルースの一元化 |
| ディレクトリ後付けリファクタリング | 最初から `wiki/` ラッパーを標準化 |
| 無限スクレイピング | ingest終了条件をスキーマに含める |
| スクリプトの破壊的操作 | dry-runの義務化 |
| Quartz設定の複雑性 | 静的サイト生成はコア責務から分離 |

### テンプレート設計への具体的示唆

1. **`wiki/`ラッパーディレクトリはデフォルトにすべき** — 後付け移動を防ぐ
2. **AGENTS.md + CLAUDE.md 両方をテンプレートに** — CLAUDE.mdのみだとツール依存
3. **静的サイト生成はオプション扱い** — Quartz統合はアドオンとして提供
4. **ingest終了条件をスキーマに含める** — 無限拡大防止
5. **統合解説層（syntheses/）はテンプレートに含める価値がある** — 概念辞書の上の入口ページ

## 関連

- [[リポジトリ分析 llm-wiki-about-nishio]] — 同nishio系、本命の自己Wiki
- [[リポジトリ分析 grasp]] — 同nishio系、Code+Wikiハイブリッド
- [[パイロット分析 横断所見]] — 5件の横断比較
- [[GitHubリポジトリ分析の方法論]]
- [[外部リポジトリ分析のリスクと罠]] — 放棄・停止のパターン
