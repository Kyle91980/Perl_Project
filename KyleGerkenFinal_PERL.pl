#! usr\bin\perl

use 5.13.0;
use List::MoreUtils qw(uniq);
use strict;
no warnings;
use Term::Menus;
use Term::ANSIColor;


#Added variables
my $titles;
my $sales;
my $years;
my @titles;
my @sales;
my @years;

my $plat; #platform
my $genre; #genre
my $pub; #publisher
my @temp; my @temp2; my $temp3; my @temp4;
my $line; my $count;
my $fileLine;
my $readArray;
my @platforms; my @genres; my @publishers; 

sub clean {
    my $text = shift;
    $text =~ s/\n//g;
    $text =~ s/\r//g;
    return $text;
}


open (my $data , '<', "vgsales.csv")|| die "could not open vgsales.csv\n$!";

#Opens up the file and brings it into an array

my @array=uniq(<$data>);
# Sorts the array by whichever field you select
# We will do this to get a list of all the platforms, genres, and publishers
# For this file the elements are:
#	0 - Title
#	1 - Unused
#	2 - Platform
#	3 - Genre
#	4 - Publisher
#	5 - Sales
#	6 - Year

# We use @temp and @temp2 as temporary variables while we bring in the data and use uniq to just give us the unique entries

#*************** Added From myself BEGIN *********************
# Get the Title
foreach $line (@array) {
	@temp=split(/\,/,$line);
	push @temp2, $temp[0];
}
@temp = uniq @temp2;
@titles = sort @temp;
@temp = ();
@temp2 = ();

# Get the Sales
foreach $line (@array) {
	@temp=split(/\,/,$line);
	push @temp2, $temp[5];
}
@temp = uniq @temp2;
@sales = sort @temp;
@temp = ();
@temp2 = ();

#Get the Years
foreach $line (@array) {
	@temp=split(/\,/,$line);
	push @temp2, $temp[6];
}
@temp = uniq @temp2;
@years = sort @temp;
@temp = ();
@temp2 = ();

#*************** Added From myself END **************************

#***************** Default Script BEGIN **************************

# Get the Platforms
# Done the long way -- swapping data in and out of the temp arrays for demonstration purposes only
foreach $line (@array) {
	@temp=split(/\,/,$line);
	push @temp2, $temp[2];
}
@temp = uniq @temp2;
@platforms = sort @temp;
@temp = ();
@temp2 = ();


#Get the Genres
# Done the long way -- swapping data in and out of the temp arrays for demonstration purposes only
foreach $line (@array) {
	@temp=split(/\,/,$line);
	push @temp2, $temp[3];
}

@temp = uniq @temp2;
@genres = sort @temp;
@temp = ();
@temp2 = ();

#Get the Publishers
# Done the long way -- swapping data in and out of the temp arrays for demonstration purposes only
foreach $line (@array) {
	@temp=split(/\,/,$line);
	push @temp2, $temp[4];
}

@temp = uniq @temp2;
@publishers = sort @temp;
@temp = ();
@temp2 = ();

#----------------------------------- SUB ROUTINES BEGIN ---------------------------------------------------


#*********** Top 5 by Publisher Function *************************
# 1. Changed the Foreach loop to display the Publishers by displaying the names on separate lines instead of crunched in 1 line thats wrapped.
sub top_5_publisher {
	say "Please select a Publisher from this list";
	foreach my $pub (@publishers) {print "$pub, \n";}
	###my $numcols = 4;
	###while (@publishers) {printf join("\t\t", splice (@publishers,0, $numcols)), "\n";}
	say ""; say ""; say "";
	say "Please select a Publisher from this list";
	my $input = <STDIN>;
	chomp $input;
	# Loops through the array and returns the first 5 values
	# Again - uses temp variables which is messy and for demonstration purposes only.
	foreach $readArray (@array) 
		{ if ($readArray =~ /$input/) 
			{ 	 @temp=split(/\,/,$readArray);
				$temp3 = $temp[0] . "," .  $temp[5] . "," . $temp[4] . "," . $temp[6];
				push @temp2, $temp3;
			}
		}
	if (scalar @temp2 == 0) {say "You selected an invalid option"; exit;}

	say "The top 6 titles for $input were ---";

	my @sorted= uniq(reverse sort {(split(/,/,$a))[1]<=>(split(/,/,$b))[1]} @temp2);

	for ( my $count = 0; $count < 6; $count++) {
		my $titleToSplit = $sorted[$count];
		my @name = split /,/, $titleToSplit;
		my $counter = $count + 1;
		say "The #$counter game from $input was -- $name[0] - Total Sales \$ $name[1] Million";
	}
}



