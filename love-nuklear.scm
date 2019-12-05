(define-module (love-nuklear)
               #:use-module (guix packages)
               #:use-module (guix download)
               #:use-module (guix build-system cmake)
               #:use-module (guix licenses)
               #:use-module (guix git-download)
               ; #:use-module (guix gexp)
               #:use-module (gnu packages lua))

(define-public love-nuklear
 (let ((commit "0cca218ac72f71c39130277dac1a6d1c9aceef69")
       (revision "0"))
  (package
   (name "love-nuklear")
   (version (git-version "v2.6" revision commit))
   ; (source
   ;  (local-file
   ;    "/home/jyscao/guix_custom_packages/love-nuklear-test/love-nuklear"
   ;    #:recursive? #t))
   (source (origin
            (method git-fetch)
            (uri (git-reference
                  (url "https://github.com/keharriso/love-nuklear/")
                  (commit commit)
                  (recursive? #t)))
            (file-name (git-file-name name version))
            (sha256
             (base32 "0qidw091n1780kbxj2ddjpic6l24p7b16bk1b4xyqha1swfn7w32"))))
   (build-system cmake-build-system)
   (arguments
    `(#:build-type "Release"
      #:tests? #f
      #:phases
      (modify-phases %standard-phases
       (replace 'install
        (lambda* (#:key outputs #:allow-other-keys)
                 (let* ((out (assoc-ref outputs "out"))
                        (share (string-append out "/share")))
                       (install-file "nuklear.so" share)
                       #t))))
      ))
   (inputs
    `(("luajit" ,luajit)))
   (synopsis "Nuklear module for the LÖVE game engine")
   (description "LÖVE is a Lua framework for making 2D games. 
    Nuklear is a minimal state immediate mode graphical user interface toolkit. 
    This package is for the Nuklear bindings in LÖVE created by Kevin Harrison.")
   (home-page "https://github.com/keharriso/love-nuklear/")
   (license expat))))



love-nuklear

; ;; using git-fetch; could not get consistent hash when doing `$ guix download ...`
; (method git-fetch)
; (uri (git-reference
;       (url "https://github.com/keharriso/love-nuklear/")
;       (commit "0cca218ac72f71c39130277dac1a6d1c9aceef69")))
; (sha256
;  (base32 "1z1db35zagdaky987188j12lqhiqqldmqiy9p5rh08f8ckq8jk3h"))))
;   ;; PROBLEM: the hash changes on every run of `$ guix download "https://github.com/keharriso/love-nuklear"`
