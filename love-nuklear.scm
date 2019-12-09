(define-module (love-nuklear)
               #:use-module (guix packages)
               #:use-module (guix git-download)
               #:use-module (guix build-system cmake)
               #:use-module (guix licenses)
               #:use-module (gnu packages lua))



;; procedure that formats the versioning part of the filename
;; differently depending on the revision argument
;; ---> not all that useful
(define (git-version2 version revision commit)
  "Return the version string for packages using git-download."
  (cond
      ((string=? revision "")      (string-append version "-" (string-take commit 7)))
      ((string= revision "+" 0 1)  (string-append version revision "." (string-take commit 7)))
      (#t (git-version version revision commit))))
  (package
   (name "love-nuklear")
   (version (git-version "v2.6" revision commit))
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/keharriso/love-nuklear/")
                  (commit commit)
                  (recursive? #t)))
            (file-name (git-file-name name version))
            (sha256 (base32 srchash))))
   (build-system cmake-build-system)
   (arguments
    `(#:build-type "Release"
      #:tests? #f))
   (inputs
    `(("luajit" ,luajit)))
   (synopsis "Nuklear module for the LÖVE game engine")
   (description "LÖVE is a Lua framework for making 2D games. 
    Nuklear is a minimal state immediate mode graphical user interface toolkit. 
    This package is for the Nuklear bindings in LÖVE created by Kevin Harrison.")
   (home-page "https://github.com/keharriso/love-nuklear/")
   (license expat))))
(define-public love-nuklear-2.5.2
  (package
    (inherit love-nuklear-2.6)
    ; (name "love-nuklear")
    (version (git-version2 "2.5.2" "" "bf89bf9f088cfeba218bbcf494bd6d1cf0e72c29"))
    (source (origin
              (inherit (package-source love-nuklear-2.6))
              (uri (git-reference
                     (url "https://github.com/keharriso/love-nuklear/")
                     (commit  "bf89bf9f088cfeba218bbcf494bd6d1cf0e72c29")
                     (recursive? #t)))
              (file-name (git-file-name "love-nuklear" "2.5.2"))
              (sha256 (base32  "188hvcapp0ggsbkimdbx7i9g2151ay5p9l10678lppyj74xqhhxa"))
              ;; NOTE: need Nuklear submodule's HEAD to be at commit
              ;; "181cfd8" of Nov 2 2018 to produce source hash above
            ))))
;; NOTE: building using definition above still fails due to older
;; versions of love-nuklear not having an install target for make.
;; But the inheritance usage should be correct





; love-nuklear
; love-nuklear-2.5.2