#************* Top 5 by Genre ********************** 
sub top_5_by_genre {
	say "Please select a Genre from this list";
	foreach my $gen (@genres) {print "$gen, ";}
	print "\n";
	my $input = <STDIN>;
	chomp $input;

	# Loops through the array and returns the first 5 values
	# Again - uses temp variables which is messy and for demonstration purposes only.
	# @ name - fields - 0 - Title, 1 - Sales, 2 - Platform, 3 - Year
	foreach $readArray (@array) 
	{ if ($readArray =~ /$input/) 
		{ 	 @temp=split(/\,/,$readArray);
			$temp3 = $temp[0] . "," .  $temp[5] . "," . $temp[2] . "," . $temp[6];
			chomp $temp3;
			push @temp2, $temp3;
		}
	}
		if (scalar @temp2 == 0) {say "You selected an invalid option"; exit;}
	say "The top 5 titles for $input were ---";
	my @sorted=uniq (reverse sort {(split(/,/,$a))[1]<=>(split(/,/,$b))[1]} @temp2);


	for ( my $count = 0; $count < 5; $count++) {
		my $titleToSplit = $sorted[$count];
		chomp $titleToSplit;
		my @name = split /,/, $titleToSplit;
		my $counter = $count + 1;
		say "The #$counter game was $name[0] - Total Sales \$ $name[1] Million - Year $name[3] on $name[2]";
	}
}


#*********** Top 5 Platform ********************
sub top_5_platform {
	say "Please select a Platform from this list";
	foreach my $plat (@platforms) {print "$plat, ";}

	print "\n";
	my $input = <STDIN>;
	chomp $input;

	# Loops through the array and returns the first 5 values
	# Again - uses temp variables which is messy and for demonstration purposes only.
	# @ name - fields - 0 - Title, 1 - Sales, 2 - Platform, 3 - Year
	foreach $readArray (@array) 
	{ if ($readArray =~ /$input/) 
		{ 	
			@temp=split(/\,/,$readArray);

				$temp3 = $temp[0] . "," .  $temp[5] . "," . $temp[2] . "," . $temp[6];
				chomp $temp3;
				push @temp2, $temp3;
		}
	}
	#Error Check if Read was unsuccessful
	if (scalar @temp2 == 0) {say "You selected an invalid option"; exit;}

	#Display top 5 titles
	say "The top 5 titles for $input were ---";

	my @sorted=uniq(reverse sort {(split(/,/,$a))[1]<=>(split(/,/,$b))[1]} @temp2);

	for ( my $count = 0; $count < 5; $count++) {
		my $titleToSplit = $sorted[$count];
		chomp $titleToSplit;
		my @name = split /,/, $titleToSplit;
		my $counter = $count + 1;
		say "The #$counter game for $input was -- Name $name[0] - Total Sales \$ $name[1] Million - Year $name[3]";
	}
}

#****************** Top 5 By Year ***************************************
sub top_5_by_year {
	say "Please select a year between 2011 and 2016"; 
	my $inputYear = <STDIN>;
	chomp $inputYear;
	my $goodYear = 0;
	
	while ($goodYear == 0)
	{
		if ($inputYear >= 2011 && $inputYear <= 2016)
		{
			#exit loop after correct Try
			$goodYear = 1;
		}
		else 
		{
			print "Please select a year between  2011 and 2016\n";
			$inputYear = <STDIN>;
			chomp $inputYear;
		}
	}
	# Loops through the array and returns the first 5 values
	# Again - uses temp variables which is messy and for demonstration purposes only.
	# @ name - fields - 0 - Title, 1 - Sales, 2 - Platform, 3 - Year
	foreach $readArray (@array) 
	{ 
		if ($readArray =~ /$inputYear/) 
		{ 	 
			@temp=split(/\,/,$readArray);
			$temp3 = $temp[0] . "," .  $temp[5] . "," . $temp[2] . "," . $temp[6];
			if ($temp[6] == $inputYear)
			{
				push @temp2, $temp3;
			}
		}
	}
	if (scalar @temp2 == 0) {say "You selected an invalid option"; exit;}

	say "The top 5 titles for $inputYear were ---";

	my @sorted=uniq(reverse sort {(split(/,/,$a))[1]<=>(split(/,/,$b))[1]} @temp2);

	for ( my $count = 0; $count < 5; $count++) {
		my $titleToSplit = $sorted[$count];
		chomp $titleToSplit;
		my @name = split /,/, $titleToSplit;
		my $counter = $count + 1;
		say "The #$counter game in $inputYear was -- $name[0] - Total Sales \$ $name[1] Million on $name[2]";
	}
}


