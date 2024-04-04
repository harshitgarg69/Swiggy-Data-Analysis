SELECT * FROM swiggy.swiggy;

#Q1 HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?

Select count(distinct restaurant_name) as highrates_rest from swiggy.swiggy where rating > 4.5;

#Q2 WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?

select city, count(distinct restaurant_name) as counts from swiggy.swiggy group by city order by counts desc limit 1;

#Q3 HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?

select distinct restaurant_name, count(distinct restaurant_name) from swiggy.swiggy where restaurant_name like '%Pizza%' group by restaurant_name;

# Q4 WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?

select cuisine, count(cuisine) from swiggy.swiggy group by cuisine order by count(cuisine) desc limit 1;

#Q5 WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?

select distinct city, avg(rating) over ( partition by city ) from swiggy.swiggy ;


#Q6 WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENU CATEGORY FOR EACH RESTAURANT?

select distinct restaurant_name, menu_category, max(price) from swiggy.swiggy where menu_category = 'RECOMMENDED' group by restaurant_name, menu_category ;

#Q7 FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE

select distinct restaurant_name, cost_per_person from swiggy.swiggy where cuisine <> 'indian'  order by cost_per_person desc limit 5;

#Q8 FIND THE RESTAURANTS THAT HAVE A COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.


select distinct restaurant_name, cost_per_person from swiggy.swiggy where cost_per_person >(
select avg(cost_per_person) from swiggy.swiggy
) group by restaurant_name, cost_per_person;


#Q9 RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.

select distinct t1.restaurant_name, t1.city, t2.city from swiggy t1 join swiggy t2 using(restaurant_name) where t1.city <> t2.city;


#Q10 WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE CATEGORY?

select restaurant_name, count(item) from swiggy.swiggy where menu_category = 'Main Course' group by restaurant_name order by count(item) desc limit 1;

#Q11 LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME.

select distinct restaurant_name from swiggy.swiggy where `veg_or_non-veg` = 'veg' group by restaurant_name order by restaurant_name asc;

#Q12 WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?

select distinct restaurant_name, avg(price) from swiggy.swiggy group by restaurant_name order by avg(price) ;

#Q13 WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?

select distinct restaurant_name, count(distinct menu_category) from swiggy.swiggy group by restaurant_name order by count(distinct menu_category) desc limit 5;

#Q14 WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?

select distinct restaurant_name , (count(case when `veg_or_non-veg` = 'non-veg'then 1 end)*100/count(*)) as non_veg_perc from swiggy.swiggy group by restaurant_name order by non_veg_perc desc limit 1;
