# このWikiの目的と研究課題

このWikiは、**汎用のLLM Wikiテンプレート**を研究・開発するための実験台である。
ここでの知見は最終的に別途配布するテンプレート（repo / ディレクトリ / CLI — 形式未定）に凝縮される。
テンプレート設計の仮説は [[テンプレート草案ver.1]] に集約されており、
このWiki自身の運用がその検証実験になっている。

## 目的

1. **知識基盤を作る** — KarpathyのLLM Wikiパターン、nishioの実践知（20+ Wiki）、villagepumpコミュニティの議論をingestし、[[overview]]に記した通り知識ネットワークを育てる。
2. **テンプレート設計を検討する** — 以下の問いに答えを出す。
3. **最終成果物として汎用テンプレートを出力する** — 配布形式はこのWikiでの検討を通じて決定する。

## 中心となる研究課題

- [ ] 汎用テンプレートとして何を提供すべきか？ 何をユーザー任せにするか？
- [ ] 汎用`AGENTS.md`には何を書くべきか？ 何を書かないべきか？（→ [[テンプレート草案ver.1]]）
- [ ] ディレクトリ構成のベストプラクティスは？
  - 2026-08-11時点の考察: concepts/entitiesの境界はrawソース群（Karpathy gist・nishio・villagepump）のどこにも定義がない。villagepumpの表（`villagepump-AIを使った知識マネジメント.md` L253-259）は「簡潔さの強さ」のポリシーであって分類定義ではない。入リンク実測でもentityがハブ化する（Obsidian 9, qmd 7, Marp 6）が、最上位ハブは概念が独占。4分類は実質「sources / analyses / それ以外」の3分類＋ナビゲーション用タクソノミと言える。→ [[テンプレート草案ver.1]] claim#2のevidenceに追記
- [ ] 配布形式はどうするか？（別リポジトリ / `template/` ディレクトリ / GitHub Template Repository / `npx create-llm-wiki` / その他）
  - 2026-08-14: 要件候補を追加 — テンプレートrepoは同一repo型の見本（dogfooding）でありながら、**wiki/部分が単独で取り出せる**ことを保証すべき（研究目的wikiはコード不要）。別repo参照型を選ぶユーザー向けにwork/の運用規定（[[Wikiとコードリポジトリの関係]]）も配布物に含めるか要検討
  - 2026-08-14: 先行実装の配布形式データ点 — [[Microsoft llmwiki]] は `.vsix`（拡張機能）+ npm（`@llmwiki/core`）+ MCP（`npx -y -p @llmwiki/core llmwiki-mcp`）の3経路で配布。操作層をソフトウェアとして同梱する方向 → [[リポジトリ分析 microsoft-llmwiki]]
  - 2026-08-14: **暫定採用: `template/` ディレクトリ（手動コピペ）** — 動機（お決まり経路の再発明防止 + 立ち上げ品質の揺れ対策）と妥当性検証は [[配布形式の決定とテンプレートの動機]]。クローズ条件: M1 template/ v0.1作成 → M2 外部fresh wikiでのboot成功 → M3 別repo切り出し。`npx create-llm-wiki`は操作層のツール化（Microsoft方向）と反するため、外部利用者の実績が出るまで却下維持
  - 2026-08-14: 操作層の配布構成 — **v0.1は二層構成（AGENTS.md + `.agents/skills/` 同梱 + root `scripts/lint.sh`）**（コピーだけで動く・Claude Codeのみパス参照1行）。GitHub Template RepositoryはM3（別repo切り出し）の候補に繰り下げ。v0.1スコープ決定（二層・対象範囲・規範のみ原則）は [[claims対応表]] と [[配布形式の決定とテンプレートの動機]]
