# Kyle Gerken -- PERL Project Final

- Use the vgsalses.csv file to create a script that display the following. For all list of sales for the world

## Task List to Complete:

1. Top 5 Sales by **Publisher**:
2. Top 5 Sales by **Year**
3. Top 5 Sales by **Genre**
4. Top 6 Sales by **Publisher**
5. Top 5 Sales by **Platform given the Year**
6. Top 5 Sales by **Genre given the Year**
7. Top 6 Sales by **Publisher given the Year**
8. **Game** with the **Highest** Sale
9. **Game** with the **Lowest** Sale
10. **Platform** with the **Highest** Sale
11. **Platform** with the **Lowest** Sale 
12. **Year** with the **Highest** Sale
13. **Year** with the **Lowest** Sale


## Important Notes to Reference:
| Array Values | Pair with Read Values |
| --------------- |---------------------|
|   0   |   Title   |
|   1   |   Unused  |
|   2   |   Platform    |
|   3   |   Genre   |  
|   4   |   Publisher   |
|   5   |   Sales   |
|   6   |   Years   |


## Major Changes made to script
- First thing I did was format and strucutre the code to be easier to read for myself.
- At the top of the page I added any variable declarations that I felt I could use. Although I didn't use a few I kept them for future reference and practice on reading input from an Array.
- I added Read input of Title, Sales, and Years in the beggining code labeled. These were the file read values I ended up not using.
- The Top 5: Publisher, Year, Genre, and Platform, I kept partially the same as the default. I changed Publisher's output to display 6 values instead of 5. And added a logic gate to Year to prompt the user to select a year between 2011 and 2016
- The Top 5 by (Platform, Genre, Publisher) given the year, I added again the simple logic gate the prompt the user to input a selected year. This time the range was between 1970 and 2019 because that was the range provided in the 'vgsales.csv' file.
    - I also added another conditional:
    ```
    if ($temp[6] == $inputYear)
    {
        push @temp2, $temp3;
    }
    ```
    - I'm not sure if this was the best option to try but I made th emost sense so only the $inputYear was pushed onto the @temp2 array.

- For the Highest && Lowest values of Platform, Year, Publisher, and Game I mainly changed the display of how the selected Print would look.
- Finally I modified the menu to outpur parrallel to the directions. I also reorganized the originial code to also mimic the PDF of the directions. 