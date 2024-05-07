(auto-insert-mode t)
(setq auto-insert-query nil)

(add-to-list 'auto-insert-alist
             '(("\\.pl$" . "Perl Program")
               nil
	       "#! /usr/bin/perl\n\n"
	       "use strict;\n"
	       "use feature ':5.10';\n\n"
	       _
	       ))

(add-to-list 'auto-insert-alist
             '(("\\.py$" . "Python Program")
               nil
               "#! /usr/bin/python\n\n"
	       _
               "\n\ndef main():\n"
               "    \"\"\"main\"\"\"\n"
               "\n\nif __name__ == '__main__':\n"
               "    main()\n"
	       ))


(provide 'wfp5p-skels)
