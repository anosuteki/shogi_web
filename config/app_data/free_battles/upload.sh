#!/bin/sh
rsync -azu --delete 0*.kif s:/var/www/shogi_web_production/current/config/app_data/free_battles
bundle exec cap production rails:runner CODE='FreeBattle.setup'
# bundle exec cap production rails:runner CODE='FreeBattle.ransack(title_cont: "実戦詰め筋事典").result.update_all(start_turn: 0)'

