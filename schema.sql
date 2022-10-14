-- NOTE: In the comments above each table, capital letters indicate underlines (i.e., primary keys), since plaintext can't contain underlines.

-- game(GAME_NUMBER, winner_id, loser_id, winner_score, loser_score, date, location)
CREATE TABLE game(
    game_number integer PRIMARY KEY,
    winner_id integer, -- Foreign key to teams (cannot be NULL)
    loser_id integer, -- Foreign key to teams (cannot be NULL or the same as winner_id)
    winner_score integer,
    loser_score integer,
    date varchar(10), -- Formatted as YYYY/MM/DD (always 10 characters)
    location varchar(50)
);

-- game_attendance(GAME_ID, USER_ID)
CREATE TABLE game_attendance(
    game_id integer, -- Foreign key to game
    user_id integer, -- Foreign key to user
    PRIMARY KEY (game_id, user_id)
);

-- challenge(CHALLENGE_NUMBER, challenger_id, receiver_id, status, game_id, date_issued, game_date)
CREATE TABLE challenge(
    challenge_number integer PRIMARY KEY,
    challenger_id integer, -- Foreign key to teams (cannot be NULL)
    receiver_id integer, -- Foreign key to teams (cannot be NULL or the same as challenger_id)
    status varchar(9), -- PENDING, ACCEPTED, REJECTED, WITHDRAWN
    game_id integer, -- Foreign key to teams. If status is not ACCEPTED, then this field is NULL
    date_issued varchar(10), -- Formatted as YYYY/MM/DD (always 10 characters)
    game_date varchar(10) -- Formatted as YYYY/MM/DD (always 10 characters). This is the proposed date for the game.
);

-- practice(PRACTICE_ID, team_id, date, location)
CREATE TABLE practice(
    practice_id integer PRIMARY KEY,
    team_id integer, -- Foreign key to teams (cannot be NULL)
    date varchar(10), -- Formatted as YYYY/MM/DD (always 10 characters)
    location varchar(50)
);

-- practice_attendance (PRACTICE_ID, USER_ID)
CREATE TABLE practice_attendance(
    practice_id integer, -- Foreign key to practice
    user_id integer, -- Foreign key to user
    PRIMARY KEY (practice_id, user_id)
);

-- team(TEAM_ID, name, date_formed, location)
CREATE TABLE team(
    team_id integer PRIMARY KEY,
    name varchar(50), -- Should be unique
    date_formed varchar(10), -- Formatted as YYYY/MM/DD (always 10 characters)
    location varchar(50)
);

-- user(USER_ID, user_name, user_email, team_id, role, hashword)
CREATE TABLE user(
    user_id integer PRIMARY KEY,
    user_name varchar(50),
    user_email varchar(50), -- Must be unique for each user but can be changed in the future
    team_id integer, -- Foreign key to teams (NULL for admins and referees)
    role varchar(12), -- PLAYER, TEAM ADMIN, REFEREE, SYSTEM ADMIN
    hashword varchar(50) -- Hashed user password
);

-- message(MESSAGE_ID, user_id, team_id, text, time_sent, status)
CREATE TABLE message(
    message_id integer PRIMARY KEY, -- This is used in case system lag causes multiple messages from one user to arrive simultaneously
    user_id integer, -- Foreign key to user
    team_id integer, -- Foreign key to teams (NULL for messages to general chat)
    text varchar(200),
    time_sent integer, -- Use UNIX time here. This is used to order messages
    status varchar(13) -- SENT, DELETED, ADMIN DELETED
);

-- join_req(REQ_ID, req_name, req_role, team_id, req_date, status)
CREATE TABLE join_req(
    req_id integer PRIMARY KEY, -- Names are not unique, so they can't be used in a primary key (this is why we have user.user_id)
    req_name varchar(50), -- Name of user requesting to join a team
    req_role varchar(12), -- PLAYER, TEAM ADMIN, REFEREE, SYSTEM ADMIN
    team_id integer, -- Foreign key to teams (NULL for referee requests)
    req_date varchar(10), -- Formatted as YYYY/MM/DD (always 10 characters)
    status varchar(8) -- PENDING, ACCEPTED, REJECTED
);