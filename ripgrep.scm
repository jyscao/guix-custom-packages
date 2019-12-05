(define-module (ripgrep)
               #:use-module (guix packages)
               #:use-module (guix git-download)
               #:use-module (guix build-system cargo)
               #:use-module (guix licenses))

(define-public ripgrep
 (let ((commit "8892bf648cfec111e6e7ddd9f30e932b0371db68")
       (srchash "03nxmr0cyhj8aq1d8jk6yy94z447s4hzyg7c5zgxjxpmapj9c49k")
       (revision "+54days"))
  (package
   (name "ripgrep")
   (version (git-version "11.0.2" revision commit))
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/BurntSushi/ripgrep")
                  (commit commit)))
            (file-name (git-file-name name version))
            (sha256 (base32 srchash))))
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
   (license (list license:expat license:unlicense)))))

;; failed build: Dec. 06 2019
;; note: keeping build directory `/tmp/guix-build-ripgrep-11.0.2-+54days.8892bf6.drv-0'
;; View build log at '/var/log/guix/drvs/8d/lhz704y2i3hal7xlr49xb3gdld5jxn-ripgrep-11.0.2-+54days.8892bf6.drv.bz2'

ripgrep
