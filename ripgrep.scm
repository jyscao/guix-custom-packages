(define-module (ripgrep)
               #:use-module (guix packages)
               #:use-module (guix download)
               #:use-module (guix build-system cargo)
               #:use-module (guix licenses))

(define-public ripgrep
  (package
   (name "ripgrep")
   (version "11.0.2")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://github.com/BurntSushi/ripgrep/archive/"
                  version
                  ".tar.gz"))
            (sha256 (base32 
                     "0m8094rspl6csv17ak548kmk9bchsmixdmd6qy5xlslkg498d0q9"))))
   (build-system cargo-build-system)
   (arguments
    `(#:cargo-build-flags '("--release")
      #:tests? #t))
   (synopsis "ripgrep recursively searches directories for a regex pattern")
   (description "ripgrep is a line-oriented search tool that recursively
searches your current directory for a regex pattern. By default,
ripgrep will respect your .gitignore and automatically skip hidden
files/directories and binary files.")
   (home-page "https://github.com/BurntSushi/ripgrep")
   (license (list license:expat license:unlicense))))

;; failed build: Dec. 06 2019
;; note: keeping build directory `/tmp/guix-build-ripgrep-11.0.2-+54days.8892bf6.drv-0'
;; View build log at '/var/log/guix/drvs/8d/lhz704y2i3hal7xlr49xb3gdld5jxn-ripgrep-11.0.2-+54days.8892bf6.drv.bz2'

ripgrep
