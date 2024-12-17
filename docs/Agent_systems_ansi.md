# [Social Force docs](README.md) - Project classes

In the project part of the course, you will have to create a model, perform simulations, and critically analyze the results.

## Grading

A grade is the mean value of all grades received during the course. In order to complete project class, you need to get a positive grade (at least 3.0) and present the *working* project.

During each class, groups will present their progress so far according to the project schedule. Presentations will be graded. Be prepared for the discussion and questions from the audience!

### 1st meeting - Introduction

General introduction to the field, groups, topics, data, schedule, etc. After this meeting, we should already have groups (2-3 students) and topics. During this gathering, we will discuss the general requirements for each group, and each group will propose the subject of their project.

### 2nd meeting - Presentation of individual schedule

Each group has to present a scope (material and method) and the schedule of the project. The schedule has to include state-of-the-art revision, designing and implementation of the model, model evaluation on actual (real-life) data (or comparison to some published indicators), and presentation of results.

Describe your approach and explain why you have decided to choose a selected model. What are the advantages and disadvantages of your approach? What technology (programming language/modeling environment) are you going to use? Are there any potential difficulties?

### 3rd-5th meeting

Presentation of the progress of the project according to a schedule.

### 6th meeting - the final presentation of the Project

Show your results and answer questions. Prepare a short (about 10 pages) scientific-like article that summarizes your project and results. This paper should use a latex template and consist of a title, authors, introduction with state-of-the-art, scope of the project, material and methods, results, discussion, conclusion and references sections. Publish source code on GitHub and add a link to it in the article.

## Important issues

- You have to finish the coding part (a model must work without breakdowns :-) ).
- You have to validate the model and adjust its parameters based on real data (or known parameters / indicators from literature).
- Note if there are similarities between your model and behaviors that can be observed in real situations.
- Think about the practical application of your model. What sort of analytical questions it is possible to answer using your model? Can you answer them based on your simulation?

## Topics

You are strongly encouraged to propose your own topic.
Keywords: complex systems, agent-based modelling, cellular automata.


1) Tram network simulation (for example in Krak�w) the purpose of the project is to create a simulator of tram network operation. Tram lines are placed on a map and vechicles move along these lines. We assume a real timetable taken from the network. The project should include a prediction of vehicle filling depending on the line, stop and time of day (approximately), the representation of filling can be by color scale.
2) Daily cycle traffic prediction based on Darmstadt data - the model does not need to be accurate (at the level of individual lanes), but should take into account the volume of traffic in different areas of the city depending on the daily cycle. Example data: https://github.com/browarsoftware/darmstadt_download
3) Car traffic prediction - the project includes analysis of car traffic, extraction of basic vehicle attributes and simulation of traffic based on a modified Nagel-Schreckenberg model. The goal of the project will be to track the mechanism of traffic jam formation, and the change in traffic volume in some small part of the road system - comparing actual results and simulations. Example data: https://github.com/browarsoftware/darmstadt_download
4) Simulation of human traffic in a shopping center/gallery (for example, a selected one in Krakow) - the purpose of the project is to create a simulator of customer traffic in a shopping center. The timing of store opening, rush hour, closing should be taken into account.
5) Simulation of a riot in the stands of a football stadium and police intervention - recreate simulation conditions similar to those preceding a riot in the sports stands with the participation of many people. People in the stadium may form fighting groups or want to get out of the facility. The rioters try to control the police trying to chase away or overpower the most aggressive participants. Suggest typical scenarios based on the literature including considering the endings.
6) simulation of a fight in a closed room (bar / club) - recreate simulation conditions similar to those preceding a fight in a closed room with the participation of many people. People in the room may form fighting groups or want to get out of the room. The brawl may involve security guards trying to overpower the most aggressive participants. Propose, based on the literature, typical scenarios including taking into account the endings (for example, escape of one of the parties, successful intervention of security guards).
7) Simulation propagation of information through a large social network that includes both large (having hundreds of thousands of contacts) and small participants. The main thing to consider is the source of the news (what participant in the network is the source of the news) and the varying degree of involvement of the fanbase in the social activity of influencer.
8) It is possible to propose your own theme - feel free to discuss and implement such a project.
