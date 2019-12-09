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



love-nuklear
