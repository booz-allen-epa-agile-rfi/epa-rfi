This  page demonstrates how we used U.S. Digital Services Playbook to define our process for this prototype.

### **[DIGITAL SERVICE PLAY 1: Understand what people need](https://playbook.cio.gov/#play1)** ###


_- Early in the project, spend time with current and prospective users of the service:_

Interviewed Subject Matter Experts (SME) who know the EPA data well (including Booz Allen leaders and supporting staff who work in the EPA market, randomly selected end users, and team's Product Owner)

_- Use a range of qualitative and quantitative research methods to determine people’s goals, needs, and behaviors; be thoughtful about the time spent_

Used Lean UX based research methods including visioning, dot voting, ideation sketching, persona sketching, and  Journey Maps.
For more details:
 
https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Human-Centered-Design.md

_- Test prototypes of solutions with real people, in the field if possible:_

During and at the end of sprints (either in person or virtually using Zoom.us) , tested the prototypes (wireframes, mockups, working code) with our SMEs, and randomly selected users. 

_- Document the findings about user goals, needs, behaviors, and preferences_

Finding documented as agile artifacts:
User stories: https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/User-Stories.md

Other agile artifacts: http://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Agile-Artifacts.md

_- Share findings with the team and agency leadership_

http://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Agile-Artifacts.md

_- Create a prioritized list of tasks the user is trying to accomplish, also known as "user stories"_

User stories: https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/User-Stories.md

Prioritization is done during the first sprint for the release plan. At the sprint planning meetings, we reviewed the plan and re-planned and prioritized based on what we have learned and achieved in the previous sprint. All of the sprint plan:

http://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Agile-Artifacts.md

_- As the digital service is being built, regularly test it with potential users to ensure it meets people’s needs_

Yes. During every sprint feedback is received from a selection of SMEs, end users and Product Owner

### **[DIGITAL SERVICE PLAY 2: Address the whole experience, from start to finish](https://playbook.cio.gov/#play2)** ###


_- Understand the different points at which people will interact with the service – both online and in person_

Currently, the data resides in a database and is accessible in some ways through a map, but not with the second level of data to identify effects, impacts, etc. based on the data.

_- Identify pain points in the current way users interact with the service, and prioritize these according to user needs_

Identified the pain points during ideation sessions at first sprint. Based on the pain points, the user stories for the digital service have been documented and prioritized 

_- Design the digital parts of the service so that they are integrated with the offline touch points people use to interact with the service_

Not Applicable for the prototype

_- Develop metrics that will measure how well the service is meeting user needs at each step of the service_

Not scoped for the prototype (the MVP), but included in the product roadmap.

###**[DIGITAL SERVICE PLAY 3. Make it simple and intuitive](https://playbook.cio.gov/#play3)**###

_- Create or use an existing, simple, and flexible design style guide for the service_

**Our design guide:**

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Style-Guide.md

_- Use the design style guide consistently for related digital services_

Design Guide is in our repo and all of our developers are coding based on the style guide. We check the styles during usability tests

_- Give users clear information about where they are in each step of the process_

We have a content strategist on the team. This person's role is to ensure that we provide the most impactful message to the user including letting the user know where they are in the process.

_- Follow accessibility best practices to ensure all people can use the service_

Under normal circumstance, the site will be compliant to section 508 accessibility specification and the compliance tests are part of our development practices, but not formally tested for it. At the time of the submission, the site is partially compliant. Full compliance have not been achieved due to the short duration of the prototype.

_- Provide users with a way to exit and return later to complete the process_

Not applicable to the scope. We do not provide user login and authentication. 

_- Use language that is familiar to the user and easy to understand_

We utilized SMEs working in the EPA OEI during ideation and usability testing. We made sure that the language used is easily understood and does not conflict with the EPA data set. 

_- Use language and design consistently throughout the service, including online and offline touch points_

Consistency check was part of our usability test.

###**[DIGITAL SERVICE PLAY 4. Build the service using agile and iterative practices](https://playbook.cio.gov/#play4)**###

Our agile practices that we used on this prototype can be seen at the following URL:

http://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Agile-Artifacts.md

_- Ship a functioning “minimum viable product” (MVP) that solves a core user need as soon as possible, no longer than three months from the beginning of the project, using a “beta” or “test” period if needed_

Our prototype is the MVP, a functioning solution we would go live with. During the 6 days of development, we achieved a pre-MVP in the middle of the release cycle.

_- Run usability tests frequently to see how well the service works and identify improvements that should be made_

We perform usability tests every iteration.

_- Ensure the individuals building the service communicate closely using techniques such as launch meetings, war rooms, daily standups, and team chat tools_

All of our agile practices like standups are in our agile documentation. Our sprints started at 3 hours long. We start a sprint with a sprint planning meeting with the whole team.  On Day 2, we identified that large work products take larger chunks of time and adjusted Sprints for the entire day with a closeout, retrospective, and planning in the morning.  The development team is distributed across 4 time zones and we use Slack as our internal persistent communication tool, Zoom.US as our persistent video chat tool, Google hangout for ad-hoc discussions, and waffle.io for Sprint Planning and tracking. 

_- Keep delivery teams small and focused; limit organizational layers that separate these teams from the business owners_

For this prototype, we have a small delivery team. Sometimes, for larger projects, we use multi-team agile practices so that the team could stay focused to the scope.

_- Release features and improvements multiple times each month_

We will use DevOps Continuous Delivery practice to delivery features and improvements to production. The frequency of production deployments depends on the timing achieving "Definition of Done" for the features, improvements or fixes. The details of our DevOps process can be seen in our repo:
https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/DevOps-Process.md

_- Create a prioritized list of features and bugs, also known as the “feature backlog” and “bug backlog”_

For this short prototyping effort:

We use waffle.io for issue tracking and because it easily integrated with GitHub. 

_- Use a source code version control system_

We use GitHub.

_- Give the entire project team access to the issue tracker and version control system_

Everyone on the team has access to GitHub and its issue tracker.

_- Use code reviews to ensure quality_

###**[DIGITAL SERVICE PLAY 5. Structure budgets and contracts to support delivery](https://playbook.cio.gov/#play5)**###

Not applicable. This prototype effort is our response to EPA OEI RFI. 

###**[DIGITAL SERVICE PLAY 6. Assign one leader and hold that person accountable](https://playbook.cio.gov/#play6)**###

_- A product owner has been identified_

Our product owner is George Patch. He is responsible for the scope. After the RFQ is out, we had ideation and human-centered design activities ( https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Human-Centered-Design.md ), and during sprint one, we identified the idea and scope. After George thumbs up as the product owner, we built out our sprints and prioritized tasks. 

_- All stakeholders agree that the product owner has the authority to assign tasks and make decisions about features and technical implementation details_

Since this is a project for an RFI response, our stakeholders are the Product Owner, our SMEs from EPA market, data scientists and randomly selected users. We included these stakeholders when we selected George as the Product Owner for this prototype.

_- The product owner has a product management background with technical experience to assess alternatives and weigh tradeoffs_

George Patch (our product owner) has been in Software Development business for over 15 years. He has been managing products that we develop for our customers. He also has engineering background and understands agile methodologies.

_- The product owner has a work plan that includes budget estimates and identifies funding sources_

The budget for this prototype has been designed based on our previous experience. We have been attending hackathon's and tech challenges, which gave us insight how our multi-disciplined team would be designed and what would the team velocity be. Based on this metrics and what we have learned, our product owner designed a work plan and budget for this prototyping effort. 

_- The product owner has a strong relationship with the contracting officer_

Not applicable. This is an RFI.

###**[DIGITAL SERVICE PLAY 7. Bring in experienced teams](https://playbook.cio.gov/#play7)**###

Booz Allen software developers are part of our System Development Group (SDG), regardless which market or cross-cut they support. The advantage of this structure is to learn and continuously improve. We have reusable best practices, checklists, playbooks that help us to standup a self-organizing teams quickly. 

_- Member(s) of the team have experience building popular, high-traffic digital services_

When the RFI was released, all of the members of the team were pulled from their current digital service development projects. 

_- Member(s) of the team have experience designing mobile and web applications_

Our designers are front end developers are part of our Digital organization and they design responsive web applications and mobile apps. 

_- Member(s) of the team have experience using automated testing frameworks_

 Our automated testing frameworks we use for this prototype can be seen on the following  page:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Automated-Testing.md

All of our automated tests are integrated to our DevOps Git Flow:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/DevOps-Process.md

_- Member(s) of the team have experience with modern development and operations (DevOps) techniques like continuous integration and continuous deployment_

Yes. Our developers and engineers are using Booz Allen's DevOps practices. For this prototype, we use our Docker Machine based automation for continuous deployment and Jenkins for continuous integration.

_- Member(s) of the team have experience securing digital services_

All members of the team work on Government contracts that require securing digital services. Team members have experience in secure coding practices and use tools to test security as part of our agile development. In addition to the code reviews we perform against the coding practices, we also have integrated automated security testing to our DevOps flow.

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/DevOps-Process.md

![agile_diagram_2_with_arrow](https://cloud.githubusercontent.com/assets/16209237/11965865/aa23a7da-a8c5-11e5-892b-f6aa65c7337a.png)


_- A Federal contracting officer is on the internal team if a third party will be used for development work_

Not Applicable.

_- A Federal budget officer is on the internal team or is a partner_

Not Applicable

_- The appropriate privacy, civil liberties, and/or legal advisor for the department or agency is a partner_

Booz Allen does have legal team at the service of software development teams supporting teams for PII, other privacy, civil liberties and other topics require legal advice.  For the sake of the short turnaround prototype, we perform peer reviews on the content for this purpose.

###**[DIGITAL SERVICE PLAY 8. Choose a modern technology stack](https://playbook.cio.gov/#play8)**###

_- Choose software frameworks that are commonly used by private-sector companies creating similar services_

We use modern frameworks used leading web sites. The details of the application stack can be seen at the following page:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Architecture-Diagrams.md

_- Whenever possible, ensure that software can be deployed on a variety of commodity hardware types_

All environments are on AWS

_- Ensure that each project has clear, understandable instructions for setting up a local development environment, and that team members can be quickly added or removed from projects_

See our developer quick start guide for this effort:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Developer-Getting-Started-Guide.md

_- Consider open source software solutions at every layer of the stack_

Our full stack is open source:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Architecture-Diagrams.md

###**[DIGITAL SERVICE PLAY 9. Deploy in a flexible hosting environment](https://playbook.cio.gov/#play9)**###

Our hosting environment is Amazon Web Services (AWS) public cloud. The infrastructure diagram which includes our security can be seen below:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Architecture-Diagrams.md

_- Resources are provisioned on demand_

![git flow diagram](https://cloud.githubusercontent.com/assets/16209237/11966053/2a63580e-a8c7-11e5-9ae1-9c73e212b2bf.png)
We have 4 environments, which match to our git flow and GitHub branch structure. All resources on these environments can be provisioned on demand using our Docker Machine:

_- Resources scale based on real-time user demand_

We setup the continuous monitoring with the capabilities that reads the server stats including CPU and Memory usage. Spinning up and down will be controlled by the triggers from the monitoring services, enable by our Docker containerization and DevOps Git Flow.

_- Resources are provisioned through an API_

Yes. We use AWS CloudFormation APIs

_- Resources are available in multiple regions_

Currently we use AWS East Region and two availability zones (B and D) for this prototype. Our application is stateless and can easily be deployed to other AWS region and we would use AWS Route 53 DNS for wide area load balancing. Amazon Route 53 makes it possible for you to manage traffic globally through a variety of routing types, including Latency Based Routing, Geo DNS, and Weighted Round Robin—all of which can be combined with DNS Failover in order to enable a variety of low-latency, fault-tolerant architectures.

_- We only pay for resources we use_

We pay for all resources per hour of use.

_- Static assets are served through a content delivery network_

Currently they are on AWS S3 storage but will be moved to AWS Cloud Front.

_- Application is hosted on commodity hardware_

Yes, AWS.

###**[DIGITAL SERVICE PLAY 10. Automate testing and deployments](https://playbook.cio.gov/#play10)**###

See the following page for our test automation:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Automated-Testing.md

_- Create automated tests that verify all user-facing functionality_

We have mechanisms to test all of the UI interface in place and we built representative UI tests for the sake of the prototype

_- Create unit and integration tests to verify modules and components_

Yes, see the above  page for details. Both front-end and back-end are tested using open source testing frameworks. 

_- Run tests automatically as part of the build process_

All automated test are triggered by the Continuous Integration and Continuous Deployment capabilities of our DevOps Git Flow.

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/DevOps-Process.md

_- Perform deployments automatically with deployment scripts, continuous delivery services, or similar techniques_

Yes, all deployments are performed automatically by Docker Machine.

_- Conduct load and performance tests at regular intervals, including before public launch_

Yes. See : https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Automated-Testing.md

###**[DIGITAL SERVICE PLAY 11. Manage security and privacy through reusable processes](https://playbook.cio.gov/#play11)**###

_- Contact the appropriate privacy or legal officer of the department or agency to determine whether a System of Records Notice (SORN), Privacy Impact Assessment, or other review should be conducted_
 _- Determine, in consultation with a records officer, what data is collected and why, how it is used or shared, how it is stored and secured, and how long it is kept_
 _- Determine, in consultation with a privacy specialist, whether and how users are notified about how personal information is collected and used, including whether a privacy policy is needed and where it should appear, and how users will be notified in the event of a security breach_
 _- Consider whether the user should be able to access, delete, or remove their information from the service_
_“Pre-certify” the hosting infrastructure used for the project using FedRAMP_

Our infrastructure is on AWS and already FedRAMPed:

http://aws.amazon.com/compliance/


_- Use deployment scripts to ensure configuration of production environment remains consistent and controllable_

The configuration of all of the environments are the same, designed using Docker technologies

###**[DIGITAL SERVICE PLAY 12. Use data to drive decisions](https://playbook.cio.gov/#play12)**###

Yes. See below page:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Continuous-Monitoring.md

_- Monitor system-level resource utilization in real time_
 _- Monitor system performance in real-time (e.g. response time, latency, throughput, and error rates)_
 _- Ensure monitoring can measure median, 95th percentile, and 98th percentile performance_
 _- Create automated alerts based on this monitoring_
 _- Track concurrent users in real-time, and monitor user behaviors in the aggregate to determine how well the service meets user needs_
 _- Publish metrics internally_
 _- Publish metrics externally_
 _- Use an experimentation tool that supports multivariate testing in production_

###**[DIGITAL SERVICE PLAY 13. Default to open](https://playbook.cio.gov/#play13)**###

_- Offer users a mechanism to report bugs and issues, and be responsive to these reports_

We use Git Issues for bug tracking:

https://github.com/booz-allen-epa-agile-rfi/epa-rfi/blob/master/documentation/Automated-Testing.md

_- Provide datasets to the public, in their entirety, through bulk downloads and APIs (application programming interfaces)_

Our back-end design is API centered. Our Front-End calls the back-end functionality using these APIs. We will expose some of these APIs for external use. 

The API documentation can we seen on each application server at the following URL:

http://api.treeview.io

_- Ensure that data from the service is explicitly in the public domain, and that rights are waived globally via an international public domain dedication, such as the “Creative Commons Zero” waiver_

The source code and data from the service is open source and in public domain. 

_- Catalog data in the agency’s enterprise data inventory and add any public datasets to the agency’s public data listing_

All user generated data by our service is exposed with a public  API

_- Ensure that we maintain the rights to all data developed by third parties in a manner that is releasable and reusable at no cost to the public_

The data generated is open source

_- Ensure that we maintain contractual rights to all custom software developed by third parties in a manner that is publishable and reusable at no cost_
 _- When appropriate, create an API for third parties and internal users to interact with the service directly_
 _- When appropriate, publish source code of projects or components online_
 _- When appropriate, share your development process and progress publicly_
