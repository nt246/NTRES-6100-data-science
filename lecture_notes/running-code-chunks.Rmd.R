### Clean up RMarkdown

* Separate into separate code chunks and add a little commentary above each. You can also name your code chunks, if you'd like.
* Add a few headers.
* How about a picture?

If you forgot how, take a peek at the [RMarkdown Cheatsheet](https://github.com/rstudio/cheatsheets/blob/master/rmarkdown-2.0.pdf)

<br>

### Running RMarkdown code chunks 

So far we have written code in our RMarkdown file that is executed when we knit the file. We have also written code directly in the Console that is executed when we press enter/return. Additionally, we can write code in an RMarkdown code chunk and execute it by sending it into the Console (i.e. we can execute code without knitting the document). 

How do we do it? There are several ways.

**First approach: send R code to the Console.**
This approach involves selecting (highlighting) the R code only, not any of the backticks/fences from the code chunk. (If you see `Error: attempt to use zero-length variable name` it is because you have accidentally highlighted the backticks along with the R code. Try again (and don't forget that you can add spaces within the code chunk or make your RStudio session bigger (View > Zoom In)). 

Do this by selecting code and then: 
  
  1. copy-pasting into the Console and press enter/return.
1. clicking 'Run' from RStudio IDE. This is available from: 
  a. the bar above the file (green arrow)
b. the menu bar: Code > Run Selected Line(s)
c. keyboard shortcut: command-return

**Second approach: run full code chunk.**
  Since we are already grouping relevant code together in chunks, it's reasonable that we might want to run it all together at once. 

Do this by placing your curser within a code chunk and then: 

1. clicking the little black down arrow next to the Run green arrow and selecting Run Current Chunk. Notice there are also options to run all chunks, run all chunks above or below...
