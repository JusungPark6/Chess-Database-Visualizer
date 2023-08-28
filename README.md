# Chess Database Visualizer

Click on the [Wiki](https://github.com/JusungPark6/Database/wiki) for more information on project creation and demonstration.

<img width="833" alt="Screenshot 2023-08-28 at 7 53 19 PM" src="https://github.com/JusungPark6/Database/assets/56177373/3b9e4579-16d1-4473-a115-07e3fbc460a1">


This is the project site for my final project for the class COSC 61: Database System. My goal was to find interesting datasets and design and build a database out of the datasets, explore findings using SQL queries, and add interesting features to the database.

I created a Chess Game Data Visualizer for my Database Systems final project.

I got a dataset of chess games from Kaggle, where I downloaded 2016_CvC.csv, a dataset of all the games played on lichess.com in 2016. This contained around 50,000 entities of chess games and data about them. 

I normalized the data and then imported it into MySQL workbench, created the ERD model, and connected it with AWS Ubuntu EC2 and Amazon RDS.

Since my database contained a bunch of information of chess games, I wanted a way for the chess games to be visualized cleanly on a frontend platform. I used Flask paired with my EC2 instance to code up a frontend web application for the data. 

### Features:
* Three scrollable tables to observe the databases and the relations
* An interactive chessboard that displays any game that is clicked on the table with the game details, and two buttons to traverse through each move of the game
* An input box for SQL queries to make observations regarding the data

Sample questions, SQL queries, and their outputs can be found at the end of the Milestone 4 page.
