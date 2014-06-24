##[Generate an Alternate for Lolitas](http://intense-earth-6713.herokuapp.com/)

Queries 4Square for locations near the office open now that have food.


## Endpoints

####/food
Defaults to finding food `open now`
* Add `/&CITY_NAME` to choose a different location

-

####/booze
Defaults to finding bars `open now`
* Add `/&CITY_NAME` to choose a different location

-

####/require
**I require cake!**

Use the `/require/WHAT+YOU+WANT` endpoint to find locations nearby that mention a certain term. *(May not be open now.)*

As will the other enpoints, you can end your query with `/&CITY_NAME` to choose a different location

**Example:**
```
/require/happy+hour&portland
```
