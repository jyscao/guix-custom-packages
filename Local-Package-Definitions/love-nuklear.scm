(define-module (love-nuklear)
               #:use-module (guix packages)
               #:use-module (guix git-download)
               #:use-module (guix build-system cmake)
               #:use-module (gnu packages lua)
               #:use-module ((guix licenses) #:prefix license:))



;; The package definition below is identical to the patch sent
;; to guix-patches@gnu.org, ticket #38548

(define-public love-nuklear
 (let ((version "v2.6")
       (commit "fef4e00a602efb16c57ae962850b6e7a01f7a29a"))
  (package
   (name "love-nuklear")
   (version (git-version version "+4commits" commit))
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/keharriso/love-nuklear/")
                  (commit commit)
                  (recursive? #t)))
            ;; NOTE: the HEAD of the Nuklear git-submodule is at commit 
            ;; "adc52d710fe3c87194b99f540c53e82eb75c2521" of Oct 1 2019
            (file-name (git-file-name name version))
            (sha256
             (base32
              "15qmy8mfwkxy2x9rmxs6f9cyvjvwwj6yf78bs863xmc56dmjzzbn"))))
   (build-system cmake-build-system)
   (arguments
    `(#:build-type "Release"
      #:tests? #f))
   (inputs
    `(("luajit" ,luajit)))
   (synopsis "Lightweight immediate mode GUI for LÖVE games")
   (description "LÖVE is a Lua framework for making 2D games.  Nuklear
is a minimal state immediate mode graphical user interface toolkit.  This
package is the Nuklear bindings for LÖVE created by Kevin Harrison.")
   (home-page "https://github.com/keharriso/love-nuklear/")
   (license license:expat))))
