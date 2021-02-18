Assignment 2
================

## Create a Website using R Markdown and Github Pages

### Instructions: Please read through before you begin

#### This assignment is due by **10pm on Monday 10/05/20**.

  - Pair up with one classmate and exchange usernames of your personal
    Github accounts.

  - Each of you should create a new *public* repository in your personal
    Github account, name it **`assignment-2-netID`** (make sure to
    change to your netID, my repo will be `assignment-2-ma2256`), and
    initialize with a README file.

  - Navigate to the settings for your new Github repo, in the *Options*
    tab, scroll down to the Github Pages section and enable it by
    selecting the master branch of your repo as the source. Make sure
    the root folder is selected and hit save.

  - Clone this repository to your local computer through RStudio.

  - Create **TWO** RMarkdown files, choosing **HTML** as the output
    option. These files will be used to generate the pages of your
    website. The file that will render the landing page of your website
    must be named **`index.Rmd`**. Name the second file after yourself
    (first name is fine, unless you and your partner have the same first
    name, in which case make sure to name your files differently).
    
    1.  `index.Rmd`
    
    <!-- end list -->
    
      - This is the landing page of your website, make sure it includes
        the following:
          - A title
          - Your name and the name of your collaborator with links to
            your personal Github accounts
          - An image with a caption  
            <br>  
    
    <!-- end list -->
    
    2.  `maria.Rmd` (replace my name with yours)
    
    <!-- end list -->
    
      - This page should include the following:
          - Your first name as the title
          - An unordered list of some information about you, including
            at least 3 bullet points

  - Save and knit your two new files. In your git pane, you should see
    the following:
    
      - `assignment-2-ma2256.Rproj`
      - `.gitignore`
      - `index.Rmd`
      - `index.html`
      - `maria.Rmd`
      - `maria.html`

  - Sync back to Github, remembering to follow these steps:
    ![](https://nt246.github.io/NTRES6940-data-science/assets/commit_steps.png)

  - Check your repo on Github to make sure it synced properly.

  - Navigate to your repo settings on Github, select the *Manage access*
    tab and invite your collaborator.

  - Check your email (the one linked to your personal Github account) to
    accept an invitation from your collaborator.

  - Navigate to your partner’s repo on Github and clone their repository
    to your local computer through RStudio, just like you did your own.
    Once you have cloned their repo, copy over your `<name>.Rmd` file
    from your repo to theirs. You can do this by using the file finder
    on your computer: navigate to the local folder of your repo in
    Finder or Windows File Explorer, copy the file and paste it to the
    local folder of your partner’s repo. Once the file shows up in
    RStudio (make sure you are in the R project that corresponds to your
    collaborator’s repo), sync it back to Github.

  - Open your repo as a project in RStudio, **PULL** so that you are
    synced with your remote repo - your collaborator’s Rmarkdown file
    should now be in your local repo. Open it up and knit the file so
    that you can preview the HTML output. After this step, you can work
    independently from your partner to build your website.

  - Create a new **TEXT** file that will contain metadata for the
    website and save it as **`_site.yml`**. The `_site.yml` file should
    include the following information (update names):

<!-- end list -->

``` r
output_dir: "."
navbar:
  left:
    - text: "Home"
      href: index.html
    - text: "Maria"
      href: maria.html
    - text: "Nina"
      href: nina.html  
```

> **Optional:** We encourage you to update the appearance of your
> website by changing the output theme [(reviewed in
> Lesson 5)](https://nt246.github.io/NTRES6940-data-science/lesson5-collaboration-part2.html#jazzing_up_your_website).
> You may also include more content on your page(s), add more pages,
> [add and customize a table of contents to your
> page(s)](https://bookdown.org/yihui/rmarkdown/html-document.html#table-of-contents),
> and/or [add drop-down menus in your navigation
> bar](https://bookdown.org/yihui/rmarkdown/rmarkdown-site.html#site_navigation).
> **NOTE:** You are working independently at this point, so each of you
> can customize your website however you like.

  - In the RStudio console, run `rmarkdown::render_site()`.

  - Sync back to Github.

  - Open a browser and type the link for your website, for example,
    “<https://makopyan.github.io/assignment-2-ma2256>” (but with your
    GitHub username and repository name instead).

  - You do not need to submit anything for this assignment, we will
    review your work by accessing your website using your Github
    username and netID. Please make sure to have your website ready by
    10pm on Monday 10/05/20.
