(define-module (love-nuklear)
               #:use-module (guix packages)
               #:use-module (guix download)
               #:use-module (guix build-system cmake)
               #:use-module (guix licenses)
               #:use-module (guix git-download)
               #:use-module (gnu packages lua))

(define-public love-nuklear
 (let ((commit "fef4e00a602efb16c57ae962850b6e7a01f7a29a")
       (srchash "15qmy8mfwkxy2x9rmxs6f9cyvjvwwj6yf78bs863xmc56dmjzzbn")
       (revision "0"))
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
