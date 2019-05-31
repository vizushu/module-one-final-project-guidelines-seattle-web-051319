# What the application does

**VISUAL REPRESENTATION**

![](https://media.giphy.com/media/NU8tcjnPaODTy/giphy.gif)

This CLI application allows you to see any number of random songs that you wish
up to the total amount of songs in the database. When you see a random song or
songs you will be able to save the song(s) to your likes, dislikes, or return to
the main menu.

From the main menu you have the option to see a random song, view your liked
songs, view your disliked songs, or change your settings.

From the likes and dislikes pages you have the option to remove individual
likes/dislikes and clear all of your likes/dislikes.

The settings page allows you to change the amount of random songs that are
suggested when you request a random song.

# Installation Instructions

![](https://media.giphy.com/media/13HBDT4QSTpveU/giphy.gif)

You will need to populate the database with data from the last.fm api to do that
you first need to follow the instructions below to add your api key.

## How to use your own api key
 --- You will need your own last.fm api key to seed your database with the
 appropriate information

 --- If you do not already have a last.fm api key, you can sign up for an api
 account here: [Last.fm api signup](https://secure.last.fm/login?next=/api/account/create)

 --- In the API_KEY.rb.sample file you can enter your own api key in the
 'your api key here' field

 --- Then save the file as API_KEY.rb (removing the .sample from the end of the
   filename)

 --- This will allow you to populate your database with songs from the last.fm
 api

## Populating the database

Don't be like Drake here, remember to migrate before you seed.

![](https://media.giphy.com/media/kbbwolMdDQKO8p135q/giphy.gif)

After adding your api key you need to enter the commands rake db: migrate then rake db:seed in your
terminal so that the database is seeded with the proper information. These commands
needs to be entered from the module-one-final-project-guidelines-seattle-web-051319
directory (make sure that you are in the correct directory before entering this
command)

At this point you can run the program using the instructions below.

## How to run it

![](https://media.giphy.com/media/gQJyPqc6E4xoc/giphy.gif)

Run the run.rb file located in the bin folder. (Execute Ruby bin/run.rb in your terminal.)

# Contributors Guide

@AustinBH
@vizushu

# License
 
#Learn.co Educational Content License

Copyright (c) 2015 Flatiron School, Inc

The Flatiron School, Inc. owns this Educational Content. However, the Flatiron School supports the development and availability of educational materials in the public domain. Therefore, the Flatiron School grants Users of the Flatiron Educational Content set forth in this repository certain rights to reuse, build upon and share such Educational Content subject to the terms of the Educational Content License set forth here (http://learn.co/content-license). You must read carefully the terms and conditions contained in the Educational Content License as such terms govern access to and use of the Educational Content.

Flatiron School is willing to allow you access to and use of the Educational Content only on the condition that you accept all of the terms and conditions contained in the Educational Content License set forth here (http://learn.co/content-license). By accessing and/or using the Educational Content, you are agreeing to all of the terms and conditions contained in the Educational Content License. If you do not agree to any or all of the terms of the Educational Content License, you are prohibited from accessing, reviewing or using in any way the Educational Content.
