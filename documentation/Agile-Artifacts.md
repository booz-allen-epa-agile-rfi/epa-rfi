![agile_process_v1](https://cloud.githubusercontent.com/assets/12210910/8392521/1186de50-1cb3-11e5-8be1-594f4bc00538.png)

**Our Agile Process**

We executed this challenge with an agile approach, delivering working software daily, and building in a culture of inspect-and-adapt. 

We set an initial plan to work for 3 days as a whole team, then make a team decision how to proceed -- did we feel the solution was good enough, 
and we could close the project? Or did we want to proceed with further development?

We had an part-time agile coach to help guide our process and encourage whole-team collaboration. 

**Sprint Zero**

Before we began core development, we spent a couple of days in our Sprint 0: forming the team,
setting up our development environment, exploring the dataset, and going through initial ideation with user-centered design techniques. 

We also set up sufficient technology to keep us collaborating throughout the process, despite the fact that team members
were gegraphically distributed. To aid in this, we kept up a Zoom video call throughout the development period, Slack for team messaging and sharing, and 
task-tracking via Waffle.io/GitHub.

**Basic  Schedule**
Day 1 (Wed) was characterized with two sprints, of 3 hours each, each ending in a demo, as well as a retrospective for the end of the day.  

In Day 2 (Thurs), the team decided that planning a single sprint for the day would be a more effective strategy, with numerous cross-team synchronizations and meetings occurring 
within.

Day 3 (Fri) began with a full-team demo of current progress, and opportunity for feedback on the product, then a further retrospective to hone the way we work.
We then planned the day's work and planned for a review and retrospective at the end of the day (4pm Eastern).

Day 1
- Sprint 1 (3 hours)
- Sprint 2 (3 hours)

Day 2
- Sprint 3 (8 hours)
- The goal for this day was to end with a demonstrable slice of the application's functionality, 
connecting the user to the valuable data and visulizations

Day 3
- Sprint 4 (8 hours)
- The goal was to target the full-stack app, running in the production environment, 
with real data shown through the front-end 

Day 4 
- Sprint 5 (8 hours)
- The goal was to, without adding any new functionality, show the application fully integrated for the primary
user scenario

As we executed, we followed a simple pattern: 
 1. Release Planning - Plan each day as a release
 1. Sprint Planning - Plan and execute 1-2 sprints per day, using whole-team estimation and buy-in
 1. Sprint Demonstration - Demo each Sprint's output, receiving feedback from the team and interested parties
 1. Retrospective - Conduct a retrospective after each release, to adapt our work for the next release

**Tracking work**
To guide where we going, the team built user stories and user personas early on, to demonstrate the value proposition of the application.

Work items that supported those stories were captured and tracked. We estimated each task and captured the planned tasks for each sprint. 
We also captured the velocity for each sprint and used that as input into planning our next sprints.

We conducted whole-team planning-poker estimation using Slack, while on a Zoom call together, and tracked details and movement through Waffle.io/GitHub issues. 

User stories are archived on our wiki here - https://github.com/booz-allen-epa-agile-rfi/epa-rfi/wiki/User-Stories

**Team Velocity**

![Velocity](https://docs.google.com/spreadsheets/d/1AAqKoaxrRT1NDnyU7He5MAi4QXazMylVXrlxZimznBI/pubchart?oid=1374894241&format=image)

![Forecast-vs-Delivered](https://docs.google.com/spreadsheets/d/1AAqKoaxrRT1NDnyU7He5MAi4QXazMylVXrlxZimznBI/pubchart?oid=1410313000&format=image)

## Agile Practices Used
1. Ideation/visioning session
1. Pair programming and peer review
1. Kanban board (using Waffle.io)
1. Sprint planning
1. Whole-team planning
1. Timeboxed iterations 
1. Sprint review
1. Distributed face-to-face technology
1. Sprint planning and review
1. Release planning and review
1. User stories
1. Prioritized backlog
1. API-driven development
1. Wireframes/Mockups
1. User-Centered Design (incl. user research, brainstorming, dot-voting, wireframes/mockups, usability testing)
1. Regular user-feedback
1. Test-driven development (TDD)
1. Cross-functional team
1. Retrospectives (after each release)
1. Frequent demos
1. Personas
1. Product Owner
1. Roadmaps
1. Agile estimation (story points)
1. Whole-team, planning poker estimation 

***Plans***

### Sprint 0 Activities
- Hold a team kickoff (1)
- Hold an initial vision/data exploration session (1)

### Day 1 plans
#### Sprint 1 Plan
- Create process document checklist (1)
- Determine domain name (1)
- Mockup landing page (2)
- Wireframe for user interface (1)
- Choose library for map (1)
- Create user scenarios (1)
- Determine how to host data on AWS (1)
- Port reusable code to repository (2)
- Start Jenkins setup (2)
- Choose frontend technologies (1)
- Configure AWS environment (2)

15 pts forecast, 15 pts delivered

#### Sprint 2 Plan
- Prototype Map Layers/Zoom (2)
- Strip reusable codebase to something cleaner (2)
- Meet to decide on Day-1 API endpoints/design (2)
- Initial landing page done on frontend (2) 
- Data loaded into database (1)
- Initial whole-API design (2)
- Decide on filters for map (1)
- Refactor social media user scenario (1)
- Design initial personas (1)
- Finalize user scenarios (1)
- Present branding/identity options (2)
- Determine visualizations based on data (1)
- Wireframe for the map (2)
- Hold meeting between design and frontend (1)
- Have jenkins build on each commit (2) --> Not complete in this sprint

23 pts forecast, 21 pts delivered


### Day 2 plans
#### Sprint 3 Plan
- Wireframe interior pages (1)
- Update user scenarios (1)
- Update license documentation (1)
- Data architecture meeting/review (1)
- Wireframe for About Team page (1)
- Edit landing page for UX changes for filter (2)
- Design additional API endpoints (2)
- Start writing TDD evidence page (1)
- Review data with market team (2)
- Discuss Test-First strategy (1)
- Initial tie of frontend to API (2) --> Not complete in this sprint
- Integrate maps into Angular (2) --> Not complete in this sprint
- Create About Team page (1) --> Not complete in this sprint
- Write Agile Software evidence (2) --> Not complete in this sprint
- Write README.md file (2) --> Not complete in this sprint
- Collect Day 2 documentation artifacts (1) --> Not complete in this sprint

23 pts forecast, 14 pts delivered



### Day 3 plans
#### Sprint 4 Plan
- Tie frontend to API (2) --> Finish from last sprint
- Integrate maps into Angular (2) --> Finish from last sprint
- Create About Team page (1) --> Finish from last sprint
- Write Agile Software evidence (2) --> Finish from last sprint
- Write README.md file (2) --> Finish from last sprint
- Collect Day 2 documentation artifacts (1) --> Finish from last sprint
- Updated developer screenshots for documentation (1)
- Update pivot/persevere documentation (1)
- Create copy for GUI mockups (1)
- Review personas with market team (1)
- Incorporate mockups into frontend code (2)
- Get two filters working on map (3)
- Write user-centered design evidence page (2)
- Deploy frontend to AWS (3)
- Show backend testing (2)
- Show frontend testing (2)

28 pts forecast, 14 pts delivered

### Day 4 plans
#### Sprint 5 Plan
- Tie frontend to API (3)
- Show two filters working on the map (2)
- User-centered design evidence page (2)
- Backend testing (2)
- Frontend testing (3) 
- API updates (2)
- Incorporate mockup updates into frontend, includes copy (3)
- README.md updates (1)

18 pts forecast, 
