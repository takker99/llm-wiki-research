---
status: tentatively-adopted
date: 2026-08-14
sources: "raw/karpathy-llm-wiki-gist.md", "raw/nishio-KarpathyのLLM_Wiki勉強会.md", "raw/nishio-KarpathyのLLM_Wiki.md"
tags: [template-design, llm-wiki-pattern]
---

# ingestとfile-backの反映方法の同型性

「ingestとfile-backは、rawから抽出するかログ（会話）から抽出するかの違いで、wikiへの知見の反映方法は同じでは？」という問いを、Karpathy gistとnishioの実践に立ち返ってsubagent相談2往復で検証した結果。

## 結論

**ユーザーのモデルは設計思想レベルで正しい。** ingestもfile-backも、LLMがwikiを編み続ける単一のプロセスへの流入経路であり、「反映方法は同じ」でよい。ただし「ログ」は `log.md` ではなく**会話ログ（チャット履歴）**の意味（nishioの用語は[[QueryとFile-back]]参照）。

根拠:
- gist: 「the wiki keeps getting richer with every source you add and every question you ask」（L13）— ソース追加と質問がwiki富化の同等イベントとして並置
- gist: 「your explorations compound in the knowledge base just like ingested sources do」（L39）— file-backがingestと同型の複利主体への流入である明示
- nishio: file-backを「ログから知見を抽出して恒久化する操作」と定義（勉強会L240）— ユーザーの「抽出元の違い」という理解と一致
- nishio: 実践で「1は新規ページの追加で〜、2と3は既存ページの更新です」（勉強会L222）— **file-backもingest同様に新規+既存更新の複数ページ編み込みをする**決定的証拠

## 頻度制御と実行深さの2軸

対称性の問いは2軸に分解できる:

| 軸 | 判断 | 内容 |
|---|---|---|
| **頻度制御**（いつ・何をfile-backするか） | **非対称を維持** | ingestはraw投入でほぼ必須、file-backは任意の提案+人間ゲート（nishio「必須ではないがやった方がいい」L236） |
| **実行深さ**（承諾後の編み込み） | **軽い同型** | 「明らかに影響を受けるページの更新+矛盾の明示」までやる。ingestの重い契約（10-15ページ照合）は不要 |

「query中に照合済みだから編み込み不要」は誤り: query中に済むのは外向きリンク（回答の wikilink 引用）だけで、内向き統合（既存ページからの逆リンク・index登録）は未実施。compounding は内向き統合まで含めて成立する。

## 残る本当の違い（反映方法ではない）

1. **知識の事前存在 vs 会話中の総合生成**: ingestは外部コンテンツの解釈、file-backは会話で生成された個人的総合（「言語化された情報ソースにない重要な情報」勉強会L245）
2. **義務性と時間的パターン**: ingest=ほぼ必須・batch可、file-back=任意・価値判断・セッション終了時の蒸留儀式
3. **grounding契約**: ingest産物は `sources/` + raw直リンク必須（rawが権威）、file-back産物は `analyses/` か `concepts/` + wikilink引用（wiki内部が権威）
4. **動機の対照**: ingest=蓄積の主目的、file-back=喪失防止（"shouldn't disappear into chat history"）

## 実装アーティファクトとの区別

microsoft `@wiki /save`（単一queryページ+index自動upsert）やtsurubee `wiki/queries/` の単一ページ型は、**設計思想の違いではなくツール実装・実装者の選択**。単一ページも「回答は1つの総合成果物→1ページが自然」という実用上の合理性はあるが、それを設計思想に昇格させるべきではない。

## 発見: templateのFile-back実行契約の欠損

[[リポジトリ分析 microsoft-llmwiki]]・nishio実践との対比で判明: **template/AGENTS.mdのFile-back節（v0.1）には実行契約がほぼ無かった**（保存先・index/log更新の記述すらなし。研究wikiのQuery step 5よりさらに欠損）。非対称（頻度制御）と欠損（実行契約の不在）は区別すべきで、v0.1は後者に転んでいた。

## 是正（2026-08-14実施）

1. 研究wiki AGENTS.md Query step 5: 「関連する既存ページへのwikilink・明らかに影響を受けるページの更新・矛盾の明示・index/log更新」を追加
2. template/AGENTS.md File-back節: 上記の軽い実行契約を追加
3. [[QueryとFile-back]] に「『このログ』=会話ログ、`log.md`とは別物」の注記

フィルタ規則（「感想はfile-backしない」等）は**書かない**選択: 人間ゲートが既にフィルタであり、nishioの「面白いね→イマイチ→…言語化」のループ（L242-245）を切る恐れがあるため。

## 関連

- [[QueryとFile-back]] — file-backの基本操作（本検証の是正が反映済み）
- [[Ingest]] — 対比される知識流入経路
- [[ingestにおける編み込みの実際]] — 編み込みの内実（3層波及構造はfile-backにも同型適用可能）
- [[操作層]] — 文書型vsツール型の実現手段の軸
- [[テンプレート草案ver.1]] — テンプレートのclaims（薄さvs欠損の区別）