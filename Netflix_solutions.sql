-- Netflix project 

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

   select * from netflix;

   select count(*) as total_content from netflix;

   select distinct type  from netflix;

  --Business Problems and Solutions
  --1.Count the Number of Movies vs TV Shows

		select type,
		    count(*) as total_content
		from netflix
		group by 1;

  --2. Find the most common Rating for Movies and TV Shows	 
   select type,rating from
   (
       select type,
	   rating,
	   count(*),
	   rank() over(partition by type order by count(*) desc )  as ranking
	   from netflix
	   group by 1,2
	) as t1   
	   where ranking =1
	   
    --3. List All Movies Released in a Specific Year (e.g., 2020)

	 select * from netflix
     where 
	 release_year = 2020   
	 and 
	 type= 'Movie';

	--4. Find the Top 5 Countries with the Most Content on Netflix

     select 
	 unnest(string_to_array (country,',')) as new_country,
	 count(show_id)as total_content
	 from netflix
	 group by 1
	 order by 2 desc
	 limit 5

	 --5. Identify the Longest Movie

        select * from netflix
         where type = 'Movie'
		order by split_part(duration, ' ', 1)::int desc;

		--or

	     select * from netflix
           where type = 'Movie'
		   and duration= (select max(duration) from netflix)


	  --6. Find Content Added in the Last 5 Years 

		 
	     select * from netflix
where to_date(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
         
	  --7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

      select type,director from netflix
	  where director ilike '%Rajiv Chilaka%'

	  --8. List All TV Shows with More Than 5 Seasons

	  select * from netflix
	  where type = 'TV Show'
	  and split_part(duration,' ',1)::numeric > '5'

	  --9. Count the Number of Content Items in Each Genre

	  select
      unnest(string_to_array(listed_in, ',')) AS genre,
      count(*) as total_content
      FROM netflix
      group by 1;
	
	--10. List All Movies that are Documentaries  

	select * from netflix
    where listed_in like '%Documentaries';

	--11. Find All Content Without a Director
	
       select * from netflix
       where director is null;

	--12. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

     select * from netflix
     where casts ilike '%Salman Khan%'
     and release_year > extract(year from current_date) - 10;


	 --13. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India
		
		select
        unnest(string_to_array(casts, ',')) as actor,
		    count(*)
		from  netflix
		where  country ilike 'India'
		group by actor
		order by count(*) desc
		limit 10;

	--14.Find each year and the average numbers of content release in India on netflix.

	    select 
		extract(year from to_date(date_added,'month dd,yyyy') )as year,
		count(*) as yearly_content,
		 round(
        count(*)::numeric /
        (select count(*) from netflix where  country = 'India')::numeric * 100, 2)
        as avg_release
		from netflix
		where country ='India'
		group by 1
		order by 2 desc

		--15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

			
				select 
			    category,
			    count(*) as content_count
			from (
			    select 
			        case 
			            when description ilike '%kill%' or description ilike '%violence%' then 'Bad_content'
			            else 'Good_content'
			        end as category
			    from netflix
			) as categorized_content
			group by 1;

	    