# Netflix_sql_project
# Netflix dataset analysis using SQ Language 
![Netflix Logo](https://github.com/ritzuuu/netflix_sql_project/blob/main/logo.png)
# Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.
# Objectives
Analyze the distribution of content types (movies vs TV shows).
Identify the most common ratings for movies and TV shows.
List and analyze content based on release years, countries, and durations.
Explore and categorize content based on specific criteria and keywords.
# Dataset
[movies dataset]
The data for this project is sourced from the Kaggle dataset:
**Dataset Link:** (#!/bin/bash
curl -L -o ~/Downloads/netflix-shows.zip\
  https://www.kaggle.com/api/v1/datasets/download/shivamb/netflix-shows)
# Schema
'''sql
create table netflix
   (
		 show_id varchar(6) ,
		 type	 varchar(10),
		 title	 varchar(150),
		 director varchar(208),
		 casts	 varchar(1000),
		 country	varchar(150),
		 date_added	 varchar(50),
		 release_year	int ,
		 rating       varchar(10),
		 duration  varchar(15),	
		 listed_in	varchar(100),
		 description varchar(250)

   );
'''