#****************** TOP SALES BY PLATFOMR GIVEN THE YEAR ****************
sub top_5_platform_given_year {
	
	say "Please select a Platform from this list";
	foreach my $plat (@platforms) {print "$plat, ";}

	print "\n";
	my $input = <STDIN>;
	chomp $input;
	
	# goodYear will force the Year input to stay in bounds on selection
	my $goodYear = 0;
	my $inputYear = 0;

	while ($goodYear == 0)
	{
		if ($inputYear >= 1970 && $inputYear <= 2019)
		{
			#exit loop after correct Try
			$goodYear = 1;
		}
		else 
		{
			print "Please select a year between 1970 - 2019\n";
			$inputYear = <STDIN>;
			chomp $inputYear;
		}
	}
	
	# Loops through the array and returns the first 5 values
	# Again - uses temp variables which is messy and for demonstration purposes only.
	# @ name - fields - 0 - Title, 1 - Sales, 2 - Platform, 3 - Year
	foreach $readArray (@array) 
	{ 
		if ($readArray =~ /$input/) 
		{ 	
			@temp=split(/\,/,$readArray);

			$temp3 = $temp[0] . "," .  $temp[5] . "," . $temp[2] . "," . $temp[6];
			chomp $temp3;
			if ($temp[6] == $inputYear)
			{
				push @temp2, $temp3;
			}
		}
	}

	#Error Check if Read was unsuccessful
	if (scalar @temp2 == 0) {say "You selected an invalid option. Your selection had no data available. Try Again."; exit;}

	#Display top 5 titles
	say "The top 5 titles for $input were $inputYear";

	my @sorted=uniq(reverse sort {(split(/,/,$a))[1]<=>(split(/,/,$b))[1]} @temp2);

	for ( my $count = 0; $count < 5; $count++) 
	{
		my $titleToSplit = $sorted[$count];
		chomp $titleToSplit;
		my @name = split /,/, $titleToSplit;
		my $counter = $count + 1;
		say "The #$counter game in $inputYear for $input was -- $name[0] - Total Sales \$ $name[1] Million";
	}
}

#************************ TOP 5 SALES BY GENRE GIVEN THE YEAR *******************

sub top_5_by_genre_given_year {
	say "Please select a Genre from this list:\n";
	foreach my $gen (@genres) {print "$gen, ";}

	print "\n";
	my $input = <STDIN>;
	chomp $input;

	# goodYear will force the Year input to stay in bounds on selection
	my $goodYear = 0;
	my $inputYear = 0;

	while ($goodYear == 0)
	{
		if ($inputYear >= 1970 && $inputYear <= 2019)
		{
			#exit loop after correct Try
			$goodYear = 1;
		}
		else
		{
			print "Please select a year between 1970 - 2019\n";
			$inputYear = <STDIN>;
			chomp $inputYear;
		}
	}

	# Loops through the array and returns the first 5 values
	# Again - uses temp variables which is messy and for demonstration purposes only.
	# @ name - fields - 0 - Title, 1 - Sales, 2 - Platform, 3 - Year
	foreach $readArray (@array) 
	{ 
			if ($readArray =~ /$input/) 
			{ 	 
				@temp=split(/\,/,$readArray);
				$temp3 = $temp[0] . "," .  $temp[5] . "," . $temp[2] . "," . $temp[6];
				chomp $temp3;
				if ($temp[6] == $inputYear)
				{
					push @temp2, $temp3;
				}
			}
	}

	if (scalar @temp2 == 0) {say "You selected an invalid option"; exit;}

	say "The top 5 titles for $input were ---";

	my @sorted=uniq (reverse sort {(split(/,/,$a))[1]<=>(split(/,/,$b))[1]} @temp2);

	for ( my $count = 0; $count < 5; $count++) 
	{
		my $titleToSplit = $sorted[$count];
		chomp $titleToSplit;
		my @name = split /,/, $titleToSplit;
		my $counter = $count + 1;
		say "The #$counter $input game was -- $name[0] - Total Sales \$ $name[1] Million - Year $name[3] on $name[2]";
	}
}


