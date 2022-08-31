#!/bin/bash

cd /home/cstrike/steamcmd/csgoserver

script /dev/null

screen -S csgo

./srcds_run -game csgo +sv_setsteamaccount 59E73B11466F7BEA320FEDA39C2757E6 -net_port_try -console -usercon -tickrate 128 +game_type 1 +game_mode 2 +sv_game_mode_flags 32 +mapgroup mg_active +map de_mirage
