Lesson 11: Collaborating with GitHub and making websites with GitHub
Pages - Part 2
================

<br>

## Readings

There are no required readings for today, but if you did not join our
Zoom call last Wednesday, please read through sections 9.1 - 9.13 on the
[Ocean Health Index Data Science Training
Tutorial](http://ohi-science.org/data-science-training/collaborating.html)
before class

<br>

## Other resources

**Collaborating on GitHub:**

  - There is a lot more detail and excellent advice in
    [HappyGitwithR](https://happygitwithr.com/) by Jenny Bryan

<br>

**Tutorials on making websites with GitHub pages:**

  - Check out the video and other tutorials directly at [GitHub
    Pages](https://pages.github.com/)

  - A good starting point is [this brief
    tutorial](https://jules32.github.io/rmarkdown-website-tutorial/index.html)
    by Julia Lowndes

  - There are also good tips in this [tutorial by Karl
    Broman](https://kbroman.org/simple_site/)

<br>

## Plan for today

We will continue working through the tutorial we started on last time,
practicing how to collaborate on a GitHub repo while setting up a free
website through GitHub Pages. Because we may not have both partners from
all the pairs we formed last week with us today, we will form new pairs
and start over with setting up a new shared repo that both partners will
each clone to their local computers. It’s good to keep practicing that
setup, and we’ll quickly get back to where we left off.

<br>

## Learning objectives

Like last class, we will focus on the simplest way to collaborate on
GitHub by both partners having full write access to the repo. There are
many ways to improve this workflow once you get more comfortable, but
this is a good place to start.

By the end of today’s class, you should be able to:

  - Set up a new repo on GitHub and invite collaborators  
  - Clone the repo to your local machine through RStudio  
  - Work in parallel with a collaborator on files in a repo (both of you
    pushing changes)  
  - Describe how to avoid merge conflicts  
  - Resolve merge conflicts when they arise  
  - Set up a free website through RStudio with GitHub pages  
  - Control basic aspects of the design and styling of a GitHub pages
    website

<br>

## Getting set up

Because everyone will have a new partner today, we’ll practice one more
time how to

  - Create a new repo
  - Create a gh-pages branch (that will let us create a website) within
    that repo
  - Invite a collaborator and have both of you clone the collaborative
    repo to your local machines following sections 9.2 through 9.6 in
    the [Ocean Health Index Data Science Training
    Tutorial](http://ohi-science.org/data-science-training/collaborating.html#create-repo-partner-1).

**NOTE:** Make sure Partner 2 doesn’t clone the repo until Partner 1 has
pushed their `.RProj` file to avoid merge conflicts here.

<br>

## Merging changes that each partner makes to your repo

We will now demo a series of different outcomes we can experience when
two people are working on the same repo and end up making changes in
parallel without pushing in sequence (i.e. partners end up with
different versions on their local computers that need to be reconciled
in the remote repo). We will show this as part of the process of setting
up our collaborative website.

Watch first, then you’ll get a chance to work through the steps for
yourselves.

#### Scenario

> This section is borrowed from
> [HappyGitwithR](https://happygitwithr.com/push-rejected.html)

You want to pull changes from upstream, but you have done some new work
locally since the last time you pulled. This often comes up because what
you actually want to do is push, but Git won’t let you until you first
incorporate the upstream changes.

State of repo on GitHub

``` r
A--B--C
```

State of repo on your local computer

``` r
A--B--D
```

You can’t cause some sort of merge to happen to the GitHub copy when you
push.

Instead, you’ve got pull the commit C and somehow integrate it into your
D-containing history. Then you will be able to push again.

<br>

#### When you have worked on separate files

Let’s have Partner 2 create a new RMarkdown file. Here’s what they will
do:

1.  Pull\!
2.  Create a new RMarkdown file, just keep all the boilerplate text
    **and save it as `index.Rmd`**. Make sure it’s all lowercase, and
    named `index.Rmd`. This will be the homepage for our website\!
3.  Maybe change the title inside the Rmd, call it “Our website”
4.  Knit\!
5.  Save and sync your .Rmd and your .html files
      - (pull, stage, commit, pull, push)
6.  Go to GitHub.com and go to your rendered website\! Where is it?
    Figure out your website’s url from your github repo’s url. For
    example:
      - my github repo: <https://github.com/jules32/collab-research>
      - my website url: <https://jules32.github.io/collab-research/>
      - note that the url starts with my **username.github.io**

So cool\! On websites, if something is called `index.html`, that
defaults to the home page. So
<https://jules32.github.io/collab-research/> is the same as
<https://jules32.github.io/collab-research/index.html>. If you name your
RMarkdown file `my_research.Rmd`, the url will become
<https://jules32.github.io/collab-research/my_research.html>.

Now, let’s have Partner 1 edit the README file. Then try to pull. Then
stage, commit, push.

The versions should merge smoothly because there is no overlap between
the changes made by Partner 1 and 2.

Summary:

``` r
                 Remote: A--B--C

Local before 'git pull':  A--B--(uncommitted changes)
Local after 'git pull':   A--B--C--(uncommitted changes)
```

<br>

#### When you have worked in different parts of the same file

Now you both have a copy of the `index.Rmd` file. Partner 2 can add a
new header just under the setup code chunk (e.g. line 12), then pull,
stage, commit, push. Now Partner 1 can add a note under the `##
Including Plots` header around line 22. Then try to pull. Then commit,
and pull, stage, push.

Again, this time the versions should merge smoothly because we were
working in different parts of the document.

<br>

#### When you have worked on the same part of a file

Now Partner 2 makes a change to the first code chunk. Change
`summary(cars)` to a different function, e.g. `dim(cars)`. Then pull,
stage, commit, push

Partner 1 should not pull yet, but instead also make a change to that
first code chunk, so change `summary(cars)`, e.g. to `nrow(cars)`. Then
try to pull (will be rejected). Then stage, commit and pull.

This will result in a merge conflict. Resolve as described in Section
9.9
[here](http://ohi-science.org/data-science-training/collaborating.html#merge-conflicts).

<br>

## Your turn

1.  Have Partner 2 create and knit the `index.Rmd` file as described
    above, and push it to GitHub (pull, stage, commit, push)
2.  Check that your website is working
3.  Partner 1 should pull to make sure they get a local copy of the
    `index.Rmd` file
4.  Now each of you find an image online that you’d like to add (maybe a
    picture of a car?). Right click on it and select “copy image
    address”. The add it to the top of the `index.Rmd` with
    `![](url-to-image)`. Then knit the file.
5.  First Partner 1 should now push their changes to GitHub (pull,
    stage, commit, push)
6.  Then Partner 2 should try to push (pull, stage, commit, push). Do
    you get a merge conflict? Why / why not? If you got a merge
    conflict, Partner 2 should resolve it and push to GitHub. Please
    share your screen so both of you can talk through how you want to
    resolve the merge conflict.
7.  After the merge conflict has been resolved and pushed to GitHub,
    Partner 1 should pull to make sure you’re both up to date
8.  If you have time, make additional coordinated edits, so the other
    Partner gets the opportunity to resolve a merge conflict as well

<br>

## Jazzing up your website

Now let’s explore how we can expand our website by adding more tabs. We
do this by adding a configuration file that specifies the names of the
different tabs we want and which file we want to display on that tab.
We’ll start with simple example of a website that includes two pages
(Cars and About) and a navigation bar to switch between them. For that,
we need a configuration file `_site.yml`:

``` r
name: "my-website"
navbar:
  title: "Our Collaborative Website"
  left:
    - text: "Cars"
      href: index.html
    - text: "About"
      href: about.html
output_dir: "."
```

Partner 2 can create this file by choosing File -\> New File -\> Text
File in RStudio, copy in the above text and save as `_site.yml` (the
leading underscore is important here).

Then we need the two `.html` files that are going to be shown on the
tabs. We already have `index.html` (our knitted version of the
boilerplate .Rmd file we have played around with).

We need to create the `about.html`. Partner 1 can create a new RMarkdown
(File -\> New File -\> R Markdown…), change its title to “About” (this
is for the title in the YAML header of the .Rmd file, delete all the
boilerplate text under the setup code chunk and write a brief message
about the two of you. Save this as `about.Rmd` so we can render it into
the `about.html` that our configuration file refers to.

Now you can both pull, stage, commit, push and your changes should
merge. Make sure you both get up to date by pulling after you have both
pushed.

Now you’re ready to build your website.

From [R Markdown: The Definitive
Guide](https://bookdown.org/yihui/rmarkdown/rmarkdown-site.html#a-simple-example):

> Note that the minimum requirement for any R Markdown website is that
> it have an index.Rmd file as well as a \_site.yml file. If you execute
> the `rmarkdown::render_site()` function from within the directory
> containing the website, the following will occur:

> All of the *.Rmd and *.md files in the root website directory will be
> rendered into HTML. Note, however, that Markdown files beginning with
> \_ are not rendered (this is a convention to designate files that are
> to be included by top level Rmd documents as child documents).

> The generated HTML files and any supporting files (e.g., CSS and
> JavaScript) are copied into an output directory (\_site by default).
> \[Note that in our example we are asking to get our output in the
> top-level of the directory with `output_dir: "."`\]

> The HTML files within the \_site directory are now ready to deploy as
> a standalone static website.

> The full source code for the simple example above can be found in the
> hello-website folder in the repository
> <https://github.com/rstudio/rmarkdown-website-examples>.

Partner 1 can now build the website by running
`rmarkdown::render_site()`

Commit and push

Both Partners: Go to inspect your rendered website\!

Remember the format of the URL. For example:

  - my github repo: <https://github.com/jules32/collab-research>
  - my website url: <https://jules32.github.io/collab-research/>
  - note that the url starts with my **username.github.io**

Note that it may take a few minutes before your changes become active.
In the meantime, you can explore your current website content and design
in RStudio’s Viewer in the bottom left pane.

Make sure that the Partner who didn’t render the website locally pulls
the updated version from GitHub.

<br>

## Adding content and editing the website

Now, we want to add a table of contents and change the appearance of our
website. We can do this by changing the configuration file. Decide who
of you will make the following changes, render the website again, and
push.

Update your `_site.yml` file to:

``` r
name: "my-website"
navbar:
  title: "Our Collaborative Website"
  left:
    - text: "Cars"
      href: index.html
    - text: "About"
      href: about.html
output_dir: "."
output:
  html_document:
    theme: cerulean
    highlight: textmate
    toc: true 
    toc_float: true 
```

Note that we have changed the output theme and added a table of
contents.

Again, it will probably take a few minutes for your changes to become
active on your github.io page. We can inspect our changes in RStudio’s
Viewer in the bottom left pane in the meantime.

Make sure that the Partner who didn’t change the `_site.yml` file pulls
the updated version from GitHub.

Now play around with making additional changes to your website. You can
change the theme.

> The valid options to choose include default, cerulean, journal,
> flatly, darkly, readable, spacelab, united, cosmo, lumen, paper,
> sandstone, simplex, and yeti.

You can preview what each of these look like under the “themes” tab
[here](https://bootswatch.com/3/). Discuss with your Partner which one
you want to try next and who will be pushing the next edits.

You can also play around with the table of contents. For the table of
contents, you can specify what levels of headers you want include as
described
[here](https://bookdown.org/yihui/rmarkdown/html-document.html#table-of-contents).
In our initial `_site.yml` file, the table of contents depth is not
explicitly specified, so it defaults to 3 (meaning that all level 1, 2,
and 3 headers will be included in the table of contents). Try adding
some header levels to your index.Rmd or about.Rmd and see how the table
of contents change when you render the site and push the change to your
github.io site (the Viewer may not properly display all levels of the
table of contents, but the github.io site should).

You can also try adding another tab, either with a new .Rmd file you
create or for example adding your most recent homework or another
analysis file you have on hand.

If I want to add my answers to our exercises in lesson9, I’ll copy that
.Rmd file into my repo and add it as a new tab in my configuration file
(make sure the -text and href field are formatted exactly the same as
the other tabs)

``` r
name: "my-website"
navbar:
  title: "Our Collaborative Website"
  left:
    - text: "Cars"
      href: index.html
    - text: "About"
      href: about.html
    - text: "Answers"
      href: in_class_exercise_9_answers.html
output_dir: "."
output:
  html_document:
    theme: cerulean
    highlight: textmate
    toc: true 
    toc_float: true 
```

Then I re-build the website with `rmarkdown::render_site()` and push the
changes to GitHub.

<br>

## Your turn

Get creative\! You can find some ideas for things to try in [this
tutorial](https://jules32.github.io/rmarkdown-website-tutorial/getting_sophisticated.html),
or you can just try things
out.

<br>

<img src="https://pbs.twimg.com/media/Cf7eHZ1W4AEeZJA.jpg" height="400px" width="300px" />

<br>

Remember to coordinate with your partner. Work on different things in
parallel, but keep going back and forth pushing and pulling and
resolving any merge conflicts that arise.
