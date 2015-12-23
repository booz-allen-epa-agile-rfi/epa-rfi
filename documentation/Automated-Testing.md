#Automated Testing

In order to maintain healthy code among the team, any team shared code was subjected to rigorous automated tests on various perspectives of quality, including code, security, performance, and functionality. Tests were executed automatically as developers submitted code to the repository. Feedback was made available to developers within minutes of the submission on a variety of criteria explained below. If all tests were successful a deployment was automatically initiated and available for review on the appropriate environment.

![updated automated testing process](https://cloud.githubusercontent.com/assets/16209237/11907406/939893b2-a5a1-11e5-9223-a751431c59f6.png)


For more information on how the tests were executed in the build process please refer to the [api](https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/bin/jenkins/TEMPLATE_API_UNIT_TESTS.sh) and [front end](https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/bin/jenkins/TEMPLATE_FRONTEND_UNIT_TESTS.sh) shell scripts. 

For more information on how builds were created and deployed please refer to the [api](https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/bin/jenkins/TEMPLATE_API_JOB.sh) and [front end](https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/bin/jenkins/TEMPLATE_FRONTEND_JOB.sh) shell scripts.

### Create unit and integration tests to verify modules and components
***
- [rSpec](https://github.com/rspec)-
Ruby unit and integration testing, check out our [api tests](https://github.com/booz-allen-epa-agile-rfi/epa-rfi/tree/master/api/spec). 

These tests were used to validate business logic in the backend that was serving up useful information to our front end through a RESTful interface. Integration is accomplished through associating a database service with rails and executing only transactional events. Test execution is done using the `rspec` command.

### Create automated tests that verify all user-facing functionality
***
- [Karma](https://github.com/karma-runner/karma)-
JavaScript functional tests, checkout out our [front end tests](https://github.com/booz-allen-epa-agile-rfi/epa-rfi/tree/master/www/test/spec/controllers)

These tests validate the user facing functionality of the site. PhantomJS is used to execute the tests in a headless browser environment to increase speed. Jasmine is also used to provide a full featured testing harness and clean readability. Execution is orchestrated through a Grunt task.

### Conduct load and performance tests at regular intervals, including before public launch
***
- [bees with machineguns](https://github.com/newsapps/beeswithmachineguns)-
distributed AWS load testing, run by one-click [Jenkins Shell Script](https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/bin/jenkins/develop_frontend-load_testing.sh) on an ad-hoc basis by the developers discretion. This tool helps provision EC2 instances with agents that will generate load on identified endpoints.

- [grunt-devperf](https://github.com/gmetais/grunt-devperf)-
Grunt task that uses PhantomJS to launch areas of the site and review a variety of performance metrics that can be compared to budgeted performance goals. Warnings and other alerts will be presented to help identify areas of performance improvement. [example report from Jenkins](https://jenkins.treeview.io/job/master_frontend/lastSuccessfulBuild/artifact/reports/tests/tests/results/index.html)


### Execute static analysis and security scans
***
- [Brakeman](https://github.com/presidentbeef/brakeman)-
static code analysis focusing on security threats for Ruby source code, run after push to develop and release

- [RuboCop](https://github.com/bbatsov/rubocop)-
static code quality analysis for Ruby source code, run after push to develop and release



