.. warning:: This API is rather unstable, while it is being used in small-scale
             production environments. It is recommended to wait until a stable version
             is released before deploying it for mission-critical systems.

==========
Call Shibe
==========

*WOW*

Simple, open-source, cloud-based VoIP & Telephonic conferencing for humans*

-----
About
-----

Call Shibe is a simple, but effective cloud-based telephone conferencing system.
Aimed at businesses with close relationships with their clients, it has a number of features to help keep conferences effective.

Call Shibe is provided as a stand-alone API, which can be mounted or integrated into another application.

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

* Ruby ( ``>= 1.9`` tested on ``2.0.0-p353`` , ``2.1.2``)
* MongoDB
* A Twilio Account

-----------------
 Getting Started
-----------------

#. Clone this repository
#. Run `bundle install`
#. Set up your MongoDB configuration in ``config/mongoid.yml``
#. Set up your Twilio Credentials, using either ``config/twilio.yml`` or setting ``TWILIO_SID`` and ``TWILIO_TOKEN`` environment variables.
#. Set your environment with the ``RACK_ENV`` environment variable.
#. Run the application with your favourite Rack server, or Passenger.

Don't forget to point Twilio at the following paths to connect it.

Twilio Configuration
^^^^^^^^^^^^^^^^^^^^

It's probably best to set up Call Shibe as a TwiML app, for easier configuration.

Request URL
    ``GET /api/twilio/call-received``

Status Callback URL
    ``GET /api/twilio/call-status``

SMS Request URL
    ``GET /api/twilio/call-status``


Creating an API Access Token
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To use any API methods (with the notable exception of ``/api/ping`` and ``/api/status``, and ``/api/twilio/``, an API Token is required.
For security reasons API Token management is not available via the API, and is provided by a set of Rake tasks.

``rake user:add[:name]``
    Create a user with the unique name ``:name``, which will be assigned an access token, and be automatically enabled.
    It displays the generated access token.

``rake user:list``
    Displays a table of existing users, including name, access key, status and creation timestamp.

``rake user:delete[:name]``
    Delete a user ``:name`` -- This will permanently destory their access key.

``rake user:disable[:name]``
    Disables user ``:name`` -- This does not destory their access key and it can be re-enabled later

``rake user:enable[:name]``
    Enables the user ``:name`` -- Keeping the same acess key

For any API calls which require authentication, supply the API token in the ``Authorization`` HTTP header.

Creating a Known Caller
^^^^^^^^^^^^^^^^^^^^^^^

To create a new caller, just PUT them to ``/api/callers``.

Here's an example ``curl`` command to do it.

   curl -H "Authorization: MY_ACCESS_KEY" -XPUT -dname="My Caller" -dphone_number="+441111222333" http://localhost/api/callers

It's important to set up the caller using an internationalized phone number, otherwise it won't be recognized when they call.
If you want to have this caller automatically connected to a room, just supply the ``auto_join_room`` option.

Here's a summary of options

``name`` *required*
   The name of the caller, this will be used to greet them.

``phone_number`` *required* *unique*
   The callers phone number, this will be used to identify them.

``auto_join_room``
   The room this caller should automatically join when they connect.


Creating a Joinable Room
^^^^^^^^^^^^^^^^^^^^^^^^

If you want to add a room which other callers can join, you can use the ``rooms`` API.
A Room takes the following options:

``name`` *required* *unique*
    The name of the room. *must be unique*

``join_code`` *unique*
    A four digit code needed to join the room, if this is not supplied then the room can only be automatically joined.
    *must be unique or null*


---------------
 API Reference
---------------

A full API reference is available via Swagger.

-------------------------------
 Contributing / Reporting Bugs
-------------------------------

Please report bugs to the Github issues page.
Submit pull requests for changes and fixes.


*While Call Shibe has been designed for humans, it may also work for otherf primates.
Not tested on animals.
