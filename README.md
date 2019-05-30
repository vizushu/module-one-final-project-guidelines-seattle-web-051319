![](https://media.giphy.com/media/3lxD1O74siiz5FvrJs/giphy.gif)

# What the application does

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

After adding your api key you need to enter the command rake db:seed in your
terminal so that the database is seeded with the proper information. This command
needs to be entered from the module-one-final-project-guidelines-seattle-web-051319
directory (make sure that you are in the correct directory before entering this
command)

At this point you can run the program using the instructions below.

## How to run it

Run the run.rb file located in the bin folder.

# Contributors Guide

@AustinBH
@vizushu

# License

**License:** [Learn.co License](http://learn.co/content-license)
