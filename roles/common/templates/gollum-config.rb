#!/usr/bin/ruby
require 'gollum/app'

Gollum::Hook.register(:post_commit, :hook_id) do |committer, sha1|
 system('git push origin master')
end
