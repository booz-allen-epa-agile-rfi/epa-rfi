## GIT process to help keep the branches clean and synchronized.

First, create your own fork of this repo by clicking the 'Fork' button in the top right-hand corner of the landing page.

After you have your own fork, you can then clone `your own` fork to begin the process of contributing.

At that point, you will want to do all of your work in separate `topic` branches.

Here is an example:

```
sudo git clone https://github.com/dcarrith/epa-rfi.git
cd epa-rfi
sudo chown -R user:group .
git remote add upstream https://github.com/booz-allen-epa-agile-rfi/epa-rfi.git
git fetch upstream
git checkout -b develop upstream/develop
git checkout -b staging upstream/staging
```

That will give you your own local develop branch that is set up to `track` the upstream/develop branch (and staging too).  But, you still do not want to commit directly to the develop branch since that is one of the main branches.  So, anytime you have something to contribute, create a new `topic` branch to which you can commit related changes. For example:

```
git checkout -b fixing-build-artifacts
```
At that point, You can make changes directly to existing files or create or remove files and then commit the changes to the `fixing-build-artifacts` branch.  Now, after you have all changes committed, you can then push the topic branch up to Github so that you can create a pull request to merge those changes into the `develop` branch for testing.  For example:
```
git push -u origin fixing-build-artifacts
```
Now that the topic branch has been pushed up to github, you can then go navigate to the landing page of your fork of the repo.  From there, you can select the `fixing-build-artifacts` branch from the drop-down (an inch or two below the <> Code tab) and then click `New pull request`.  The `base repository` is going to default to the `base fork` which will be the `booz-allen-epa-agile-rfi` master branch.  However, as a matter of practice, you should first merge into your own target branch (whether it is the `develop` branch, `staging` branch or `master`).  That is because you do not want those to get out of sync with everything else.  

After you merge your topic branch into your local develop branch, you can then create a second pull request against the booz-allen-epa-agile-rfi develop branch.

This cycle will repeat for as many topic branches that you need.  However, after a while, your own fork of the project will get out of sync since there are other people following the same process.  Whenver you want to get synced back up with the upstream repository, run these commands:

```
git checkout master
git pull origin master
git fetch upstream
git rebase upstream/master
git push -u origin master
```
That will fetch all the latest changes in the remote repository so that they are available to the local git repository.  The `rebase` command will rewind all of your local commits to a point of synchronicity with the remote master, then replay the remote master's commits, as well as your own local commits, back onto your local master branch.  At that point, you will be ahead of your origin master (the one on github) so you then need to push back up to your `origin master` to be fully synchronized.

To get your other main branches back in sync with their respective upstream branches, you do the same thing.

```
git checkout develop
git pull origin develop
git fetch upstream
git rebase upstream/develop
git push -u origin develop

git checkout staging
git pull origin staging
git fetch upstream
git rebase upstream/staging
git push -u origin staging
```