#********************** TOP 5 PUBLISHER BY YEAR ****************************

sub top_5_by_publisher_given_year
{
	say "Please select a Publisher from this list";
	foreach my $pub (@publishers) {print "$pub, \n";}

	###my $numcols = 4;
	###while (@publishers) {printf join("\t\t", splice (@publishers,0, $numcols)), "\n";}

	say ""; say ""; say "";

	say "Please select a Publisher from this list";
	my $input = <STDIN>;
	chomp $input;

	# goodYear will force the Year input to stay in bounds on selection
	my $goodYear = 0;
	my $inputYear = 0;

	while ($goodYear == 0)
	{
		if ($inputYear >= 1970 && $inputYear <= 2019)
		{
			#exit loop after correct Try
			$goodYear = 1;
		}
		else
		{
			print "Please select a year between 1970 - 2019\n";
			$inputYear = <STDIN>;
			chomp $inputYear;
		}
	}


	# Loops through the array and returns the first 5 values
	# Again - uses temp variables which is messy and for demonstration purposes only.
	foreach $readArray (@array) 
	{ 
		if ($readArray =~ /$input/) 
		{ 	 @temp=split(/\,/,$readArray);
			$temp3 = $temp[0] . "," .  $temp[5] . "," . $temp[2] . "," . $temp[6];
			chomp $temp3;
			if ($temp[6] == $inputYear)
			{
				push @temp2, $temp3;
			}
		}
	}
	if (scalar @temp2 == 0) {say "You selected an invalid option"; exit;}

	say "The top 5 titles for $input were ---\n";

	my @sorted= uniq(reverse sort {(split(/,/,$a))[1]<=>(split(/,/,$b))[1]} @temp2);

	for ( my $count = 0; $count < 6; $count++) {
		my $titleToSplit = $sorted[$count];
		my @name = split /,/, $titleToSplit;
		my $counter = $count + 1;
		say "The #$counter Game by $input in $inputYear was -- Name $name[0] - Total Sales \$ $name[1] Million";
	}
}


#*************************** GAME WITH HIGHEST SALE ***********************
sub highest_game 
{
	print "The highest game was :\n\n";
	my @sorted=reverse sort {(split(/,/,$a))[5]<=>(split(/,/,$b))[5]} @array;
	my $titleToSplit = $sorted[$0];
	#chomp $titleToSplit;
	clean $titleToSplit;

	my @name = split /,/, $titleToSplit;
	print "The Game: $name[0] with the highest sale of \%$name[5] -- Publisher: $name[4] | Platform: $name[2] | Year: $name[6]";
	#print "the Platform $name[2] with sales of $name[5] for Title $name[0] in Year $name[6]" . "\n";
}


#*************************** GAME WITH LOWEST SALE ***********************
sub lowest_game 
{
	print "The lowest Game was:\n";
	my @sorted=sort {(split(/,/,$a))[5]<=>(split(/,/,$b))[5]} @array;
	my $titleToSplit = $sorted[$0];
	#chomp $titleToSplit;
	clean $titleToSplit;

	my @name = split /,/, $titleToSplit;
	print "The Game: $name[0] with the lowest sale of \%$name[5] -- Publisher: $name[4] | Platform: $name[2] | Year: $name[6]";
	
}

#*********** HIGHEST SALES BY PLATFORM **************
sub highest_platform {
	print "The highest platform was ";
	my @sorted=reverse sort {(split(/,/,$a))[5]<=>(split(/,/,$b))[5]} @array;
	my $titleToSplit = $sorted[$0];
	#chomp $titleToSplit;
	clean $titleToSplit;
	my @name = split /,/, $titleToSplit;

	print $name[2] . "\n";
	say "The Game --  $name[0] with highest sales of \%$name[5] -- Publisher: $name[4] | Year $name[6]" . "\n";
}


