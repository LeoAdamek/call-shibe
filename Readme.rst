==========
Call Shibe
==========

*WOW*

Simple, open-source, cloud-based telephone conferencing for businesses and clients.

-----
About
-----

Call Shibe is a simple, but effective cloud-based telephone conferencing system.
Aimed at businesses with close relationships with their clients, it has a number of features to help keep conferences effective.

Features Included:
^^^^^^^^^^^^^^^^^^

Caller based Auto-join
    Register your client's phone numbers with Call Shibe,
    and have them automatically welcomed and connected to their own conference room.

Rich API
    Call Shibe is built as an API (using Grape), so everything is accessible.

Shibe Powered
    Call Shibe is fully powered by Shibe. Wow, such power, very application, so utilise.


Planned Features
^^^^^^^^^^^^^^^^

Dial-out Invitations
    Simply press the star (``*``) key, and enter a number, and Call Shibe will
    give them a call, and invite them to join the room.

Scheduled Conferences
    Schedule a call in Call Shibe, have an SMS or E-mail reminder sent out,
    to all members, and even give them a call automatically if they're late.

-----------------
 Requirements
-----------------

* Ruby (tested on ``2.0.0-p353``)
* MongoDB
* A Twilio Account

-----------------
 Getting Started
-----------------

#. Clone this repository
#. Run `bundle install`
#. Set up your MongoDB configuration in ``config/mongoid.yml``
#. Set up your Twilio  account credentials in ``config/twilio.yml``
#. Run the application using your favourite Rack server

Don't forget to point Twilio at the following paths:

.. note::
   It's probably best to set up Call Shibe as a TwiML app, for easier configuration.

Request URL
    ``/api/twilio/call-received``

Status Callback URL
    ``/api/twilio/call-status``

SMS Request URL
    ``/api/twilio/call-status``


-------------------------------
 Contributing / Reporting Bugs
-------------------------------

Please report bugs to the Github issues page.
