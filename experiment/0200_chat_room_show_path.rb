#!/usr/bin/env ruby
require File.expand_path('../../config/environment', __FILE__)

user = User.create!
chat_room = OwnerRoom.create!
ActionController::Base.relative_url_root = "/shogi"
chat_room.show_path             # => "/shogi/online/battles/14"