#******************** LOWEST SALES BY PLATFORM *************
sub lowest_platform {
	print "The lowest platform was ";
	my @sorted=sort {(split(/,/,$a))[5]<=>(split(/,/,$b))[5]} @array;
	my $titleToSplit = $sorted[0];


	#chomp $titleToSplit;
	clean $titleToSplit;
	my @name = split /,/, $titleToSplit;


	print $name[2] . "\n";
	say "The Game -- $name[0] with highest sales of \%$name[5] -- Publisher: $name[4] | Year $name[6]" . "\n";
}



#****************** HIGHEST SALES BY YEAR ***********************
sub highest_year {
	print "The highest sale in year ";
	my @sorted=reverse sort {(split(/,/,$a))[5]<=>(split(/,/,$b))[5]} @array;
	my $titleToSplit = $sorted[0];


	#chomp $titleToSplit;
	clean $titleToSplit;
	my @name = split /,/, $titleToSplit;


	print $name[6] . "\n";

	say "The Game -- $name[0] with highest sales of \%$name[5] -- Publisher: $name[4] | Platform: $name[2]" . "\n";
}

#****************** LOWEST SALES BY YEAR ***********************
sub lowest_year {
	print "The lowest sale in year ";
	my @sorted=sort {(split(/,/,$a))[5]<=>(split(/,/,$b))[5]} @array;
	my $titleToSplit = $sorted[0];


	#chomp $titleToSplit;
	clean $titleToSplit;
	my @name = split /,/, $titleToSplit;


	print $name[6] . "\n";

	say "The Game -- $name[0] with lowest sales of \%$name[5] -- Publisher: $name[4] | Platform: $name[2]" . "\n";
}


#************************ SHOW ALL / SHOW ALL REVERSE **********************

sub show_all 
{
	my @sorted=sort {(split(/,/,$a))[5]<=>(split(/,/,$b))[5]} @array;
	foreach my $sort1 (@sorted) 
	{
		say $sort1;
	}
}
	

sub show_all_rev 
{
	my @sorted=reverse sort {(split(/,/,$a))[5]<=>(split(/,/,$b))[5]} @array;
	foreach my $sort1 (@sorted) 
	{
		say $sort1; 
	}
}

#*********************** SUB ROUTINES END ******************************

#************************* MENU SELECTION BEGIN ****************************
	
# Menu for User Selection


my @list=('Top 5 Sales by Platform', 'Top 5 Sales by Year', 'Top 5 Sales by Genre','Top 6 Sales by Publisher','Top 5 Sales by Platform given the Year','Top 5 Sales by Genre given the Year','Top 6 Sales by Publisher given the Year','Game with Highest Sale','Game with Lowest Sale','Platform with Highest Sale', 'Platform with Lowest Sale','Year with Highest Sales', 'Year with Lowest Sales');
#my @list=('Top 5 by Publisher','Top 5 by Genre','Top 5 by Platform','Top 5 by year','Titles with highest','Titles with lowest','Platform with highest', 'Platform with lowest', 'All data - testing only', 'All data - reversed');

my $banner="  Please Pick an Item:";
my $selection=&pick(\@list,$banner);


if ($selection eq "Top 5 Sales by Platform") 
	{top_5_platform;}
if ($selection eq "Top 5 Sales by Genre") 
	{top_5_by_genre;}
if ($selection eq "Top 5 Sales by Year")
	{top_5_by_year;}
if ($selection eq "Top 6 Sales by Publisher") 
	{top_5_publisher;}

if ($selection eq "Top 5 Sales by Platform given the Year")
	{top_5_platform_given_year;}
if ($selection eq "Top 5 Sales by Genre given the Year")
	{top_5_by_genre_given_year;}
if ($selection eq "Top 6 Sales by Publisher given the Year")
	{top_5_by_publisher_given_year;}

if ($selection eq "Game with Highest Sale")
	{highest_game;}
if ($selection eq "Game with Lowest Sale")
	{lowest_game;}

if ($selection eq "Platform with Highest Sale")
	{highest_platform;}
if ($selection eq "Platform with Lowest Sale")
	{lowest_platform;}

if ($selection eq "Year with Highest Sales")
	{highest_year;}
if ($selection eq "Year with Lowest Sales")
	{lowest_year;}



#if ($selection eq "All data - testing only")
#	{show_all;}
#if ($selection eq "All data - reversed")
#	{show_all_rev;}



#************************* MENU SELECTION END ****************************