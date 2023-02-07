Assignment 3
================

## Create a Website using R Markdown and Github Pages

<br>

### Instructions: Please read through before you begin

#### This assignment is due by **10pm on Thursday 02/16/23**.

Pair up with the classmate you worked with during lecture 5 and exchange
usernames of your personal Github accounts. If you missed lecture 5 or
for other reasons need a partner, let us know. You will have to
coordinate to do the first part of this exercise together; the second
part you can each do individually (but you’re also welcome to
collaborate!)

**Each of you** should complete the following steps:

- Create a new *public* repository in your personal Github account, name
  it **`assignment-3-NetID`** (make sure to change to your NetID, Nina’s
  repo will be `assignment-3-nt246`), and initialize with a README file.

- Navigate to the settings for your new Github repo, in the *Options*
  tab, scroll down to the Github Pages section and enable it by
  selecting the main branch of your repo as the source. Make sure the
  root folder is selected and hit save.

- Clone this repository to your local computer through RStudio.

- Create **TWO** RMarkdown files, choosing **HTML** as the output
  option. These files will be used to generate the pages of your
  website. The file that will render the landing page of your website
  must be named **`index.Rmd`**. Name the second file after yourself
  (first name is fine, unless you and your partner have the same first
  name, in which case make sure to name your files differently).

  **`index.Rmd`**

  - This is the landing page of your website, make sure it includes the
    following:
    - A title
    - Your name and the name of your collaborator with links to your
      personal Github accounts
    - An image with a caption  
      <br>

  **`nina.Rmd`** (replace my name with yours)

  - This page should include the following:
    - Your first name as the title
    - An unordered list of some information about you, including at
      least 3 bullet points

- Save and knit your two new files. In your git pane, you should see the
  following:

  - `assignment-3-nt246.Rproj`
  - `.gitignore`
  - `index.Rmd`
  - `index.html`
  - `nina.Rmd`
  - `nina.html`

- Sync back to Github, remembering to follow these steps:
  ![](https://nt246.github.io/NTRES6940-data-science/assets/commit_steps.png)

- Check your repo on Github to make sure it synced properly.

- Navigate to your repo settings on Github, select the *Manage access*
  tab and invite your collaborator.

- Check your email (the one linked to your personal Github account) to
  accept an invitation from your collaborator.

- Navigate to your partner’s repo on Github and clone their repository
  to your local computer through RStudio, just like you did your own.
  Once you have cloned their repo, copy over your `<name>.Rmd` file from
  your repo to theirs. You can do this by using the file finder on your
  computer: navigate to the local folder of your repo in Finder or
  Windows File Explorer, copy the file and paste it to the local folder
  of your partner’s repo. Once the file shows up in RStudio (make sure
  you are in the R project that corresponds to your collaborator’s
  repo), sync it back to Github.

- Open your repo as a project in RStudio, **PULL** so that you are
  synced with your remote repo - your collaborator’s Rmarkdown file
  should now be in your local repo. Open it up and knit the file so that
  you can preview the HTML output. After this step, you can work
  independently from your partner to build your website (but feel free
  to work together for the rest of the assignment).

- Create a new **TEXT** file that will contain metadata for the website
  and save it as **`_site.yml`**. The `_site.yml` file should include
  the following information (update the file names to correspond to your
  files):

``` r
output_dir: "."
navbar:
  left:
    - text: "Home"
      href: index.html
    - text: "Nina"
      href: nina.html
    - text: "Nicolas"
      href: nicolas.html  
```

<br>

- In the RStudio console, run `rmarkdown::render_site()`.

- Sync back to Github.

- Open a browser and type the link for your website, for example,
  “<https://nt246.github.io/assignment-3-nt246>” (but with your GitHub
  username and repository name instead).

<br>

> This minimal setup satisfies the requirements for the assignment.
> However, we strongly encourage you to update the appearance of your
> website by changing the output theme [(reviewed in Lesson
> 5)](https://nt246.github.io/NTRES-6100-data-science/lesson5-collaboration-part2.html#Adding_content_and_editing_the_website).
> You may also include more content on your page(s), add more pages,
> [add and customize a table of contents to your
> page(s)](https://bookdown.org/yihui/rmarkdown/html-document.html#table-of-contents),
> and/or [add drop-down menus in your navigation
> bar](https://bookdown.org/yihui/rmarkdown/rmarkdown-site.html#site-navigation).
> **NOTE:** You are working independently at this point, so each of you
> can customize your website however you like.

<br>

To submit, paste the URL to your website to the README file in your
course repo. Below the table used to record grades, please type

`Assignment 3: URL-to-website` \[replacing `URL-to-website` with the
actual URL to your published website\].

We will look at your website, and from its URL, we can find the
associated repo and examine your commit history to confirm that your
partner successfully pushed a page to your site.

**Please make sure to have your website ready and have posted the URL by
10pm on Thursday 02/16/23**.