- [ ] 既存の実装（Microsoft llmwiki、llm-wiki.app、各種CLIツール）との差別化は？
  - 2026-08-11: [[OKF]]（Google、2026-06-12発表）を追加。OKFは成果物（format）層のみの標準化で操作（足場）層を標準化しない（nishioの考察1）——テンプレートは操作層（AGENTS.md）を提供する点で差別化可能。赤リンクはOKFが許容・本wikiがエラー扱いという設計分岐もある（[[Lint]]）。詳細は [[2026-08-11 OKFとLLM Wiki (nishio+villagepump)]]
  - 2026-08-14: [[Microsoft llmwiki]] を分析（ingest完了）。3層構造は当wikiと同一（構造は普遍）で、差別化の軸は**操作層の実現手段**: Microsoftはツール（MCP 14ツール・`@wiki`・lint/status自動化）で自動化する方向、本テンプレートは文書（AGENTS.md指示）でツール非依存・選択自由を保つ方向。MicrosoftはGitHub Copilot必須（モデル依存）・UIがVS Code固定。→ [[操作層]]、[[リポジトリ分析 microsoft-llmwiki]]
  - 2026-08-14: 操作層の実現手段を仮採用決定 — **MCPはデフォルト不採用・オプション追加可、AGENTS.md+SKILL.md+scripts/の文書構成で提供**。subagent相談2往復の検証（MCP 14ツール定義は実測1.6-2Kトークン/ターン常駐で単独軽微・集約環境で実害、Agent Skillsは2025-12オープン標準化、OpenAIが文書+skill構成を公式OSS採用）。→ [[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]
  - 2026-08-14: **SKILL併用6事例はライト分析で完了**（README/SKILL.mdレベルの横断比較: [[リポジトリ分析 SKILL併用6事例]]）。clone実測の深掘りはしない。理由: microsoft-llmwikiのcloneは「MCP不採用」という設計決定の直接参照点だったが、6事例は既に二層採用決定を支持するデータ点で設計判断は抽出済み。[[事前にやろうとしない運用哲学]]に整合。深掘りはトリガー時（①テンプレートSKILL.md執筆時に実例が必要 ②二層設計のclaimが争われrepo検証が必要 ③lucasastorian等MCP-native実装がMCP指針の参照点になる）に絞って実施
  - ⚠ 残TODO: llm-wiki.app・各種CLIツールの分析が未着手。SKILL併用サーベイでlucasastorian/llmwiki（808★・MCP-native）とPratiyush/llm-wiki（229★・16 lint規則のコード化）が候補として判明（deep-diveは上記トリガーに準拠）
- [ ] Cosenseの設計原理をどう具体的なデフォルトに落とし込むか？
  - 2026-08-11: OKF議論から「同一の赤リンクを共有するページ群を2-hop関連として提示する」Cosenseの仮想ページ挙動を、lintの改善（エラーと発見の分離）として輸入する余地（[[Lint]]）
  - 2026-08-14: リンク概念の体系ingest完了（[[Cosenseのリンク概念]]、[[赤リンクとLLM Wiki]]）。赤リンク許容とlintのエラー/発見分離が具体的になった。実装データ点3件:
    - [[リポジトリ分析 BDL-2026S]]: 未解決wikilinkを参照数で分類（1頁=broken_wikilink/error、2+頁=aspect_handle/info）。「赤リンクはfeature、TODOリスト扱いするな」をAGENTS.md明文化
    - [[リポジトリ分析 SMS-2026S-report]]: 同じ参照数分割。「unresolvedはbrokenではない、全て実参照」「2+頁参照=2-hop hubの種」
    - [[リポジトリ分析 grasp]]: リンクの4仕事（recall/attention/navigation/読者ケア）の層分離理論。come-from（用語-大域の1宣言で全出現をgather）でAI作ページの裸言及問題（AI default 裸）に対処
  - 追記すべき論点: 本wikiの[[Lint]]は現在broken-wikilink=エラー扱いだが、参照数分類（2+頁参照はinfo）に変更する余地。LLMが生成するページは元々リンク疎（AI default 裸）なので、wikilink強制より赤リンク許容＋come-from的gatherが向く可能性（要検証）
- [ ] `AGENTS.md`はどこまで薄くできるか？ — **このwiki自身の存続が最小スキーマの実証になる**
  - 2026-08-14: 明文化（subagent検証、[[MCP不採用とAGENTS.md+SKILL.md二層採用の根拠]]） — 本wikiの厚さ（AGENTS.md 8.7KB）は研究ルール=ドメイン知識が主成分で、操作手順のskill化だけでは薄まらない（BDL型）。薄さの実証はAMME（1.9KB）由来の**外部データ点**、自己適用は厚さ側のデータ点。TODO: 操作手順のみをskill化する自己適用実験で差分を計測
- [ ] テンプレートは「人間が読む前提」の可読性設計（overview重視・辞書的消費への警鐘）か、read-optional設計か？ — [[理解のボトルネック]]（tsurubee）と[[読まれなくてよい中間産物]]（nishio）の対立。2026-08-11 ingestで顕在化。[[テンプレート草案ver.1]] claim#7の検証データ
- [ ] 情報信頼性（[[LLM Wikiの作文リスク]]）にテンプレートはどう対処すべきか？

## 現状

- `raw/` に実在するソースは9件（Karpathy gist + Cosense 8ページ: villagepump 2 + nishio 6）
- `AGENTS.md` は運用規則のみに縮小済み（2026-08-11）。テンプレート設計の主張はすべて
  [[テンプレート草案ver.1]] に仮説として移管
- 2026-08-11: Karpathy gist ingest（27ページ） + Cosense議論 ingest（26ページ）。合計50+ページ

## 関連

- [[overview]] — エントリーポイント
- [[index]] — ページカタログ
- [[テンプレート草案ver.1]] — テンプレート仮説（status: hypothesis）
- [[Cosenseソースのingest方式]] — Cosenseソースの取り込み方式の提案（研究課題「情報信頼性」「配布形式」へのインプット）
- [[rawディレクトリの取り扱い]] — raw/のgitignore・プライバシー・ライセンス・発見層の区別（open question）
- [[LLM Wikiの作文リスク]] — 情報信頼性の概念
