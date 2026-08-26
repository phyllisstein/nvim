;; extends

;; IDEA-style comment-directed injection:
;;
;;     // language=cypher
;;     "MATCH (n:Interview) RETURN n"
;;
;; The mechanism is that @injection.language used as a CAPTURE (rather than
;; via #set!) makes nvim read the matched node's TEXT as the parser name.
;; This is the same machinery that makes markdown fences work.
;;
;;   #lua-match?  gates the pattern so only `// language=x` comments qualify
;;   #gsub!       rewrites the capture text in place, leaving a bare name
;;   .            anchors the string as the IMMEDIATELY following named
;;                sibling -- a second comment or an attribute in between
;;                silently breaks the match
;;
;; Note @injection.content sits on `string_content`, not `string_literal`.
;; When a grammar exposes an inner content node, capture that and skip
;; #offset! entirely; only reach for offsets when it doesn't.
;;
;; The parser must exist under exactly the name in the comment, or the
;; injection silently no-ops (indistinguishable from a broken query). Test
;; the mechanism with `// language=json` first, since that parser definitely
;; exists, before trying anything exotic.

((line_comment) @injection.language
  .
  (string_literal (string_content) @injection.content)
  (#lua-match? @injection.language "^//%s*language=")
  (#gsub! @injection.language "^//%s*language=%s*" ""))

;; Raw strings: r#"..."#
;;
;; VERIFY THE NODE SHAPE FIRST. Older tree-sitter-rust treated
;; raw_string_literal as an opaque leaf; it was later restructured to expose
;; string_content. Put an r#"..."# in a buffer and run
;; vim.treesitter.inspect_tree(). If you see (raw_string_literal
;; (string_content)) this pattern is right. If it's a bare leaf, use the
;; commented-out offset variant below instead.

((line_comment) @injection.language
  .
  (raw_string_literal (string_content) @injection.content)
  (#lua-match? @injection.language "^//%s*language=")
  (#gsub! @injection.language "^//%s*language=%s*" ""))

;; Fallback for the opaque-leaf grammar. #offset! takes literal integers, so
;; `0 3 0 -2` is hardcoded to EXACTLY ONE hash: r#"..."#. r##"..."## is off
;; by one each side, r"..." off the other way. One pattern per hash count is
;; the only way to express it, which is another argument for confirming the
;; content-node version works.
;;
;; ((line_comment) @injection.language
;;   .
;;   (raw_string_literal) @injection.content
;;   (#lua-match? @injection.language "^//%s*language=")
;;   (#gsub! @injection.language "^//%s*language=%s*" "")
;;   (#offset! @injection.content 0 3 0 -2))
