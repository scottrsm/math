## How to build this project -- main.pdf -- do the following.

- To make changes to the text do:
    - ./make [optional line number]
       This runs tex twice on the file main.tex
       along with the index builder and then jumps to a 
       particular page if given.


- TO BUILD A NEW essential_calculus.pdf:
    - ./make 
       This loads and TeXs main.tex, composed of all the chapters 
       twice as well as builds the index,
       Then it runs xdvi on the main.dvi file.

    - Then do:
        - dvips main.dvi  (giving main.ps)
        - ps2pdf main.ps  (giving main.pdf)
        - cp main.pdf to pdf/essential_calculus.pdf

    - Finally, update the PDF hash files in tex/ (the hashes bind to the
      exact PDF bytes, so they must be regenerated after EVERY rebuild of
      pdf/essential_calculus.pdf). Run from this directory:
        - sha256sum pdf/essential_calculus.pdf | awk '{print $1}' | fold -w2 | sed 's/^/ 0x/' > ../../tex/essential_calculus_pdf_sha256.txt
        - sha384sum pdf/essential_calculus.pdf | awk '{print $1}' | fold -w2 | sed 's/^/ 0x/' > ../../tex/essential_calculus_pdf_sha384.txt
      (Format: one byte per line as " 0xNN" -- 32 lines for sha256,
      48 for sha384.)


