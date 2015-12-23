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

That will give me my own local develop branch that is set up to `track` the upstream/develop branch (and staging too).  But, I still do not want to commit directly to the develop branch since that is one of the main branches.  So, I will create a `topic` branch to which I will commit related changes.

```
git checkout -b fixing-build-artifacts
```

At that point, I can make changes to source code and commit my changes to the `fixing-build-artifacts` branch.  Now, after I have all my changes committed.  I can then push my topic branch up to Github so that I can create a pull request to merge those changes into the `develop` branch for testing.  This is how you do that:
```
git push -u origin fixing-build-artifacts
```

Now that I have pushed my topic branch up to github, I can then go to the github site and navigate to the landing page of my fork of the repo.  From there, I can select the fixing-build-artifacts branch from the drop-down (an inch or two below the <> Code tab) and then click `New pull request`.  The `base repository` is going to default to the `base fork` which will be the booz-allen-epa-agile-rfi master branch.  However, as a matter of practice, you should first merge into your own target branch (whether it is the Develop branch, Staging branch or Master).  That is because you do not want those to get out of sync with everything else.  

After you merge your topic branch into your local develop branch, you can then create a second pull request against the booz-allen-epa-agile-rfi develop branch.  

This cycle will repeat for as many topic branches that you need.  However, after a while, your own fork of the project will get out of sync since there are other people following the same process.  Whenver you want to get synced back up with the upstream fork, run these commands:

```
git checkout master
git pull origin master
git fetch upstream
git rebase upstream/master
git push -u origin master
```
What that will do is fetch all the latest changes in the remote repository so that they are available for local git operations.  The `rebase` command will rewind all of you local commits to a point of synchronicity with the remote master, then replay the remote master's commits as well as your own local commits back onto your local master branch.  At that point, you will be ahead of your origin master, so you then need to push back up to your origin master to be fully in sync.

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

