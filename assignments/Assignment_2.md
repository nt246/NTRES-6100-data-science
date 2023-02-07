Assignment 2
================

<br>

## Put one of your pre-existing projects on GitHub

In this assignment, you will bring one of your pre-existing projects
into the Git/GitHub and RStudio universe so you can start adopting
version control and dynamic report generation (RMarkdown) in your own
work right away. Below, we’ll guide you through the setup step by step.
There are other, perhaps more elegant, ways to add version control to a
pre-existing project, but we will use the approach described below
because it works well and lets us work through RStudio so we won’t need
to use command line to interact with Git. If you don’t have a project
that you feel is suitable for GitHub version control, you can set up a
hypothetical research project repo instead and create a few hypothetical
script and data files.

#### This assignment is due by **10pm on Thursday 2/9/2023**.

To submit, paste the URL to the new project GitHub repo you will create
here to the README file in your course repo. Below the table used to
record grades, please type

`Lab 2: URL-to-repo` \[replacing `URL-to-repo` with the actual URL to
your repo\].

<br>

#### Acknowledgements

These instructions are adapted from three sources:

- [Chapter 16 of Happy Git with
  R](https://happygitwithr.com/existing-github-first.html) by Jenny
  Bryan
- [FISH 497: Introduction to Environmental Data
  Science](https://fish497.github.io/website/homework/week_01/hw_01_github_remotes.html)
  by Mark Scheuerell
- [Git and Github for Advanced Ecological Data
  Analysis](https://afredston.github.io/learn-git/learn-git.html#1_Introduction)
  by Alexa Fredston

<br>

## Task 1: Select a project to put on GitHub

Decide which of your current projects you want to create a GitHub repo
for. GitHub works best for tracking plain text files, so consider
choosing a project for which you have some scripts and data files. If
you don’t have any projects like that yet, you can think up a fictional
project.

<br>

------------------------------------------------------------------------

## Task 2: Make a repo on GitHub

Decide what you want to call the GitHub repository that will host your
project. Select a short and descriptive name without spaces (you can use
“-” or “\_” in place of spaces if you want a multi-word name). Create a
new repository on **GitHub** with that name. When setting up your repo,
select the following features:

- Make the repo **Private**

- Add a `README.md`

- Just leave the `Add .gitignore` and “Choose license” boxes unchecked.

<br>

------------------------------------------------------------------------

## Task 3: Invite Katie (our grader) as a collaborator to allow grading

Your repo is now ready. Since you made it private, only you can see it,
so don’t worry about putting data and results up there. It will only be
visible to people you explicitly invite as collaborators.

To show us that you have completed the assignment, you will therefore
need to add Katie as a collaborator temporarily. Once he has had a
chance to review your setup, you can revoke his collaborator privileges
so he won’t have continued access.

To give Katie access:

- Click on the “Settings” tab

- Click on “Collaborators” from the menu on the left

- Click on the green button labeled **Add people** (note that you may be
  prompted to enter your **GitHub** password)

- In the search box that appears, type `kld93` and select Katie Duggan’s
  name/username

- Click on the green button that says **Add kld93 to this repository**

<br>

------------------------------------------------------------------------

## Task 4: Clone the repo by creating an associated RStudio project

Create a new project in **RStudio** with a connection to the **GitHub**
repo you just created. Remember that we strongly recommend that you put
this project folder in a location not under some other form of version
control (e.g. Box, Dropbox, or Google Docs). A great location is to
create your project as a subfolder of a directory called `github` that
lives in your root (“home”) directory (i.e. `~/github/`)

<br>

------------------------------------------------------------------------

## Task 5: Organize your project folder and copy your existing project files over

On your local computer (i.e. not on the GitHub web interface), create a
series of sub-directories that will help you organize your files in the
folder you cloned your repo into (i.e. where your `.Rproj` and
`README.md` live). Different projects will have different types of
files, but a good place to start would be creating the following
sub-directories:

- `raw-data`
- `scripts`
- `processed-data`
- `results`
- `figures`
- `rmarkdowns`

You can make these sub-directories either by clicking “New Folder” in
the “Files” tab in RStudio, or with your computer’s file browser, like
Finder on a Mac). **Make at least four subdirectories of your choice.**

Now, using your favorite method of moving or copying files, **copy** all
the files that constitute your existing project (your code and data
etc.) into the appropriate sub-directory for this new project (keep your
original copy for now to not disrupt any dependencies of local paths in
your current workflow). If you’re not copying a specific project, you
can just add random files (e.g. an image saved from the internet, a text
file with a few lines of text etc.).

Here’s one suggestion for organizing the content of sub-directories, but
feel free to adapt to your particular needs:

- `raw-data`: external data that you haven’t edited, like original
  datasets you collected, got from collaborators, or downloaded.
  Sometimes these have long file names or are super large or are
  otherwise gnarly; that’s OK.
- `scripts`: all of your scripts for data analysis or processing
- `processed-data`: data produced by R scripts, e.g., cleaned, tidied,
  or summarized for analysis (this may be empty right now, that’s OK!)
- `results`: output results from your analysis, like model summary
  files, tables etc (this may be empty right now, that’s OK!)
- `figures`: images generated by R scripts that create plots (this may
  be empty right now, that’s OK!)
- `rmarkdown`: RMarkdown files (e.g. reports or analysis logs) that help
  you keep track of your analysis and outputs

Why are we doing this? A well-organized repository will make it much
easier for you to keep track of your data, analysis, and results, and
will also facilitate version control.

<br>

------------------------------------------------------------------------

## Task 6: Decide what files to push to GitHub

There are no absolute rules about what types of files should be sync’ed
on GitHub and which should not. If you only have code and relatively
small data files and outputs like plots and small image files (\<100 Mb)
in your repo, you should just go ahead and push it all to GitHub.

If you have large files, or files that Git can’t version control
(e.g. binary files like Word documents), you may consider just keeping
these files local and not pushing them to GitHub. You can do this by
adding them to your `.gitignore` file.

Find guidance on what files to push to GitHub, see Section 10 of Jenny
Bryan’s [Excuse me, do you have a moment to talk about version
control?](https://peerj.com/preprints/3159/).

One important thing to note is that GitHub has a file size limit of 100
Mb - you will not be able to push if your commit includes files larger
than this size. GitHub also recommends that you ideally keep the total
size of your repo smaller than 1 Gb and definitely less than 5 Gb. So
find a different way to back up really large files and use GitHub
primarily for text-based or figure files (most of which are likely
*much* smaller than 100 Mb).

<br>

------------------------------------------------------------------------

## Task 7: Push your local changes to GitHub

In RStudio, consult the Git pane and the file browser.

- Are you seeing all the files? They should be here if your copy was
  successful.
- Are they showing up in the Git pane with questions marks? They should
  be appearing as new untracked files.

Stage, commit and push your changes to GitHub.

<br>

------------------------------------------------------------------------

## Task 8: Confirm the local change propagated to the GitHub remote

Go back to the browser and refresh the page with your new GitHub repo.

Refresh.

You should see all the project files you committed there.

If you click on “Commits,” you should see one with the message “init”.

<br>

------------------------------------------------------------------------

## Task 9: Make some local changes and then push your local changes to GitHub

Now that you have your project on GitHub, add some helpful information
about your project to the README file (the “landing page” we’ll see when
we click on our repo on GitHub). Open the `README.md` file in RStudio.
Add a few lines describing your project and what files are in your repo.
Push those changes to GitHub.
